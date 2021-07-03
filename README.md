# Задачите за позиция "ИТ &amp; Уебсайт"


За задача 1 и задача 2 използвам база данни от карти и потребители. Потребителите и картите имат OneToMany relationship, като всеки  потребител съдържа неговите карти (плейлисти) в себе си.

## Карти
- Заглавие на картата
- Автор 
- Описание

## Потребител
- Никнейм
- Имейл
- Карти (срещат се и като плейлисти)

# Демо

<img src="https://media1.giphy.com/media/yoXzwydXvHCoKYGegI/giphy.gif?cid=790b76115727b7b230db353ef594f84ab04e546a7f5f1648&rid=giphy.gif&ct=g"/>

# Технологии

- За database използвам MongoDB, която е нерелационна база данни. Тя се намира в https://cloud.mongodb.com/ .
- За API е използван Express на Node.js, като използвам модула mongoose, за комуникация към MongoDB-то
- Front-end частта е направена на Flutter, като има базови функции, показани в демото


# Setup

Стартиране на Express сървъра
```bash
node server.js
```
Стартиране на Flutter приложението
```bash
cd /front-end/app/
flutter run -d chrome --web-hostname=127.0.0.1 --web-port=8200
```
# Routes

- http://localhost:3000/ [GET] връща списък с потребителите / авторите

- http://localhost:3000/ [POST] Добавя нов потребител

- http://localhost:3000/:userId/cards [GET] връща списък с всички карти

- http://localhost:3000/:userId/usercards [GET] връща списък с всички карти на определен потребител

- http://localhost:3000/:userId/cards/ [POST] създава нова карта

- http://localhost:3000/cards/:id [PUT] Презаписва карта

- http://localhost:3000/cards/:id [DELETE] Изтрива карта

