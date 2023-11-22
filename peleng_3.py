#3.
# Задание 3 Обработка входящего потока данных.
# Рекомендуется использовать регулярное выражение
# Реализовать консольный скрипт, который в качестве параметра будет принимать строку из разделенных между собой натуральных чисел.
# //Выводит этот же массив отсортированный в порядке возрастания.
# Во входной строке числа разделены как минимум одним пробелом, в сортировке участвуют только числа
# Пример передаваемой строки - “1 -2 -3 4 5 -6f ss3 0 0 0 -0 0.0 0.05”
# Результат: -3 -2 0 1 4 5
# Натуральные - все целые числа, которые больше 0. В примере же подразумеваются все целые числа, как я понял. Сделал оба варианта


# Для натуральных чисел


import re
import sys

def sort_numbers_natural(input_string):
    
    numbers = re.findall(r'\d+', input_string)
    sorted_numbers = sorted(set(map(int, numbers)))
    
    return sorted_numbers




# Для целых чисел

def sort_numbers_int(input_string):
    
    numbers = re.findall(r'-?\d+', input_string)
    sorted_numbers = sorted(set(map(int, numbers)))
    
    return sorted_numbers



input_string = sys.stdin.read().strip()     
sorted_numbers_natural = sort_numbers_natural(input_string)
print(" ".join(str(num) for num in sorted_numbers_natural))  
sorted_numbers_int = sort_numbers_int(input_string)
print(" ".join(str(num) for num in sorted_numbers_int))


