#特殊なメソッド

#破壊的メソッド
arry=["apple", "orange", "cat"]
arry.delete_if{|name|name == "cat"}
p arry


#真偽値を返すメソッド
test1 = "dog"
p test1.empty?

test2 = ""
p test2.empty?
