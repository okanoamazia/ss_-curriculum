p File.exist?("1.rb")
p File.exist?("ファイル操作と文字コード/5.rb")


file = File.open("../数値と演算/1.rb", "r")
p file.read

File.open("../数値と演算/1.rb", "r") do |file|
  file.each_line do |i|
    puts i
  end
end

File.open("../数値と演算/1.rb", "r") do |file|
  p file.gets
  p file.gets
  p file.gets
end

