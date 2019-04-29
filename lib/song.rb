require_relative './findable.rb'
# require_relative './nameable.rb'
# require_relative './persistable.rb'

class Song
  extend Findable::ClassMethods
  extend Concerns::ClassMethods
  # extend Nameable::ClassMethods
  # include Persistable::InstanceMethods
  
  attr_accessor :name 
  attr_reader :artist, :genre
  
  @@all = []
  
  def initialize(name, artist = nil, genre = nil)
    @name = name 
    self.artist = artist if artist
    self.genre = genre if genre
  end 
  
  def self.all
    @@all
  end 
  
  def save
    @@all << self
  end 
  
  def self.destroy_all
    @@all.clear
  end
  
  def self.count
    @@all.size 
  end
  
  def self.find_by_name(name)
       all.detect {|i| i.name == name}
   end
  
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end
  
  def genre=(genre)
    genre.songs << self unless genre.songs.include?(self)
    @genre = genre
  end
    
  def song.create(name) 
       new(name).tap {|song| song.save}
  #     song = new(name) 
  #     song.save
  #     song 
  end
   
   def self.find_or_create_by_name(name)
      find_by_name(name)|| create(name)
   end 
  
  def self.new_from_filename(filename)
    parts = filename.split("-")
    artist_name, song_name, genre_name = parts[0], parts[1], parts[2].gsub(".mp3", "")
    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)
    new(song_name, artist, genre)
  end 
  
  def self.create_from_filename(filename)
    new_from_filename(filename).tap{|song| song.save}
  end 
end 