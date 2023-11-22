#2.
import re

file_paths = (
    '***/Test/files/1.xls, ***/Test/files/2.XLSX, ***/Test/files/9.vra, ***/Test/files/3.jpg, ***/Test/files/4.xml,'
    '***/Test/files/5.png, ***/Test/files/6.xlsm, ***/Test/files/7.xlso, ***/Test/files/8.xls*,'
    '***/Test/files/9.xlasx, ***/Test/files/9.vba'
)

list_of_files=[]
str_of_xlsx_extensions = ('XLSX, XLSM, XLSB, XLS, XLTX, XLTM, XLAM, VBA, BAS, FRM, FRX')
rows = file_paths.split(', ')
for row in rows:
    file = row[row.rfind('/')+1:]
    extension = file[file.rfind('.')+1:]
    if extension in str_of_xlsx_extensions or extension in  str_of_xlsx_extensions.lower():
        list_of_files.append(row)

print(list_of_files)


###REGEX

str_of_xlsx_extensions = 'XLSX|XLSM|XLSB|XLS|XLTX|XLTM|XLAM|VBA|BAS|FRM|FRX'

files_list = file_paths.split(', ')
pattern_with_lower = re.compile(rf'.+\.({str_of_xlsx_extensions.lower()})$')                                          ###РАЗБИЛ НА 2 МАССИВА БЕЗ УСЛОВНОГО flags=re.IGNORECASE, ЧТОБЫ ИЗБЕЖАТЬ СИТУАЦИИ xlsX 
pattern_without_lower = re.compile(rf'.+\.({str_of_xlsx_extensions})$')

# Фильтрация списка файлов с учетом и без учета регистра
filtered_files_lower = [file for file in files_list if pattern_with_lower.match(file)]
filtered_files_no_lower = [file for file in files_list if pattern_without_lower.match(file)]

# Объединение результатов
combined_filtered_files = filtered_files_lower + filtered_files_no_lower

print(combined_filtered_files)



