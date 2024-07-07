key = ENV["TMDB_API_KEY"]
base_url = "https://api.themoviedb.org/3/"
popular_url = "movie/popular?api_key=#{key}"
# full url
popular_movies_url = base_url + popular_url

puts "Clearing Database..."
Bookmark.delete_all
Movie.delete_all
List.delete_all

puts "Cresting lists"
popular_list = List.create!(name: "Trending")


puts "Getting popular movies data"
movies_data = URI.open(popular_movies_url).read
movies_hash = JSON.parse(movies_data)
results = movies_hash["results"]
poster_base_url = "https://image.tmdb.org/t/p/w500"

puts "Creating movies..."
results.each do |movie|
  Movie.create!(
    title: movie["title"],
    overview: movie["overview"],
    poster_url: poster_base_url + movie["poster_path"],
    rating: movie["vote_average"]
  )
end

puts "Created #{Movie.count} movies"

puts "Creating bookmarks"
movies = Movie.all
bookmark_movies = movies.sample(10)
bookmark_movies.each do |movie|
  Bookmark.create!(
    comment: Faker::Movie.quote,
    list_id: popular_list.id,
    movie_id: movie.id
  )
end

puts "Seeding complete!"
