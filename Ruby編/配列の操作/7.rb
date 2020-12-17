#Rangeオブジェクトを使って配列を作る
array1=("a".."z").to_a
p array1

p 1..5

range1=Range.new(1,10)
p range1
array2=range1.to_a
p array2