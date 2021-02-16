#ループ処理(map、each、reduce)、loop、timesメソッド
array = (1..4).to_a
#for
for num in array do
  p num
end

#map
double_array = array.map do |x|
  x * 2
end
p double_array

#each
array.each do |num|
  p num
end

# reduce(inject)
p (1..10).reduce(0) { |sum, i| sum + i }


#loop
num = 5
loop {
  p num
  num+=10
  if num >= 100
    break
  end
}

num = 5
loop do
  p num
  num+=30
  if num >= 100
    break
  end
end

#times
4.times do |i|
  i += 10
  p i
end
#=>10 11 12 13

3.times do |i|
  puts i
end
#=> 0 1 2

■ timesメソッド
https://www.javadrive.jp/ruby/for/index6.html
変数に「0」から「対象のオブジェクトが持つ数値 - 1」を順に代入しながら
「{」から「}」までの処理(又は「do」から「end」までの処理)を実行する

＊timesメソッドの戻り値について
ループ処理する内容ではなく、「n.times」の部分の「n」の数字となる
https://qiita.com/Yinaura/items/09ccde0bae7c404f6f64
def example
  3.times do
    false
  end
end
example # => 3
