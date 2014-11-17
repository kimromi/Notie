# Notie
[https://notie.herokuapp.com/](https://notie.herokuapp.com/)

Simple Markdown Editor


## サーバ

Ruby on Rails

## クライアント

Backbone.js

## その他ライブラリ

* Twitter Bootstrap [http://getbootstrap.com/](http://getbootstrap.com/)
* Font Awesome（アイコンフォント）[http://fortawesome.github.io/Font-Awesome/](http://fortawesome.github.io/Font-Awesome/)
* marked.js（markdown→HTML変換）[https://github.com/chjj/marked](https://github.com/chjj/marked)
* highlight.js（シンタックスハイライト）[https://highlightjs.org/](https://highlightjs.org/)
* split-pane.js（画面スプリッター）[https://github.com/shagstrom/split-pane](https://github.com/shagstrom/split-pane)
* jQuery Tag-it!（タグ入力）[http://aehlke.github.io/tag-it/](http://aehlke.github.io/tag-it/)
* tabindent.js（テキストエリアタブ入力）[https://github.com/julianlam/tabIndent.js](https://github.com/julianlam/tabIndent.js)

## 使い方

* OAuth2でQiitaかGithubに認証しログインします。
* 上部メニュー『NEW』をクリックすると、入力画面に移ります。  
→ タイトル、タグ、テキストを入力しsave(Ctrl+S)するとノートを保存できます。
* 上部メニュー『LIST』をクリックするとノートの一覧が表示されます。
    * 「↑」「↓」キーでノートの選択、「→」キーでノートの表示、「←」キーで非表示に出来ます。  
    * ノートの選択後、「Enter」キーで編集画面が表示されます。  
    * 『Search』テキストボックスから、タイトル・内容の全文検索が出来ます。
    * 右のタグ一覧からタグを選択することでノートの絞り込みが出来ます。
