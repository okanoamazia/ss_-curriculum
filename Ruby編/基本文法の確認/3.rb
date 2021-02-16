#case
int = (1..9).to_a.sample
puts int
case
when int < 5
  puts "対象外"
when int >= 5 && int < 7
  puts "対象"
when int >= 7 && int < 9
  puts "重要"
else
  puts "存在しない"
end