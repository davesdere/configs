import datetime
import csv

date_input = "20221230"
#datetimeobject = datetime.strftime(date_input, '%Y%m%d')
#new_format = datetimeobject.strftime('%Y-%m-%d')

yo =datetime.datetime.strptime("2013-1-25", '%Y-%m-%d').strftime('%m/%d/%y')
print(yo)

with open('banking.csv') as csv_file:
    """
    'Transaction Date' is the 3rd column
    5th and 6th columns are 'Description 1' and 'Description 2'
    'CAD$' is the 8th column
    """
    csv_reader = csv.reader(csv_file, delimiter=',')
    line_count = 0
    
    for row in csv_reader:
        if line_count == 0:
            print(f'Column names are {", ".join(row)}')
            line_count += 1
        else:
            print(f'\t{row[0]} works in the {row[1]} department, and was born in {row[2]}.')
            line_count += 1
    print(f'Processed {line_count} lines.')

    def convert_date(value_old_format):
        new_format = datetime.datetime.strptime(value_old_format, '%m/%d/%y').strftime('%Y-%m-%d')
        return str(new_format)



def write_to_csv(new_data):
    with open('converted_banking.csv', mode='w') as new_csv:
        employee_writer = csv.writer(new_csv, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)

        employee_writer.writerow(['John Smith', 'Accounting', 'November'])
        employee_writer.writerow(['Erica Meyers', 'IT', 'March'])