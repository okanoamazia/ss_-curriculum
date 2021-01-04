#Action View フォームヘルパー
#https://railsguides.jp/form_helpers.html

■form_tag
・<form>タグを生成するAction View フォームヘルパー
・基本的に指定するのは送信先とHTTPメソッドの2つ
・例　form_tag("送信先", method: "HTTPメソッド")　
#<%= form_tag("/search", method: "get") do %>
#<% end %>

■formタグ
・<form>～</form>は入力・送信フォームを作成する際に使用する要素
・<form>～</form>の間に、 <input>等のタグにより、 テキストボックス等の部品を配置

■formタグの属性
accept-charset="文字セット"   送信データの文字エンコーディングを指定する
action="送信先URL"　　　　　　 　　 送信先URLを指定する
method="HTTPメソッド"　　   データの送信方法（HTTPメソッド）を指定する     http://www.htmq.com/html5/form.shtml

＊get と post の使い分け
get …… 送信内容がURLとして渡される（初期値）　 短めのキーワードや番号などを送信するのに適した送信方法
post …… 本文（本体）として送信される

■属性
https://so-zou.jp/web-app/tech/html/specification/element-attribute.htm
要素に情報を付加するもの（＊要素：見出しや段落などの部品）
<要素名 属性="属性値"> 〜 </要素名>    →　これ全体で要素　（＊要素の境界を表すものをタグ）
id属性、class属性等

■フォームによる検索
フォームを検索に使う場合は必ずGETメソッド
（∵ユーザーが検索結果をブックマークした際、検索クエリがURLの一部となっていることで、後でブックマークから同じ検索を実行できるため）

■inputタグ
・フォーム（<form>～</form>）を構成する様々な入力部品を作成する
①type属性
どのような値を指定するかによって、テキストボックス・送信ボタン等、 フォーム部品の種類を指定できる
type="text"　　 　一行テキストボックスを作成する（初期値）
type="submit"　　送信ボタンを作成する
type="hidden"　　画面上は表示されない隠しデータを指定する
type="checkbox"　チェックボックスを作成する

②name属性
paramsを使って送信されてきたフォームのデータを取り出すときのキーになる
(id属性と一緒にする必然性はないが、inputタグ内では一緒にしているケースが多い)
例）
<input type="text" name="text1" />　→　params[:text1]

③value属性
つけたinputタグのフォームのデフォルトの値となる
（フォームに入力がないときにparams[:name属性の文字列]で取り出される値）

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
<%= text_field_tag(:q) %>
↓
<input id="q" name="q" type="text" />

■submit_tag
submitタグを生成するAction View フォームヘルパー
<%= submit_tag("Search") %>
↓
<input name="commit" type="submit" value="Search" />
（＊ボタンに表示させる[送信する]などのテキストは、value属性で指定）
（＊name="commit"はsubmitタグのデフォルトの挙動）

■フォーム要素生成に使うヘルパーの1つ目のパラメータはinputタグならnameであり、labelタグならfor
<%= check_box_tag(:pet_dog) %>
↓
<input id="pet_dog" name="pet_dog" type="checkbox" value="1" />

<%= radio_button_tag(:age, "child") %>　＊radio_button_tagの2つ目のパラメータはvalue
↓
<input id="age_child" name="age" type="radio" value="child" />

<%= label_tag(:pet_dog, "I own a dog") %>
↓
<label for="pet_cat">I own a cat</label>

■フォームヘルパーの種類
モデルオブジェクトの作成・修正　→　f.hoge(form_for内で使える）　　　　＊属性がたくさんある場合
モデルオブジェクトの作成・修正　→　ヘルパー名に_tagが付いていないもの　　
それ以外　　　　　　　　　　　　→　ヘルパー名に_tagが付いているもの

■「ヘルパー名に_tagが付いていないもの」について
最初の引数はインスタンス変数名、2番目の引数はオブジェクトを呼び出すためのメソッド名 (通常は属性名を使います)
例）
Personモデルの作成修正（情報登録やその修正）
<%= text_field(:person, :name) %>　　　
＊ :person →　インスタンス変数名  → @person
　 :name   →   オブジェクトを呼び出すためのメソッド名 (通常は属性名を使います)   → @person.nameのname
↓
<input id="person_name" name="person[name]" type="text" value="Henry"/>


＊属性という言葉と文脈による定義
HTMLの文脈：要素に情報を付加するもの（class, id 等）
Rubyの文脈 ：アクセサメソッドが定義されことで外部から取得設定可能になったインスタンス変数
（p = Person.new → p.name / p.name= で取得設定可能な @name）
Railsの文脈  ：オブジェクト（インスタンス）がもつデータ（Rubyの文脈 の言い方が変わったもの）
（p = Person.new => <Person id: nil, name: nil> の id や name がオブジェクトであるpの属性）
　　　　　　　モデルと対応するデータベースの列（カラム）の項目名

＊モデルとデータベースがなぜ関係するか
https://railsguides.jp/active_record_basics.html#active-record%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6
Active Recordによって、モデルとデータベースが対応し、モデルのオブジェクトを経由して操作できるようになっている
（Postモデルにはpostsテーブルが対応しており、Postモデルのインスタンスによってpostsテーブルにレコードをいれていける）
レコード：モデルのオブジェクト（インスタンス）　　　 データベースで言うところの行
属性　　：オブジェクト（インスタンス）がもつデータ    データベースで言うところの列

■form_for
モデルオブジェクトの作成・修正を多くの属性に関して行う場合にこれを使うと便利
基本形として


<%= form_for @hoge, url: {action: "create"} do |f| %>     ＊@hogeは実際に編集されるオブジェクトそのもの
  <%= f.text_field :title %>      ＊titleはinputタグのname属性に影響　　　　　＊fのことをフォームビルダー オブジェクト（フォームビルダー変数）
  <%= f.submit "送信" %>　　  ＊"送信"はinputタグのvalue属性に影響
<% end %>
↓
<form class="nifty_form" id="new_article" action="/articles" accept-charset="UTF-8" method="post">
  #デフォルト<input name="utf8" type="hidden" value="&#x2713;" />
  #デフォルト<input type="hidden" name="authenticity_token" value="NRkFyRWxdYNfUg7vYxLOp2SLf93lvnl+QwDWorR42Dp6yZXPhHEb6arhDOIWcqGit8jfnrPwL781/xlrzj63TA==" />
  <input type="text" name="hoge[title]" id="article_title" />
  <input type="submit" name="commit" value="送信" data-disable-with="送信" />
</form>
