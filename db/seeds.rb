User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

category1 = Category.create(title: 'fun')
category2 = Category.create(title: 'sports')
category3 = Category.create(title: 'news')
category4 = Category.create(title: 'game')
categories=[category1, category2, category3, category4]

users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each do |user|
    post = user.microposts.create!(content: content)
    post.categories << categories.sample
    post.categories << categories.sample
  end
end
