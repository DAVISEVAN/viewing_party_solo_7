# spec/factories/movies.rb
FactoryBot.define do
  factory :movie do
    initialize_with do
      new({
        id: 120,
        title: "The Lord of the Rings: The Fellowship of the Ring",
        vote_average: 8.414,
        runtime: 179,
        genres: [
          { name: "Adventure" },
          { name: "Fantasy" },
          { name: "Action" }
        ],
        overview: "Young hobbit Frodo Baggins, after inheriting a mysterious ring from his uncle Bilbo...",
        poster_path: "/6oom5QYQ2yQTMJIbnvbkBL9cHo6.jpg",
        release_date: "2001-12-18"
      })
    end
  end
end
