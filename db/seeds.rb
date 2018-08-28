

roxie = User.create(id: 1, username: "Roxie", password: "abcd")
leo = User.create(id:2, username: "Leo", password: "efgh")

seattle = Location.create(id: 1, user_id: 2, edible: "Apple Tree", loc_type: "public", lat: 47.6062, lng: -100.3321, address: "Seattle, WA")
portland = Location.create(id: 2, user_id: 1, edible: "Blueberry Bush", loc_type: "private", lat: 45.5122, lng: -122.6587, address: "Portland, WA")
