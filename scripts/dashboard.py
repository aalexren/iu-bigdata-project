import streamlit as st
import pandas as pd

st.title("# Big Data Project  \n :alien:_Bank Loan Suggestion Classification_ :alien:  \n *Year*: **2023**")

st.markdown("---")

st.header("Data Characteristics")

st.subheader("Data Types")

st.write("Bank_Loan_Default_EDA dataset consists of 3 data types:")
emps_dda = pd.DataFrame(data = [[46, 73, 24]], columns = ["Integer", "Float", "String"])
st.write(emps_dda)

st.subheader("Columns")
st.write("There are 122 columns and more than 300k rows of data")


st.markdown('---')
st.header("Exploratory Data Analysis")


st.subheader('Q1')
st.write(":credit_card:Ratio of people with the ratio of loan amount and income, less than  \n average ratio over all people whose request was accepted:dollar:")

#pandas
st.write("We can see there that ~61% of approved loans were given to people whose ratio of loan_amount to their income are lower than avearge ration of all approved loans")

st.subheader('Q2')
st.write(":x::baby::x: Ratio of people with approved loans without children among all approved loans :x::baby::x: : children0_target1_ratio")
st.write(":baby: Ratio of people with approved loans with children aong all approved loans :baby: : children1_target1_ratio")

#pandas
st.write("The insight show us that 75% of approved loans were given to people who don't have children")

st.subheader('Q3')
st.write(":computer:Ratio of people with approved loans who are working:hammer:: woking_ratio_target1")

#pandas
st.write("As a result, 61% of loans, were given to working people, and rest 39 % are splitted between 'State servant', 'Student', 'Maternity leave', 'Pensioner', 'Businessman', 'Unemployed' and 'Commercial associate'")


st.subheader('Q4')
st.write(":boy:Distribution of approved loans between ages starting from 21 with the step 10:older_man:")

#pandas
st.write("By the insight we can see that 62% of loans was approved to people of age between 30 and 40, and 24% between age 21 and 30")

st.subheader('Q5')
st.write(":house: Distribution of approved loans between place of relocation :house:")

#pandas
st.write("We can see there that people who leave in house\apartment get approved the loan as there are 85% of them. Also ~7% of people who live with parents")

st.markdown('---')
st.header('Predictive Data Analytics')
st.subheader('ML Model')
st.markdown('1. Logistic Regression Model')
st.markdown('Settings of the model')


st.markdown('2. Decision tree classifier')
st.markdown('Settings of the model')


st.subheader('Results')
st.text('Resluted metrics: ROC-AUC, PR-AUC')
st.text("ROC-AUC: True positive rate to false positive rate")
st.text("PR-AUC": Precision-Recall Curve)

st.table(pd.DataFrame([]))
st.markdown('<center>Results table</center>', unsafe_allow_html = True)
st.subheader('Training vs. Error chart')
st.write("matplotlib or altair chart")
st.subheader('Prediction')
st.text('Given a sample, predict its value and display results in a table.')
st.text('Here you can use input elements but it is not mandatory')
