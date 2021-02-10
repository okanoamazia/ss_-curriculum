#第2章：配列、ハッシュ

#例題11
p (1..3).map{|i| i**2}

p (1..3).to_h{|i|[i, i**2]}

#例題12 
#RE

#例題13
array = [["×", "×", "○"], ["○", "○", "×"], ["×", "○","×"]]
p array.flat_map(&:itself)

hash = { name: ["田中", "nil", "太郎"], address: ["東京都", ["港区", ["芝浦"]]], age: [20], membership: [false] }
p hash.transform_values(&:flatten)

#例題14
languages = ["Mandarin", "Spanish", "English", "Hindi", "Arabic"]
p languages[2,2]  #配列[開始インデックス、数] で開始インデックスから数指定分要素を取り出した配列を作成出来る

#例題15
teeth = {"切歯" => {"中_" => 1, "側_" => 2}, "犬歯" => 3, "臼歯" => {"小_" => [4, 5], "大_" => [6, 7, 8]}}
p teeth["臼歯"]["大_"][2]
keys_2=["切歯", "小_", "側_"]
p teeth.dig(*keys_2)

#例題16
#RE

#例題17
array = [1,1,2,3,5,8,13,21,26]
p array.find {|x| x%13 == 0}

#例題18
#配列の書き換え ["red", "blue"] と %W(red blue)は一緒
keys = %W[garnet amethyst aquamarine diamond emerald perl]
array = %W[garnet diamond onyx]
p keys & array

hash = {"garnet" => "Aquarius", "amethyst" => "Pisces", "onyx" => "Leo"}
p hash.slice(*keys) #sliceはハッシュ対しても使える（自分が取り出したい部分だけを簡単に選び出す）

#例題19
array = [1, 17, 14, 9, 3, 16, 15, 3, 18, 13]
p array.sort 
p array.sort.reverse

#例題20
hash1 = {
  "Perl" => "Warhol",
  "Python" => "van Rossum",
  "Ruby" => "Mazt"
}

hash2 = {
  "Perl" => "Wall",
  "Ruby" => "Mozt"
}

p hash1.merge!(hash2)
