"""
Preprocess data frames using pandas.
"""
import os
import sys

import pandas as pd

DATA_DIR = sys.argv[1]
FILES = ["application_data.csv", "previous_application.csv"]

print "READ %s" % (FILES[0])
app_data_df = pd.read_csv(os.path.join(DATA_DIR, FILES[0]))
print "READ %s" % (FILES[1])
pre_appl_df = pd.read_csv(os.path.join(DATA_DIR, FILES[1]))

# pre_appl_df[~pre_appl_df["SK_ID_CURR"].isin(app_data_df["SK_ID_CURR"])]
# cond = pre_appl_df["SK_ID_CURR"].isin(app_data_df["SK_ID_CURR"])
# pre_appl_df.drop(pre_appl_df[cond].index, inplace=True)
print "DELETE NOT EXISTING VALUES"
pre_appl_df = pre_appl_df[pre_appl_df["SK_ID_CURR"].isin(app_data_df["SK_ID_CURR"])]

print "SAVE NEW CSV TO %s" % (FILES[1])
pre_appl_df.to_csv(os.path.join(DATA_DIR, FILES[1]), index=False)
