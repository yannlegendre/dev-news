LANGUAGES = %w{programming data apps aws ux hardware productivity agile software software pwa engineering windows vim youtube interviewing ruby rails blockchain sql mvc python php c c++ javascript html cryptocurrency webdevelopment scss nodejs vue.js angular tdd ddd react java pascal excel}

puts "Destroying current seeds"
Theme.destroy_all

puts "Creating users"
User.create(email:"a@a", password: "azertyuiop")
puts "Users created"

puts "Creating themes"
  100.times do
    Theme.create(name: Faker::Hacker.adjective)
    Theme.create(name: Faker::Hacker.verb)
    Theme.create(name: Faker::Hacker.abbreviation)
  end
  LANGUAGES.each do |language|
    Theme.create(name: language)
  end

puts "#{Theme.count} themes created."
