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
    Campaign.create!(:name => "Darokin", 
                     :description => "Wild adventures along the river Streel!",
                     :owner_id => 1,
                     :img_url => "http://www.icculus.org/~msphil/dbay/campaigns/campaign-1.png")
    user = User.find_by_id(1)
    2.times do |i|
      word = Faker::Lorem.words(2)
      campaign = user.campaigns.create!(:name => word[0], :description => Faker::Lorem.sentence(3))
      character = user.characters.create!(:name => word[1], :description => Faker::Lorem.sentence(3))
      character.campaign_id = campaign.id
      character.img_url = "http://www.icculus.org/~msphil/dbay/chars/character-#{i+1}.png"
      character.save
      5.times do
        randomplus = Random.rand(5) + 1
        word = Faker::Lorem.words(2)
        character.items.create!(:name => "+#{randomplus} " + word[0] + " of " + word[1], :description => Faker::Lorem.sentence(10), :campaign => campaign)
      end
    end
  end
end
