#文字列の連結
str="朝、昼、晩"
print str.split('、')


str1="TEST"
print str1.split('、') #=>["TEST"]
print str1.split(" ")  #=>["TEST"]
print str1.split       #=>["TEST"]                 ＊原則、split("hogehoge")でhogehogeをオブジェクトから探し、それで分割する
print str1.split("")   #=>["T", "E", "S", "T"]     ＊区切り文字に""(ブランク)を指定すると、文字列を1文字ずつ分割


str="朝 昼 晩"
print str.split #デフォルトでは半角スペースがあれば分割可能

str="朝昼晩"
print str.split

=begin
”分割したい文字列”split(区切り文字, 分割数)
irb(main):001:0> "03-5555-5555".split("-",1)
=> ["03-5555-5555"]
irb(main):002:0> "03-5555-5555".split("-",2)
=> ["03", "5555-5555"]
irb(main):003:0> "03-5555-5555".split("-",3)
=> ["03", "5555", "5555"]
=end