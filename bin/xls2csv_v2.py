#!/usr/bin/python
#Written by Nathaniel Stenzel of Sebis Direct 8/18/2009
#This program converts from an Excel file format to a delimited file format.
import xlrd
import csv
import sys

def cleaned_field(item):
	item = item.strip()
	if item.strip() == ("''"): item = ""
	elif item.startswith("u'''") or item.startswith('u"""') or item.startswith('"u""') or item.startswith('u\'""'): item = item[4:-3].strip()
	elif item.startswith("u''") or item.startswith('u""'): item = item[3:-2].strip()
	elif item.startswith("u'") or item.startswith('u"'): item = item[2:-1].strip()
	else: item = item.lstrip('"').rstrip('"').lstrip("'").rstrip("'")

	if item[-2:] == '.0': item = item[:-2]
	return item


delimiters = { "comma":",", "tab":"\t", "semi-colon":";", "pipe":"|", "\\t":"\t"}

if "--help" in sys.argv or "?" in sys.argv or len(sys.argv)<4:
	print "This program converts from an Excel file format to a delimited file format."
	print "Usage: xls2csv input.xls output.txt delimeter [sheets]"
	print 'Example: xls2csv input.xls output.txt "|" Sheet1 "My summary" "Totals"'
	print "Example: xls2csv input.xls output.txt comma"
	print "Delimiters:"
	for delimiter in delimiters:
		print "%s: x%sx%sx" % (delimiter, delimiters[delimiter], delimiters[delimiter])
	print "You can use the actual delimiter character too, but you may need to surround it in quotes."
	exit(0)
#Add argument to be infile
infile = sys.argv[1]
book = xlrd.open_workbook(infile)

outfile = sys.argv[2]
the_delimiter = sys.argv[3].lower()

if the_delimiter == "sheets":
	print ",".join(book.sheet_names())
	exit(0)

if the_delimiter in delimiters:
	the_delimiter = delimiters[the_delimiter]

output = csv.writer(open(outfile,"w"),delimiter=the_delimiter)
if len(sys.argv)<5:
	sheet_names = book.sheet_names()
else: 
	sheet_names = sys.argv[4:]
temp = book.sheet_by_name(sheet_names[0])

for sheet_name in sheet_names:
	for row in range(book.sheet_by_name(sheet_name).nrows):
		row_data = []
		for cell in book.sheet_by_name(sheet_name).row_slice(row,0):
			cell = str(cell).split(":",1)
			if  cell[0] == "xldate":
				date_tuple = xlrd.xldate_as_tuple(float(cell[1]), book.datemode)
				the_date = "%s/%s/%s" % (date_tuple[1],date_tuple[2],date_tuple[0])
				row_data.append(the_date)
			else:
				row_data.append(cleaned_field(cell[1]))
			
			
		output.writerow(row_data)

#print xlrd.xldate_as_tuple(28053, 1)
