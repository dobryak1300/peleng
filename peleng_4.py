import requests
from bs4 import BeautifulSoup

# URL веб-страницы
url = 'https://terrikon.com/football/italy/championship/'

# Отправляем GET-запрос
response = requests.get(url)


html_content = response.content

soup = BeautifulSoup(html_content, 'html.parser')

table = soup.find('table', class_='colored')

player_data = "<table>"
    
rows = table.find_all('tr')

for row in rows:
    cells = row.find_all(['th', 'td'])

    row_data = [cell.get_text(strip=True) for cell in cells]

    player_data += "<tr><td>" + "</td><td>".join(row_data) + "</td></tr>"
    
player_data += "</table>"
    
print(player_data)
