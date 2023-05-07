"""
Preprocess data frames using pandas.
"""

from __future__ import print_function

import os
import sys

import pandas as pd

DATA_DIR = sys.argv[1]
FILES = ["application_data.csv", "previous_application.csv"]

print("READ %s" % (FILES[0]))
APP_DATA_DF = pd.read_csv(os.path.join(DATA_DIR, FILES[0]))
print("READ %s" % (FILES[1]))
PRE_APPL_DF = pd.read_csv(os.path.join(DATA_DIR, FILES[1]))

print("DELETE NOT EXISTING VALUES")
PRE_APPL_DF = PRE_APPL_DF[PRE_APPL_DF["SK_ID_CURR"].isin(APP_DATA_DF["SK_ID_CURR"])]

print("SAVE NEW CSV TO %s" % (FILES[1]))
PRE_APPL_DF.to_csv(os.path.join(DATA_DIR, FILES[1]), index=False)
