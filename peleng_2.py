#2.
import re

file_paths = (
    '***/Test/files/1.xls, ***/Test/files/2.XLSX, ***/Test/files/9.vra, ***/Test/files/3.jpg, ***/Test/files/4.xml,'
    '***/Test/files/5.png, ***/Test/files/6.xlsm, ***/Test/files/7.xlso, ***/Test/files/8.xls*,'
    '***/Test/files/9.xlasx, ***/Test/files/9.vba'
)

list_of_files=[]
str_of_xlsx_extensions = ('XLSX, XLSM, XLSB, XLS, XLTX, XLTM, XLAM, VBA, BAS, FRM, FRX, CLS, CTL')
rows = file_paths.split(', ')
for row in rows:
    file = row[row.rfind('/')+1:]
    extension = file[file.rfind('.')+1:]
    if extension in str_of_xlsx_extensions or extension in  str_of_xlsx_extensions.lower():
        list_of_files.append(row)

print(list_of_files)


###REGEX

str_of_xlsx_extensions = 'XLSX|XLSM|XLSB|XLS|XLTX|XLTM|XLAM|VBA|BAS|FRM|FRX|CLS|CTL'

pattern = re.compile(rf'.+\.({str_of_xlsx_extensions})$', re.IGNORECASE)
files_list = file_paths.split(', ')
filtered_files = [file for file in files_list if pattern.match(file)]

print(filtered_files)




