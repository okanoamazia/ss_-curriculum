#プログラムの流れの制御
#例題21
array = %w[foo bar baz]
p array.find{|str| str.start_with?("b")}&.capitalize
p array.find{|str| str.start_with?("c")}&.capitalize    # &. を使うことで、メソッド連鎖中にnilになった場合でも、エラーにせずnilを返すようにできる


#例題22
#RE

#例題23
# nil は to_s, to_h を使うことで空のオブジェクトにすることができる
!error.to_s.empty?
# error が nil            !なし　#=> true 
# error が 文字列    !なし　#=> false  
!error.to_h.empty?

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

#例題26

