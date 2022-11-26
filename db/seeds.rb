# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#


ExtendedVersion.destroy_all
User.all.destroy_all
Match.all.destroy_all
Entry.all.destroy_all
MatchInning.all.destroy_all
MatchResult.all.destroy_all
ex_version = ["基本","陰謀","収穫祭・錬金術","海辺","冒険","帝国","繁栄","異郷","暗黒時代","ギルド","夜想曲","ルネサンス","移動動物園","同盟"]
version = [[1,2],[1,3], [1,4],[3,4]]

ex_version.each_with_index do |ev, index|
    ExtendedVersion.create(id: index+1, name: ev)
end



user = ["a","b","c","d","e","f","g","h"]

user.each_with_index do |user,index|
    User.create(id: index+1, name: user, email: "#{user}@gmail.com", password: "111111", nickname: "nickname-#{user}")
end



ex_version_omit = [["基本", "基"],["陰謀","陰"],["収穫祭・錬金術","収錬"],["海辺","海"],["冒険","冒"],["帝国","帝"],
                  ["繁栄","繁"],["異郷","異"],["暗黒時代","暗"],["ギルド","ギ"],["夜想曲","夜"],["ルネサンス","ル"],["移動動物園","移"],["同盟","同"]]
ex_version_omit.each do |evo|
    ev = ExtendedVersion.find_by(name: evo[0])
    ev.update(omit_word: evo[1])
end