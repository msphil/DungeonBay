namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    User.create!(:name => "Example User",
                 :email => "example@railstutorial.org",
                 :password => "filfre",
                 :password_confirmation => "filfre")
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
    end
    50.times do
      User.all(:limit => 6).each do |user|
        randomplus = Random.rand(5) + 1
        word = Faker::Lorem.words(1)
        user.items.create!(:description => "+#{randomplus} " + word[0] + " of " + Faker::Lorem.sentence(3))
      end
    end
  end
end
