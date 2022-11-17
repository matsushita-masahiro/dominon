# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#


# ExtendedVersion.destroy_all
# User.all.destroy_all
# Match.all.destroy_all
# Entry.all.destroy_all
# MatchInning.all.destroy_all
# MatchResult.all.destroy_all
# ex_version = ["基本","陰謀","収穫祭・錬金術","海辺","冒険","帝国"]
# version = [[1,2],[1,3], [1,4],[3,4]]

# ex_version.each_with_index do |ev, index|
#     ExtendedVersion.create(id: index+1, name: ev)
# end



# user = ["a","b","c","d","e","f","g","h"]

# user.each_with_index do |user,index|
#     User.create(id: index+1, name: user, email: "#{user}@gmail.com", password: "111111", nickname: "nickname-#{user}")
# end

# 4.times do |i|
#     Match.create(id: (i+1), name: "試合#{i+1}", place: "神泉")
# end

# Entry.create(match_id: 1, user_id: 1)
# Entry.create(match_id: 1, user_id: 2)
# Entry.create(match_id: 1, user_id: 3)


# Entry.create(match_id: 2, user_id: 1)
# Entry.create(match_id: 2, user_id: 2)
# Entry.create(match_id: 2, user_id: 4)

# Entry.create(match_id: 3, user_id: 1)
# Entry.create(match_id: 3, user_id: 2)
# Entry.create(match_id: 3, user_id: 5)

# Entry.create(match_id: 4, user_id: 1)
# Entry.create(match_id: 4, user_id: 2)
# Entry.create(match_id: 4, user_id: 6)
# Entry.create(match_id: 4, user_id: 7)

# id = 1
# Match.all.each_with_index do |m,i|
#     2.times do |k|
#         x = (i+k)%4
#         MatchInning.create(id: id, match_id: m.id, version_used: version[x], inning_number: (k+1))
#         id = id + 1
#     end
# end


# [1,2,3].each do |user|
#   MatchResult.create(match_inning_id: MatchInning.find(1).id, user_id: user, point: user*10)
# end