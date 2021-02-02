#Action View フォームヘルパー
#https://railsguides.jp/form_helpers.html

■そもそも Action View とは
・Action Controller がブラウザからのリクエストを処理して、レスポンスを作成する過程で、HTMLを生成する役割をもつ
https://railstutorial.jp/chapters/toy_app?version=4.2#sec-mvc_in_action
（RailsチュートリアルもRubyonRails速習実践ガイドP77 もレスポンスそのものはコントローラーが返すという考え方）
・テンプレートは、HTML タグの合間に ERB を含む形式で書かれる

＊ERB
https://shinkufencer.hateblo.jp/entry/2018/12/27/000000
https://railsguides.jp/action_view_overview.html
https://railsdoc.com/page/er
・HTMLなどの文章の中にRubyスクリプトを埋め込むためのライブラリ
・ファイル拡張子が.erbであれば使える
・<% %>タグはその中に書かれたRubyコードを実行しますが、実行結果は出力されない
・<%= %>タグでは実行結果がWebページに出力される
例）
hoge_controller.rb で  @name = "Taro"
hoge.html.erb        で <p><%= @name %></p> 
　↓
HTML　　　　　　 で <p>Taro</p>
　↓
Webページ　　　　で　　Taro　

■Action Controller
・MVCモデルのCの役割をもつ
・リクエストを処理するコントローラがルーティング設定によって指名されると、コントローラはリクエストの意味を理解し、適切な出力を行なう
・ブラウザ等のクライアントからリクエストを受け、必要に応じてモデルを利用したりビューを呼び出し、適切なレスポンスを作成する

■MVCとは何か
・ユーザーインターフェースを持つアプリケーションを設計する手法の１つ
・アプリケーションを Model、View、Controller という３つの部分に分けて設計する
    Model      ：アプリケーションが扱うデータの処理を主に行う
    View  　   ：コントローラーから受け取った内容を元にHTMLを生成する
    Controller：ブラウザ等のクライアントからリクエストを受け、必要に応じてモデルを利用したりビューを呼び出し、適切なレスポンスを作成する
    言葉の定義（RubyonRails速習実践ガイドP79参照）
    MVC が実行される流れ（https://railstutorial.jp/chapters/toy_app?version=4.2#sec-mvc_in_action）

  ・Ruby on Rails にもMVCは採用されている（つまりRailsはMVCに基づいて設計されている）
  https://railstutorial.jp/chapters/beginning?version=4.2#sec-mvc

■ActionViewが生成するHTMLを構成する3つの要素
①テンプレート（ビュー、ビューファイル、ビューテンプレート、ビューテンプレートファイルとも）
  ・Action View において実際にHTMLを生成するメインのファイル
②部分テンプレート（パーシャル）
  ・複数のビューファイルで共通する部分を抜粋して作成するファイル
  ・ファイル名は _hoge.html.erb となる
  ・呼び出す際は、render partial: "hoge" （もしくはpartialを省略して render "hoge"）
  （違うディレクトリから呼び出すときは render ディレクトリ名/hoge となる）
  ・localsオプションを使うと部分テンプレート内で使う変数の定義をすることができる（この時、partialの省略は不可）
      render partial: 'ファイル名', locals: { '部分テンプレート内で使う変数': '変数に入れる値' }
  ・collectionオプションを使用するとcollectionオプションに指定した変数の要素の分（＊）だけ部分テンプレートが繰り返し表示させることができる
      render partial: 'ファイル名', collection: 繰り返し表示する要素が入っているインスタンス
      例）
      <%= render partial: "product", collection: @products %  は下と同義
      ↓
      <% @products.each do |product| %
        <%= render partial: "product", locals: { product: product } %
      <% end %

      ＊変数の要素の分とは
      Article.all
      =>#<ActiveRecord::Relation [#<Article id: 5, title: "X", text: "hoge", created_at: "2021-01-29 02:25:01", updated_at: "2021-01-29 02:25:01">,
                                                #<Article id: 6, title: "XX", text: "hogehoge", created_at: "2021-02-01 07:08:17", updated_at: "2021-02-01 07:08:17">]>
      （これを配列のように見立てて、<> のかたまりを要素と呼んでいる模様）
      （調べると、ActiveRecord で呼ばれるこういったデータは ActiveRecord::Relation というクラスのインスタンスであるらしいので、配列と同様に扱えるようにできているのかもしれない）
③レイアウト
  ・多くのコントローラのアクションにわたって共通して使用できるテンプレートのこと
  ・特に指定をしていない場合は「app/views/layouts/application.html.erb」というファイルがレイアウト用テンプレートして自動的に使用される

■コントローラーにおけるレスポンスの種類
①render
・レスポンス構成時にどのビューテンプレートを使用するかを指定するためのもの
・基本的には、アクション名.html.erb のビューテンプレートがRailsのデフォルトの挙動として指定されるため、renderによるビューテンプレートの指定は不要
・renderによって明示するのは アクション名.html.erb 以外のビューテンプレートをレスポンスに使用したい場合
・ActionController::Base クラスに定義されている メソッドの1つ

②redirect_to
・ブラウザに、別のURLに対して改めてリクエストを再送信するよう、指令を出すためのもの

■Action View フォームヘルパー
・フォームのHTMLを生成するビューヘルパー
・フォームのHTMLの実装を簡単にするためのもの

■form_tag
・<form>タグを生成するAction View フォームヘルパー
・基本的に指定するのは送信先とHTTPメソッドの2つ
・例　form_tag("送信先", method: "HTTPメソッド")　＊送信先もHTTPメソッドも指定しない場合は、現在のページ に postメソッド が送信される
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
モデルオブジェクトの作成・修正　→　f.hoge       （form_for内で使える）            <%= f.text_field :title %                              フォームビルダー変数に対して呼び出されるヘルパーメソッド
モデルオブジェクトの作成・修正　→　ヘルパー名に_tagが付いていないもの           <%= text_field(:person, :name) %                モデルオブジェクトを引数とするヘルパーメソッド
それ以外　　　　　　　　　　　　→　ヘルパー名に_tagが付いているもの　　　　  <%= text_field_tag(:person[:name]) %
（右側は仮にPersonモデルの名前を変更するフォーム <input id=" " name="person[name]" type="text" value="">というHTMLを作りたい場合の手間の差）

＊フォームビルダー変数に対して呼び出されるヘルパーメソッドは、オブジェクトを改めて指定する必要がない点が便利

＊フォームビルダー オブジェクト
・ここでは変数f（フォームビルダー変数）
・form_forメソッドが生成している



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
Rubyの文脈 ：アクセサメソッドが定義されことで外部から取得設定可能になったインスタンス変数、オブジェクト（インスタンス）がもつデータ
（p = Person.new → p.name / p.name= で取得設定可能な @name）
Railsの文脈  ：Rubyと同様、場合によってはActiveRecordで対応するようになっているテーブルのカラム

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

＊ルーティングをリソースの宣言によって行っている場合、url: を指定しなくてもRailsが自動で判断してくれる
（要は resources :hoge を定義していれば）

■ファイルのアップロードのフォームの作り方
＊アップロード用のフォームのエンコードは 必ず 「multipart/form-data」でなければならず、form_tagはそれを指定する必要があるため multipart がはいっている）
①form_tag
<%= form_tag({action: :upload}, multipart: true) do %
  <%= file_field_tag 'picture' %
<% end %

②form_for
<%= form_for @person do |f| %
  <%= f.file_field :picture %
<% end %

■アップロード時のparamsハッシュに含まれるオブジェクト
・IOクラスのサブクラス（子クラス）のインスタンス
・original_filename属性（ユーザーのコンピュータ上にあるファイルの名前）とcontent_type属性（アップロードの終わったファイルのMIMEタイプ）をもつ

＊IOクラス
プログラムの外部とデータのやりとりをするための機能として入力(Input)と出力(Output)を提供するもの
（たのしいRuby P339）

■パラメータの命名ルール
・パラメータ命名ルールによって、フォームから送信されるデータをRails側で配列やハッシュとして参照できる
（フォームが送信する元のデータはすべて名前と値がペアとなっている単なる文字列）

■パラメータの命名ルールの基本構造
例）
<input id="person_name" name="person[name]" type="text" value="Henry"/>
↓
params = {'person' => {'name' => 'Henry'}}
↓
params[:person][:name]
↓
Henry


＊ハッシュ
・キーと値の組み合わせでデータを管理するオブジェクト
・ハッシュの書き方
{"subject" => "Math", "score" => 80}   キーが文字列
{ :subject => "Math",  :score => 80}    キーがシンボル
{ subject:"Math"      , score:80}          キーがシンボルの省略形

＊ハッシュの取り出し方
ハッシュ名[:キー]
X={ :subject => "Math",  :score => 80}
X[:subject]
=>"Math"

＊ちなみにこの時、ハッシュ名というのは、○＝{}で定義した時の○、すなわち変数の名前
＊変数は 変数名=式や値 で定義でき、定義した時点でその変数と式や値は全く同じオブジェクトとなる（属するクラスももちろん一緒）
例）X={'Japan'=>'yen', 'US'=>'dollar'}
{'Japan'=>'yen', 'US'=>'dollar'}
=> {"Japan"=>"yen", "US"=>"dollar"}
X
=> {"Japan"=>"yen", "US"=>"dollar"}
X.class
=> Hash
例）X=666
X.class
=> Integer
例）X="winter"
X.class
=> String
