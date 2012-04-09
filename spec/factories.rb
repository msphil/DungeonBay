# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.name                  "Mike Phillips"
  user.email                 "msphil@gmail.com"
  user.password              "filfre"
  user.password_confirmation "filfre"
end
