# Pandas convert non-standard date format into normalized format
import pandas as pd
"""
    'Transaction Date' is the 3rd column
    5th and 6th columns are 'Description 1' and 'Description 2'
    'CAD$' is the 8th column

"""
# read DataFrame
data = pd.read_csv("format_date_with_pandas.csv")
data = data.rename(columns={'Transaction Date': 'tr_date'})

# Convert date
df = pd.DataFrame({'DOB': {0: '26/1/2016', 1: '26/1/2016'}})

df['transaction_date'] = pd.to_datetime(data.tr_date)

df['converted_date'] = df['transaction_date'].dt.strftime('%m/%d/%Y')
print(df)

# Split files
debits = data[data['CAD$'] >= 0]
credits = data[data['CAD$'] <= 0]

credits.to_csv('credits.csv', index=False)
debits.to_csv('debits.csv', index=False)
 
print(pd.read_csv("credits.csv"))
print(pd.read_csv("debits.csv"))
