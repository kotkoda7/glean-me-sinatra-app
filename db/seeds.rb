#apple_tree = Edible.create(id: 1, name: "Apple Tree")
#blueberry_bushes = Edible.create(id: 2, name: "Blueberry Bush")
#blackberry_bushes = Edible.create(id: 3, name: "Blackberry Bush")
#raspberry_bushes = Edible.create(id: 4, name: "Raspberry Bush")
#peach_tree = Edible.create(id: 5, name: "Peach Tree")
#pear_tree = Edible.create(id: 6, name: "Pear Tree")

roxie = User.create(id: 1, username: "Roxie", password: "abcd")
leo = User.create(id:2, username: "Leo", password: "efgh")

seattle = Location.create(id: 1, user_id: 1, edible: "Apple Tree", loc_type: "public", lat: 47.6062, lng: -100.3321, address: "Seattle, WA")
portland = Location.create(id: 2, user_id: 2, edible: "Bluberry Bush", loc_type: "private", lat: 45.5122, lng: -122.6587, address: "Portland, WA")