#エラーハンドリング
begin
  str="test"
  str.lenght
rescue => exception
  puts exception
  puts exception.class
  puts exception.message
  puts exception.backtrace
end