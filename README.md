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
2. 生成されたGemfileに下記の2行を追記
```
gem "sinatra"
gem "webrick"
```
3. `bundle install` を実行
4. `bundle exec ruby sinatra_memo_app.rb`を実行
5. `http://127.0.0.1:4567/memo`にアクセス

