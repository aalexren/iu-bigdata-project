import streamlit as st
import pandas as pd
import altair as alt

q1 = pd.read_csv("output/q1.csv")
q2 = pd.read_csv("output/q2.csv")
q3 = pd.read_csv("output/q3.csv")
q4 = pd.read_csv("output/q4.csv")
q5 = pd.read_csv("output/q5.csv")

st.title("# Big Data Project  \n :alien:_Bank Loan Suggestion Classification_ :alien:  \n *Year*: **2023**")

st.markdown("---")

st.header("Data Characteristics")

st.subheader("Data Types")

st.write("Bank_Loan_Default_EDA dataset columns are presented in 3 data types:")
emps_dda = pd.DataFrame(data = [[46, 73, 24]], columns = ["Integer", "Float", "String"])
st.table(emps_dda)

st.subheader("Columns")
st.write("There are 122 columns and more than 300k rows of data")

st.subheader("Data columns")
emp_da = pd.DataFrame(data=[["",""]], columns = ["day_birth", "days_employed"])
st.write("`day_birth`, `days_employed`")
st.table(emp_da)


st.markdown('---')
st.header("Exploratory Data Analysis")


st.subheader('Q1')
st.write(":credit_card:Ratio of people with the ratio of loan amount and income, less than  \n average ratio over all people whose request was accepted:dollar:")

st.table(q1)

st.write("We can see there that ~61% of approved loans were given to people whose ratio of loan_amount to their income are lower than avearge ration of all approved loans")

st.subheader('Q2')
st.write(":x::baby::x: Ratio of people with approved loans without children among all approved loans :x::baby::x: : children0_target1_ratio")
st.write(":baby: Ratio of people with approved loans with children aong all approved loans :baby: : children1_target1_ratio")

st.table(q2)

st.markdown("""
<style>#my-pie-chart {border-radius: 50%; background: conic-gradient(blue 0.55% {0}%, red {1}%);}</style>
<div id="my-pie-chart"></div>
""".format(q2.head(1)["children0_target1_ratio"], q2.head(1)["children1_target1_ratio"]), unsafe_allow_html=True)
st.markdown("""mermaid
pie
    title Pie Chart
    "children0_target1_ratio" : {0}
    "children1_target1_ratio" : {1} 
""".format(q2.head(1)["children0_target1_ratio"],q2.head(1)["children1_target1_ratio"]))

st.write("The insight show us that 75% of approved loans were given to people who don't have children")

st.subheader('Q3')
st.write(":computer:Ratio of people with approved loans who are working:hammer:: woking_ratio_target1")

st.table(q3)
st.bar_chart(q3)
st.write("As a result, 61% of loans, were given to working people, and rest 39 % are splitted between 'State servant', 'Student', 'Maternity leave', 'Pensioner', 'Businessman', 'Unemployed' and 'Commercial associate'")


st.subheader('Q4')
st.write(":boy:Distribution of approved loans between ages starting from 21 with the step 10:older_man:")

st.table(q4)
st.bar_chart(q4)
st.write("By the insight we can see that 62% of loans was approved to people of age between 30 and 40, and 24% between age 21 and 30")

st.subheader('Q5')
st.write(":house: Distribution of approved loans between place of relocation :house:")

st.table(q5)
st.bar_chart(q5)
st.write("We can see there that people who leave in house\apartment get approved the loan as there are 85% of them. Also ~7% of people who live with parents")

st.markdown('---')
st.header('Predictive Data Analytics')
st.subheader('ML Model')
st.markdown('1. Logistic Regression Model')


st.markdown('2. Decision tree classifier')

st.subheader('Results')
st.text('Resluted metrics: ROC-AUC, PR-AUC')
st.text("ROC-AUC: True positive rate to false positive rate")
st.text("PR-AUC: Precision-Recall Curve")

st.table(pd.DataFrame(data=[[0.61, 0.62]], columns=["ROC-AUC", "PR_AUC"]))


