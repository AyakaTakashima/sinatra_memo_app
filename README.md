# fjord-sinatra_memo_app
フィヨルドブートキャンプのWebアプリケーション（sinatra）プラクティスの提出物をまとめるリポジトリです。

## How to use
### 初回のみ行う操作
1. 右上の `Fork` ボタンを押してください。
2. `#{自分のアカウント名}/fjord-sinatra_memo_app` が作成されます。
3. 作業PCの任意の作業ディレクトリにて `git clone` してください。
```shell
$ git clone https://github.com/自分のアカウント名/fjord-sinatra_memo_app.git`
```
5. `cd fjord-sinatra_memo_app` でカレントディレクトリを変更してください。

### アプリケーションを立ち上げのために行う操作
以下の手順に従って環境セットアップを実行してください。
1. `bundle init`を実行
2. 生成されたGemfileに下記の3行を追記
```
gem 'sinatra'
gem 'pg'
gem 'webrick'
```
3. `bundle install` を実行
4. 下記コマンドにてpostgersでログイン
```
$ psql postgres
```
5. データベースを作成
```
create database web_application_practice;
```
6. `-d`オプションで`web_application_practice`データベースへ入り、下記のコマンドを実行
```
create table memo_data
(id serial
,title text
,text text
,primary key(id));
```
7. `bundle exec ruby sinatra_memo_app.rb`を実行
8. `http://127.0.0.1:4567/memo`にアクセス




