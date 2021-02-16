#Active Support
#https://railsguides.jp/active_support_core_extensions.html


■Active Supportの役割
Ruby on Railsのコンポーネントであり、Ruby言語の拡張、ユーティリティ、その他横断的な作業を担っている

■全てのオブジェクトで使える拡張機能
・blank?, present?
・duplicable?
・instance_values
・instance_variable_names

■Moduleの拡張
・モデルの属性の別名を作成できる（1つ目の引数には新しい名前、2つ目の引数には元のカラム名を指定）
class User < ApplicationRecord
  # emailカラムを"login"という名前で参照可能になる
  alias_attribute :login, :email
end
・delegateマクロを使って、メソッドを簡単に委譲できる
class User < ApplicationRecord
  has_one :profile

  def name
    profile.name
  end
end
↓
class User < ApplicationRecord
  has_one :profile

  delegate :name, to: :profile
end

■Classの拡張
・subclassesメソッドはレシーバのサブクラスを返す
class C; end
C.subclasses # => []

class B < C; end
C.subclasses # => [B]

class A < B; end
C.subclasses # => [B]

class D < C; end
C.subclasses # => [B, D]

■Stringの拡張
・安全な文字列
HTMLにそのまま挿入しても問題がないというマークが付けられている文字列
文字列はデフォルトでは unsafe とマークされる
与えられた文字列にhtml_safeメソッドを適用することで、当該の文字列安全な文字列とマークすることが可能
s = "".html_safe
s.html_safe? # => true

・removeメソッドを実行すると、すべての該当パターンが削除される
"Hello World".remove(/Hello /) # => "World"

・squishメソッドは、冒頭と末尾のホワイトスペースを除去し、連続したホワイトスペースを1つに減らす
" \n  foo\n\r \t bar \n".squish # => "foo bar"

・starts_with?とends_with?
"foo".starts_with?("f") # => true
"foo".ends_with?("o")   # => true

・at(position)
"hello".at(0)  # => "h"
"hello".at(4)  # => "o"

・from(position)
"hello".to(0)  # => "h"
"hello".to(2)  # => "hel"

・pluralize
"table".pluralize     # => "tables"
"equipment".pluralize # => "equipment"

・singularize
"tables".singularize    # => "table"
"equipment".singularize # => "equipment"

・camelize
レシーバをキャメルケース (冒頭を大文字にした単語をスペースなしで連結した語) にしたものを返す
"product".camelize    # => "Product"
"admin_user".camelize # => "AdminUser"

・underscore
"Product".underscore   # => "product"
"AdminUser".underscore # => "admin_user"

・titleize
"alice in wonderland".titleize # => "Alice In Wonderland"
"fermat's enigma".titleize     # => "Fermat's Enigma"

・dasherize
"contact_data".dasherize # => "contact-data"

・tableize
モデル名にtableizeを使うとモデルのテーブル名を得られる
"Person".tableize      # => "people"
"Invoice".tableize     # => "invoices"
"InvoiceLine".tableize # => "invoice_lines"

・classify
与えられたテーブル名に対応するクラス名（モデル名）を返す
"people".classify        # => "Person"
"invoices".classify      # => "Invoice"
"invoice_lines".classify # => "InvoiceLine"

・foreign_key
"User".foreign_key           # => "user_id"
"InvoiceLine".foreign_key    # => "invoice_line_id"
"Admin::Session".foreign_key # => "session_id"

■Numericの拡張
・数値を電話番号形式の文字列に変換
5551234.to_s(:phone)
# => 555-1234

■Integerの拡張
・multiple_of?
レシーバの整数が引数の倍数であるかどうか真偽値を返す
2.multiple_of?(1) # => true
1.multiple_of?(2) # => false

■Enumerableの拡張
・sum
[1, 2, 3].sum # => 6
(1..100).sum  # => 5050

■Arrayの拡張
・ 配列へのアクセス
toメソッドは、配列の冒頭から、渡されたインデックスが示す箇所までの範囲を返す
%w(a b c d).to(2) # => ["a", "b", "c"]
fromメソッドは、配列のうち、インデックスが指す箇所から末尾までの要素を返す
%w(a b c d).from(2)  # => ["c", "d"]

■Hashの拡張
・マージ
{a: 1, b: 1}.merge(a: 0, c: 2)
# => {:a=>0, :b=>1, :c=>2}
・except
{a: 1, b: 2}.except(:a) # => {:b=>2}
・slice!
hash = {a: 1, b: 2}
rest = hash.slice!(:a) # => {:b=>2}
hash                   # => {:a=>1}
・extract!
hash = {a: 1, b: 2}
rest = hash.extract!(:a) # => {:a=>1}
hash                     # => {:b=>2}

■Rangeの拡張
(Date.today..Date.tomorrow).to_s
# => "2009-10-25..2009-10-26"

■Dateの拡張
・beginning_of_week、end_of_week
beginning_of_weekメソッドとend_of_weekメソッドは、それぞれ週の最初の日付と週の最後の日付を返す
（週の始まりはデフォルトでは月曜日ですが、引数を渡して変更できる）
d = Date.new(2010, 5, 8)     # => Sat, 08 May 2010
d.beginning_of_week          # => Mon, 03 May 2010
d.end_of_week                # => Sun, 09 May 2010

・beginning_of_year、end_of_year
d = Date.new(2010, 5, 9) # => Sun, 09 May 2010
d.beginning_of_year      # => Fri, 01 Jan 2010
d.end_of_year            # => Fri, 31 Dec 2010

■DateTimeの拡張
・utc?メソッドは、レシーバがそのタイムゾーンに合ったUTC時刻を持っているかどうかをチェックする
now = DateTime.now # => Mon, 07 Jun 2010 19:30:47 -0400
now.utc?          # => false
now.utc.utc?      # => true

・advance
d = DateTime.current
# => Thu, 05 Aug 2010 11:33:31 +0000
d.advance(years: 1, months: 1, days: 1, hours: 1, minutes: 1, seconds: 1)
# => Tue, 06 Sep 2011 12:34:32 +0000

■Timeの拡張
・all_dayメソッドは、現在時刻を含む「その日一日」を表す範囲を返します。
now = Time.current
# => Mon, 09 Aug 2010 23:20:05 UTC +00:00
now.all_day
# => Mon, 09 Aug 2010 00:00:00 UTC +00:00..Mon, 09 Aug 2010 23:59:59 UTC +00:00
