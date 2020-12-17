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
