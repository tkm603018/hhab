# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
# hhab
# hhab
# hhab

```
heroku run console
```

でバグをみる

メンテナンスモード切り替え
```
heroku maintenance:on
heroku maintenance:off
```

初期データの投入方法
```
heroku run rake db:seed
```

ログを見る
```
heroku logs -t
```
```
CLEARDB_DATABASE_URL:     mysql://b7e455b6b7f1c3:5324d350@us-cdbr-east-04.cleardb.com/heroku_426b268c26bc141?reconnect=true
DATABASE_URL:             mysql2://b7e455b6b7f1c3:5324d350@us-cdbr-east-04.cleardb.com/heroku_426b268c26bc141?reconnect=true
DB_HOSTNAME:              localhost
DB_NAME:                  hhab
DB_PASSWORD:              tkm603018
DB_PORT:                  3000
DB_USERNAME:              def-user
JAWSDB_URL:               mysql://unkouuav55yomrav:pn6n5xzwh0n72y4b@jtb9ia3h1pgevwb1.cbetxkdyhwsb.us-east-1.rds.amazonaws.com:3306/qloj73qhwriclbi7
LANG:                     en_US.UTF-8
RACK_ENV:                 production
RAILS_ENV:                production
RAILS_LOG_TO_STDOUT:      enabled
RAILS_SERVE_STATIC_FILES: enabled
SECRET_KEY_BASE:          7fd2929a4236adc8a6df8fdb2b04fc420cccfcb29210118613ace9e632fd296a5555b6e3160dda33e9f4ed8243af89effec79c1f2939a6979b864d77579d7c35
```