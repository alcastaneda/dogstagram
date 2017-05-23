users = ["adri124","channing123", "ron124", "kitty56", "bob", "ski55", "lilo92"]

users.each do |username|
	User.create(username: username)
end

50.times do
	Photo.create(user_id: rand(1..7) , photo_url: "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5c/English_Bulldog_puppy.jpg/220px-English_Bulldog_puppy.jpg" )
end

15.times do
	Like.create(user_id: rand(1..7), photo_id: rand(1..50))
end
