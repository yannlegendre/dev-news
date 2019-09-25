THEMES = ["Python",]


puts "Destroying current seeds"
Theme.destroy_all

puts "Creating users"
User.create(email:"a@a", password: "azertyuiop")

puts "Creating themes"
  50.times do
    Theme.create(name: Faker::ProgrammingLanguage.name)
  end
puts "Themes created"


putd "All done!"
