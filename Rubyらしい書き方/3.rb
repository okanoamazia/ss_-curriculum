#プログラムの流れの制御
#例題21
array = %w[foo bar baz]
p array.find{|str| str.start_with?("b")}&.capitalize
p array.find{|str| str.start_with?("c")}&.capitalize    # &. を使うことで、メソッド連鎖中にnilになった場合でも、エラーにせずnilを返すようにできる


#例題22
#RE

#例題23
# nil は to_s, to_h を使うことで空のオブジェクトにすることができる
#!error.to_s.empty?
# error が nil            !なし　#=> true 
# error が 文字列    !なし　#=> false  
#!error.to_h.empty?

#例題24
#RE

#例題25
def fezzbuzz(n)
  if n % 15 == 0 then "FizzBuzz"
  elsif n % 3 == 0 then "Fizz"
  elsif n % 5 == 0 then "Buzz"
  else n
  end
end


#=============================================================================================================================
#12月16日MTG以降
#=============================================================================================================================
例題26：条件を満たす要素の検知

（１）
  ●回答
  (1..10).to_a.repeated_combination(3).select{|x,y,z| x + y == z}.length
  =>25

  ●調べたこと
  ・配列オブジェクト.length 
  配列の要素数を返す

  ・配列.repeated_combination(n)
  組み合わせを生成する Enumerator オブジェクトを返します
  (1..3).repeated_combination(2).to_a
  =>[[1, 1], [1, 2], [1, 3], [2, 2], [2, 3], [3, 3]]  
    (1..3).repeated_combination(3).to_a
  => [[1, 1, 1], [1, 1, 2], [1, 1, 3], [1, 2, 2], [1, 2, 3], [1, 3, 3], [2, 2, 2], [2, 2, 3], [2, 3, 3], [3, 3, 3]]

  ・select
  各要素に対してブロックを評価した値が真であった要素を全て含む配列を返しま

（２）
  ●回答
  (1..10).to_a.repeated_combination(3).none?{|x, y, z| x**3 + y**3 == z**3}
  => true
  
  ●調べたこと
  ・none?メソッド
  Enumerable オブジェクトのすべての要素をブロックで評価した結果が、すべて偽であれば真を返します

例題27 
#RE




