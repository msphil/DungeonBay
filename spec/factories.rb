# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.name                  "Mike Phillips"
  user.email                 "msphil@gmail.com"
  user.password              "filfre"
  user.password_confirmation "filfre"
end

Factory.sequence :name do |n|
  "Person #{n}"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :campaign do |campaign|
  campaign.name "My Campaign"
  campaign.description "Really cool setting and game system"
  campaign.association :user
end

Factory.define :character do |character|
  character.name "My Character"
  character.description "9th Level Tester"
  character.association :campaign
  character.association :user
end

Factory.define :item do |item|
  item.name "+4 item of testing"
  item.description "This is a cool item!"
  item.association :character
end
