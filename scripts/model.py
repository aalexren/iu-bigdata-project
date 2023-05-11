"""some useful info
"""
from __future__ import print_function

import pyspark.sql.functions as F
from pyspark.sql import SparkSession

from pyspark.ml import Pipeline
from pyspark.ml.tuning import CrossValidator, ParamGridBuilder
from pyspark.ml.feature import StringIndexer, Imputer, MinMaxScaler, VectorAssembler
from pyspark.ml.evaluation import BinaryClassificationEvaluator
from pyspark.ml.classification import LogisticRegression, DecisionTreeClassifier

spark = (
    SparkSession.builder.appName("BD Project")
    .master("local[4]")
    .config("spark.driver.memory", "4g")
    .config("spark.sql.catalogImplementation", "hive")
    .config("hive.metastore.uris", "thrift://sandbox-hdp.hortonworks.com:9083")
    .config("spark.sql.avro.compression.codec", "snappy")
    .config(
        "spark.jars",
        "/usr/hdp/current/hive-client/lib/"\
        "hive-metastore-1.2.1000.2.6.5.0-292.jar,"\
        "/usr/hdp/current/hive-client/lib/hive-exec-1.2.1000.2.6.5.0-292.jar",
    )
    .config("spark.jars.packages", "org.apache.spark:spark-avro_2.11:2.4.4")
    .enableHiveSupport()
    .getOrCreate()
)

sc = spark.sparkContext
sc.setLogLevel("OFF")

print(spark.catalog.listDatabases())

print(spark.catalog.listTables("projectdb"))

app_data = spark.read.format("avro").table("projectdb.application_data")
app_data.createOrReplaceTempView("app_data")

prev_app = spark.read.format("avro").table("projectdb.previous_application")
prev_app.createOrReplaceTempView("prev_app")

categorical_features = [
    "name_contract_type",
    "code_gender",
    "flag_own_car",
    "flag_own_realty",
    "name_type_suite",
    "name_income_type",
    "name_education_type",
    "name_family_status",
    "name_housing_type",
    "occupation_type",
    "weekday_appr_process_start",
    "organization_type",
    "fondkapremont_mode",
    "housetype_mode",
    "wallsmaterial_mode",
    "emergencystate_mode",
]

for feature in categorical_features:
    indexer = StringIndexer(inputCol=feature, outputCol="%s_enc" % feature)
    indexer = indexer.setHandleInvalid("keep")
    indexer = indexer.fit(app_data)
    app_data = indexer.transform(app_data)

app_data = app_data.drop(*categorical_features)

app_data = app_data.select(*(F.col(c).cast("float").alias(c) for c in app_data.columns))

imputation_columns = list(set(app_data.columns) - set(["sk_id_curr"]))

imputer = Imputer(
    inputCols=imputation_columns,
    outputCols=["{}_imputed".format(c) for c in imputation_columns],
).setStrategy("median")

app_data = imputer.fit(app_data).transform(app_data)

app_data = app_data.drop(*imputation_columns)

app_data = app_data.drop("sk_id_curr")

app_data.limit(2).show()

to_transform_cols = list(set(app_data.columns) - set(["target_imputed"]))

assembler = [
    VectorAssembler(inputCols=[col], outputCol=col + "_vec")
    for col in to_transform_cols
]
scalers = [
    MinMaxScaler(inputCol=col + "_vec", outputCol=col + "_scaled")
    for col in to_transform_cols
]

pipeline = Pipeline(stages=assembler + scalers)
model = pipeline.fit(app_data)
data = model.transform(app_data)

to_drop_cols = set(data.columns) - set(["target_imputed"])
to_drop_cols = [
    x for x in to_drop_cols if not x[::-1].startswith("scaled"[::-1])
]
data = data.drop(*to_drop_cols)
data = data.withColumnRenamed("target_imputed", "label")

feature_cols = list(set(data.columns) - set(["label"]))

assembler = VectorAssembler(inputCols=feature_cols, outputCol="features")

pipeline = Pipeline(stages=[assembler])
model = pipeline.fit(data)
data = model.transform(data)

df = data.select(["label", "features"])
train_data, test_data = df.randomSplit([0.7, 0.3], seed=42)

roc_evaluator = BinaryClassificationEvaluator(
    labelCol="label", rawPredictionCol="prediction", metricName="areaUnderROC"
)

pr_evaluator = BinaryClassificationEvaluator(
    labelCol="label", rawPredictionCol="prediction", metricName="areaUnderPR"
)

lr = LogisticRegression()
grid = (
    ParamGridBuilder()
    .addGrid(lr.regParam, [0.0, 0.1, 1.0])
    .addGrid(lr.elasticNetParam, [0.0, 1.0])
    .build()
)
cv = CrossValidator(
    estimator=lr,
    estimatorParamMaps=grid,
    evaluator=roc_evaluator,
    parallelism=2,
    numFolds=4,
)
cvModel = cv.fit(train_data)

# Predict data
predictions = cvModel.transform(test_data)

# Evaluation
roc = roc_evaluator.evaluate(predictions)
print("Area under ROC curve on test data Logistic Regression = %g" % roc)

pr = pr_evaluator.evaluate(predictions)
print("Area under PR curve on test data Logistic regression = %g" % pr)

lr_best_model = cvModel.bestmodel
lr_best_model.save("models/lr")

predictions.coalesce(1).select("prediction", "label").write.mode("overwrite").format(
    "csv"
).option("sep", ",").option("header", "true").csv("output/lr_predictions.csv")

spark.createDataFrame(
    data=[["ROC", roc], ["PR", pr]], schema=["metric", "value"]
).coalesce(1).write.mode("overwrite").format("csv").option("sep", ",").option(
    "header", "true"
).csv(
    "output/lr_scores"
)

dt = DecisionTreeClassifier()
grid = (
    ParamGridBuilder()
    .addGrid(dt.maxDepth, [5, 10, 20])
    .addGrid(dt.maxBins, [32, 64])
    .build()
)
cv = CrossValidator(
    estimator=dt,
    estimatorParamMaps=grid,
    evaluator=roc_evaluator,
    parallelism=2,
    numFolds=4,
)
cvModel = cv.fit(train_data)

# Predict data
predictions = cvModel.transform(test_data)

# Evaluate
roc = roc_evaluator.evaluate(predictions)
print("Area under ROC on test data Decision Tree Classifier = %g" % roc)

pr = pr_evaluator.evaluate(predictions)
print("Area under PR on test data Decision Tree Classifier = %g" % pr)

dt_best_model = cvModel.bestmodel
dt_best_model.save("models/dt")

predictions.coalesce(1).select("prediction", "label").write.mode("overwrite").format(
    "csv"
).option("sep", ",").option("header", "true").csv("output/dt_predictions.csv")

spark.createDataFrame(
    data=[["ROC", roc], ["PR", pr]], schema=["metric", "value"]
).coalesce(1).write.mode("overwrite").format("csv").option("sep", ",").option(
    "header", "true"
).csv(
    "output/dt_scores"
)
