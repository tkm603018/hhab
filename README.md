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
# House Hold Account Book

<h1 align="center">
  家計簿アプリ
</h1>

<center>
  アプリのURL: <a href="https://hhab1111.herokuapp.com/">https://hhab1111.herokuapp.com/</a>
</center>

- ## アプリ画面の例
  <img width="1679" alt="Screen Shot 2022-05-06 at 11 53 23 PM" src="https://user-images.githubusercontent.com/51039761/167158115-41410f15-90e9-404f-bfa2-a959921627fd.png">

- ## ツール
  コンソール
  ```
  heroku run console
  ```

  メンテナンスモード切り替え
  ```
  heroku maintenance:on
  heroku maintenance:off
  ```

  初期データの投入
  ```
  heroku run rake db:seed
  ```

  ログ
  ```
  heroku logs -t
  ```
- ## 外部公開設定
  ###  [Heroku](https://www.heroku.com/)を使って外部に公開する

  1.  **デプロイ設定**

      https://qiita.com/murakami-mm/items/9587e21fc0ed57c803d0 を参考に設定

  2.  **デプロイ方法**
      ```shell
      git push heroku <ブランチ名>:master; heroku rake db:migrate; heroku open
      ```
      or

      [![Deploy to Heroku](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)
