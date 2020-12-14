#第1章：数値、文字列

#例題１【数の比較】
#整数インスタンスに変更（＊roundで四捨五入しているため誤差が生まれる可能性がある）
p (100*1.1).round == 110

##有理数インスタンスに変更（＊有理数：2個の整数の比で表せる数）
p 100*1.1r == 110

#例題２【整数のインクリメント】（＊インクリメント：変数の値を１増やす演算のこと）
#succメソッドを使う
i = 10
while i <= 20
  puts i
  i = i.succ
end

##イテレータを使う（＊イテレータ：配列等の集合的なデータに対して繰り返しの処理をするメソッドのこと）
10.upto(20).each{|i| puts i}

#例題３【表計算ソフト風の列の名前】
#succ!メソッドを使う
str="A"
(2019-1).times{str.succ!}
puts str 

#例題４【入力された文字列の比較】
#loop{break if gets(chomp: true) == "exit"}

#例題５【文字列の部分一致】
string="|l|l|llll||"
a="|l|l|lll||"
b="||l"
c="l||"
p string == a 
p string.start_with?(b)
p string.end_with?(c)

#例題６ 【禁止されている文字を含んでいるかの検査】
#raise：例外（エラー）を発生させる
#正規表現：文字列のパターンを記述するための言語。文字列が指定したパターンを含んでいるかどうかを判定することが可能。/パターン/ で記述する。
#（例：/ \d / で全ての数字を意味する / \D / で数字以外を示す）
# https://qiita.com/shizuma/items/4279104026964f1efca6
s="llllllll"
raise "No numbers please" if s.match?(/\d/)

# 例題７【文字列の切り出し１】
p "PEN".split("") #＊区切り文字に""(ブランク)を指定すると、文字列を1文字ずつ分割
p "This is a pen.".split  #デフォルトでは半角スペースがあれば分割可能
p "foo\nbar\nbaz\n".split("\n") #指定した文字で区切る

# 例題８【文字列の切り出し２】
#文字列.scan(探索するパターン)  ＊探索するパターンには正規表現などが入る
string = %{"Come, Watson! He cried."}
p string.scan(/[\w']+/) #[\w']+で単語を示している

# 例題９【文字列の切り出し３】
p "03-5555-5555".split("-",2).first  #オブジェクト.split("分割対象", 分割数)

#例題１０【文字列の破壊的変更】
strings = ["foo", "Bar", "BAZ"]
ary = strings.each do |s|
  s.upcase!; s.reverse!
end
p ary

