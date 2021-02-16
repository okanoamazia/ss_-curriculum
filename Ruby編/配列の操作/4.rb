#条件を指定して配列の要素を絞り込む
array = [1,2,3,4,5,6,7,8,9]
p array.select{|i| i > 3}
p array.select{|i| i % 3 == 0}
p array.select{|i| i % 10 == 0}


new_array = array.select do |n|
  n > 9
end

p new_array

p array.find{|n| n % 2 == 0}

new2_array = array.find do |n|
  n % 6 == 0
end

p new2_array