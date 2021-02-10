#破壊的なメソッド
str="movie"
str1=str.upcase
puts str.object_id
puts str1.object_id

str="movie"
str1=str.upcase!
puts str.object_id
puts str1.object_id
