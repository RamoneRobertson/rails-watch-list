key = ENV["TMDB_API_KEY"]
# URLS
base_url = "https://api.themoviedb.org/3/"
popular_url = "movie/popular?api_key=#{key}"
genres_url = "https://api.themoviedb.org/3/genre/movie/list?api_key=#{key}"
search_genre = "https://api.themoviedb.org/3/discover/movie?api_key=#{key}&with_genres="
poster_base_url = "https://image.tmdb.org/t/p/w500"

# full url
popular_movies_url = base_url + popular_url

puts "Clearing Database..."
Bookmark.delete_all
Movie.delete_all
List.delete_all

def parse_movie_data(url)
  movie_file = URI.open(url).read
  JSON.parse(movie_file)
end

genres_data = parse_movie_data(genres_url)
genres = genres_data["genres"]

movie_reviews = [
  "An outstanding film with a gripping storyline.",
  "A masterpiece that captures the essence of the genre.",
  "A heartwarming tale that will leave you in tears.",
  "A cinematic experience that you won't forget.",
  "A must-watch for all movie lovers.",
  "A compelling narrative with superb acting.",
  "An average film with a few memorable moments.",
  "A beautifully shot movie with stunning visuals.",
  "A great film with a powerful message.",
  "A disappointing film that fails to deliver.",
  "An entertaining movie with plenty of laughs.",
  "A thrilling ride from start to finish.",
  "A touching story that resonates deeply.",
  "A mediocre film with a predictable plot.",
  "An exceptional performance by the lead actor.",
  "A movie that will keep you on the edge of your seat.",
  "A forgettable film that lacks originality.",
  "A well-crafted film with excellent direction.",
  "A movie that offers a fresh perspective.",
  "A thought-provoking film that challenges norms.",
  "A visually stunning film with a weak plot.",
  "An emotional rollercoaster with a satisfying ending.",
  "A fantastic film with brilliant performances.",
  "A lackluster movie that could have been better.",
  "A superb film with a well-written script.",
  "A charming movie that is perfect for a family night.",
  "An action-packed film with great special effects.",
  "A dull film that drags on for too long.",
  "A heart-pounding thriller that keeps you guessing.",
  "A delightful movie that is both funny and touching.",
  "A well-acted film with a thought-provoking story.",
  "A boring film with uninspired performances.",
  "An inspiring film that leaves a lasting impression.",
  "A fun movie with lots of laughs and excitement.",
  "A poorly executed film with a weak storyline.",
  "A beautiful film with an amazing soundtrack.",
  "A poignant story that is beautifully told.",
  "A mind-bending film that keeps you thinking.",
  "A poorly written film with unconvincing characters.",
  "A powerful film with a strong emotional core.",
  "A light-hearted film that is a joy to watch.",
  "A film with stunning visuals but lacking in substance.",
  "A thought-provoking movie that stays with you.",
  "A film with an amazing cast but a mediocre plot.",
  "A movie that is both thrilling and entertaining.",
  "A film that fails to live up to its potential.",
  "An excellent film with a compelling narrative.",
  "A captivating story that is well worth your time.",
  "A predictable film that offers nothing new.",
  "An enjoyable film with great performances."
]

puts "Creating lists and movies"
genres.each do |genre|
  list = List.create(name: genre["name"])
  movies_data = parse_movie_data("#{search_genre}#{genre["id"]}")
  results = movies_data["results"]
  # selected_movies = results.take(3)
  results.each do |movie|
    if Movie.where(title: movie["title"]).exists?
      puts "Record exist for #{movie["title"]}"
    else
      puts "Creating #{movie["title"]}"
      new_movie = Movie.create!(
          title: movie["title"],
          overview: movie["overview"],
          poster_url: poster_base_url + movie["poster_path"],
          rating: movie["vote_average"]
        )
        puts "Creating new bookmark for #{list.name}"
      Bookmark.create!(
        comment: movie_reviews.sample,
        movie_id: new_movie.id,
        list_id: list.id
      )
    end
  end
end

puts "Created #{Movie.count} movies"
puts "Seeding complete!"
