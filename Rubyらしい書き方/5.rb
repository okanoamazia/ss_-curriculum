#第5章：値のやりとり

例題32：変数の変換
●回答
x = "foo"
y = "bar"
tmp = x
x = y
y = tmp 
x => "bar"
y => "foo"

例題33：割り算の繰り返し
●回答
inch = 100000
feet, inch = inch.divmod(12)
yard, feet = feet.divmod(3)
mile, yard = yard.divmod(1760)
[mile, yard, feet, inch]
=> [1, 1017, 2, 4]

●メモ
・数字.divmod(割数) =>  [q, r]
数字 を 割数 で割った商 q と余り r を、 [q, r] という 2 要素の配列にして返します

例題34：単一の引数のないメソッドへの要素の適用
●回答
array = ["hello", "world"]
array.map{|x|x.capitalize}
=> ["Hello", "World"]

