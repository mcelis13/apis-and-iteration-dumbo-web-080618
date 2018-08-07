# note: in this demonstration we name many of the variables _hash or _array.
# This is done for educational purposes. This is not typically done in code.


# iterate over the response hash to find the collection of `films` for the given
#   `character`
# collect those film API urls, make a web request to each URL to get the info
#  for that film
# return value of this method should be collection of info about each film.
#  i.e. an array of hashes in which each hash reps a given film
# this collection will be the argument given to `parse_character_movies`
#  and that method will do some nice presentation stuff: puts out a list
#  of movies by title. play around with puts out other info about a given film.
require 'rest-client'
require 'json'
require 'pry'

def fetch(url)
  response_string = RestClient.get(url)
  response_hash = JSON.parse(response_string)
end

def all_links
  link_array = []
  link = 'http://www.swapi.co/api/people/?page='
  for counter in 1..9
    fetched_url = fetch(link + "#{counter}")
    link_array << fetched_url['results']
  end
  link_array
end


def get_character_movies_from_api(character)
  films_array = []
  films_hash = []
  #get the array with the names and movies
  all_links.flatten.each do |characterObj|
    if characterObj['name'].downcase == character
      films_array = characterObj['films']
    end
  end

  films_array.each do |film_link|
    films_hash << fetch(film_link)
  end

  films_hash
end


def print_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list]
  films_hash.each_with_index do |movie, idx|
    puts "#{idx + 1}. #{movie['title']}"
  end
end

def show_character_movies(character)
  films_array = get_character_movies_from_api(character)
  print_movies(films_array)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
