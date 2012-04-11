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

Factory.define :item do |item|
  item.description "This is a cool item!"
  item.association :user
end
