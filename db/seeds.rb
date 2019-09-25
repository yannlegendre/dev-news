LANGUAGES = %w{ruby rails mvc python c c++ javascript html cryptocurrency webdevelopment scss nodejs vue angular tdd ddd react java pascal excel}

puts "Destroying current seeds"
Theme.destroy_all

puts "Creating users"
User.create(email:"a@a", password: "azertyuiop")
puts "Users created"

puts "Creating themes"
  50.times do
    Theme.create(name: Faker::Hacker.adjective)
  end
  LANGUAGES.each do |language|
    Theme.create(name: language)
  end
puts "Themes created"

ap Theme.all

puts "All done!"
