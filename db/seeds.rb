User.transaction do
  User.create!(name: 'Joe', color: 'darkturquoise')
  User.create!(name: 'Ann', color: 'red')
  User.create!(name: 'Tim', color: 'yellow')
  User.create!(name: 'Sean', color: 'green')
  User.create!(name: 'Paul', color: 'orange')
end
