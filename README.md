### Приложение "Instatalkers"

---

**Учебный проект-приложение**

Проект-приложение реализовано на `Ruby/Rails (v. 5.2.3)` в учебных целях.

**Краткое описание**

Приложение `Instatalkers` - реализация приватных чат-комнат для общения. При открытии приложения, будет сгенерирован случайный никнейм, который будет храниться в куках браузера. Это упрощает аутентификацию пользователей.

**Использованные технологии:**

* Оформление с помощью `Bootstrap 4`

* Использование No-SQL базы данных `Redis`

* Использование возможностей Rails и технологии WebSocket: `Action Cable` для реализации непрерывного потока данных в приложение

**Установка и запуск приложения**

* Необходимо установить локально `Redis`

* Выполнить установку всех библиотек и подготовить базу данных(используется БД Postgres) - файл `database.yml` в папке 'config'.

```
bundle install
bundle exec rake db:setup && bundle exec rake db:migrate
```

Для запуска локального сервера нужно выполнить команду:

```
bundle exec rails s
```
