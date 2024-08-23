FactoryBot.define do
  factory :viewing_party do
    duration { 180 }
    date { "2024-12-25" }
    start_time { "19:00" }
    movie_id { 120 } # or any valid movie ID
  end
end
