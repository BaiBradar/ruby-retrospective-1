class Song
  
  attr_accessor :name, :artist, :genre, :subgenre, :tags
  
  def initialize(name, artist, genre, subgenre, tags)
    
    @name = name
    @artist = artist
    @genre = genre
    @subgenre = subgenre
    @tags = tags
    
  end
  
  def matches?(criteria)
    criteria.all? do |key, value|
      case key
      when :name then name == value
      when :artist then artist == value
      when :filter then value.self
      when :tags then Array(value).all? { |tag| matches_tag?(tag) }
      end
    end
  end
  
  def matches_tag?(tag)
    if tag.end_with?("!") then !@tags.include?(tag.chomp("!"))
    else @tags.include?(tag)
    end
  end
  
end

class Collection
  
  attr_accessor :collection
  
  def initialize(songs_as_string, artist_tags)
    @collection = []
    fill_collection(songs_as_string, artist_tags)
  end
  
  def fill_collection(songs_as_string, artist_tags)
    songs_as_string.each_line do |line|
      name, artist, genre_subgenre, tags = line.split(".").map(&:strip)
      genre_subgenre = genre_subgenre.split(", ")
      genre, subgenre = genre_subgenre[0], genre_subgenre.fetch(1, nil)
      tags = tags.nil? ? [] : tags.split(",").map(&:strip)
      tags += genre_subgenre.map(&:downcase) + artist_tags.fetch(:artist, [])
      @collection << Song.new(name, artist, genre, subgenre, tags)
    end
  end
  
  def find(criteria)
    @collection.select { |song| song.matches?(criteria) }
  end
  
end
