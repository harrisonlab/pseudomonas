

import sys, argparse, csv

parser = argparse.ArgumentParser(description='csv to postgres',\
 fromfile_prefix_chars="@" )
parser.add_argument('file', help='csv file to import', action='store')
args = parser.parse_args()
csv_file = args.file
csv.field_size_limit(sys.maxsize)

with open(csv_file, 'rb') as csvfile:


    for line in csvfile.readlines():
        array = line.split(',')
        first_item = array[0]

        num_columns = len(array)
        csvfile.seek(0)

        reader = csv.reader(csvfile, delimiter=',')
        included_cols = [1, 2, 6, 7, 4581, 4580]
    
    for array in reader:
        print type(array) 
   # for row in reader:
    #        content = list(row[i] for i in included_cols)
     #       if '1' in  content:             
      #          print content



