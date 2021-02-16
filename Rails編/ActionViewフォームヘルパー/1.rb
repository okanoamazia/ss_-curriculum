#Action View フォームヘルパー
#https://railsguides.jp/form_helpers.html


送る仕組み
属性

■formタグ
・<form>は入力・送信フォームを作成する際に使用
・<form>～</form>の間に、 <input>等のタグにより、 テキストボックス等の部品を配置

■formタグの属性
accept-charset="文字セット"   送信データの文字エンコーディングを指定する
action="URI"　　　　　　 　　 送信先URLを指定する
method="HTTPメソッド"　　   データの送信方法（HTTPメソッド）を指定する     http://www.htmq.com/html5/form.shtml

＊get と post の使い分け
get …… 送信内容がURLとして渡される（初期値）　 短めのキーワードや番号などを送信するのに適した送信方法
post …… 本文（本体）として送信される

■属性
https://so-zou.jp/web-app/tech/html/specification/element-attribute.htm
要素に情報を付加するもの（＊要素：見出しや段落などの部品）
<要素名 属性="属性値">
id属性、class属性等

■フォームによる検索
フォームを検索に使う場合は必ずGETメソッド
（∵ユーザーが検索結果をブックマークした際、検索クエリがURLの一部となっていることで、後でブックマークから同じ検索を実行できるため）

labalタグ

■inputタグ
・フォーム（<form>～</form>）を構成する様々な入力部品を作成する
・type属性にどのような値を指定するかによって、テキストボックス・送信ボタン等、 フォーム部品の種類を指定できる

type="text"　　 　一行テキストボックスを作成する（初期値）
type="submit"　　送信ボタンを作成する
type="hidden"　　画面上は表示されない隠しデータを指定する
type="checkbox"　チェックボックスを作成する

・その他inputにつける属性
name属性　paramsを使って送信されてきたフォームのデータを取り出すときのキーになる
(id属性と一緒にする必然性はないが、inputタグ内では一緒にしているケースが多い)
例）
<input type="text" name="text1" />　→　params[:text1]

■form_tag
・<form>タグを生成するAction View フォームヘルパー
・基本的に指定するのは送信先とHTTPメソッドの2つ
・例　form_tag("送信先", method: "HTTPメソッド")　
#<%= form_tag("/search", method: "get") do %>
#<% end %>

■labal_tag
labelタグを生成するAction View フォームヘルパー
label_tag(:q, "Search for:")
↓
<label for="q">Search for:</label>
↓
つまり、シンボルでfor属性の値、文字列でタグ内の記述をする
label_tag(シンボル, "文字列")

■labelタグ
・フォームの中でフォームの項目名と構成部品（チェックボックス、ラジオボタンなど）を関連付けるためのタグ
・<label>タグのfor属性の値と、フォーム部品のid属性の値を同じにすることで両者の関連付けができる
・例
    <label for="name1">名前</label>
    <input type="text" name="namae" id="name1">

■text_field_tag
textタグを生成するAction View フォームヘルパー

■submit_tag
submitタグを生成するAction View フォームヘルパー
