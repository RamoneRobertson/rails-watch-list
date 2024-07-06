url = "https://tmdb.lewagon.com/movie/top_rated"
movies_data = URI.open(url).read
movies_hash = JSON.parse(movies_data)
movie_results = movies_hash["results"]
poster_base_url = "https://image.tmdb.org/t/p/w500"

movie_results.take(10).each do |movie|
  Movie.create!(
    title: movie["title"],
    overview: movie["overview"],
    poster_url: poster_base_url + movie["poster_path"],
    rating: movie["vote_average"]
  )
end
