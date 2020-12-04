#if else, unless
age = 19
if age < 18
  puts "未成年であり、お酒は飲めません。"
elsif age >= 18 && age < 20
  puts "未成年ではないですが、お酒を飲めません。"
else 
  puts "未成年ではないですし、お酒を飲めます。"
end

age = 20
if age < 18
  puts "未成年であり、お酒は飲めません。"
elsif age >= 18 && age < 20
  puts "未成年ではないですが、お酒を飲めません。"
else 
  puts "未成年ではないですし、お酒を飲めます。"
end

age = 19
unless age >= 20
  puts "20歳未満の方は入場できません"
end
