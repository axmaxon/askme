Веб-приложение "Askme" 
===

Приложение реализующее идею, положенную в основу социальной сети ask.fm 

Каждый пользователь может задать вопрос любому участнику системы.

В приложении реализованы:
- регистрация пользователя;
- возможность задать вопрос зарегистрированным пользователям;
- добавление хэштегов в текст вопроса и ответа;
- поиск по хэштегам;
- редактирование профиля: исправление личных данных, добавление аватара, изменение цвета
фона в профиле; 
- защита от ботов;

## Технологии:

- `Ruby 2.7.2`
- `Ruby on Rails 6.1.3`
- `Webpacker 5.2.1`
- защита форм: `Google reCAPTCHA`
- СУБД в продакшн-окружении: `Postgresql`
- локализация: `rails-I18n`
- приложение в учебных целях было [развернуто](https://thequestioned.herokuapp.com/) на платформе `Heroku`
(при переходе по ссылке необходимо немного подождать, чтобы приложение вышло из "спящего" 
режима)

### Для локального запуска:

1. Клонировать репозиторий:

```
$ git clone git@github.com:axmaxon/askme.git
```

2. Установить любым удобным способом `ruby 2.7.2`, если отсутствует.
3. Установить необходимые гемы и зависимости:

```
$ bundle
```
4. В приложении используется reCAPTCHA для работы которой следует у Google получить ключи
и указать их в `Rails credentials`

**recaptcha:**
- public_key
- private_key

Для этого воспользоваться командой:

```
EDITOR='XXXX --wait' bin/rails credentials:edit
```
*где **XXXX** - удобный для вас редактор кода, например `vi` - для открытия
в Vim или `subl` для открытия в Sublime

5. Применить миграции:

```
$ bundle exec rails db:migrate
```

6. Запустить сервер:

```
$ bundle exec rails s
```

7. В адресной строке веб-браузера указать:

```
http://localhost:3000/
```
