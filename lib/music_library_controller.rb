class MusicLibraryController
  def initialize(path = "./db/mp3s")
    MusicImporter.new(path).import 
  end 
  
  def call
    input = ""
    while input != "exit"
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      input = gets.strip
      case input
      when "list songs"
        list_songs
      when "list artists"
        list_artists
      when "list genres"
        list_genres
      when "list artist"
        list_songs_by_artist
      when "list genre"
        list_songs_by_genre
      when"play song"
        play_song
      end
    end 
  end 
  def list_songs 
    Song.all.sort{|y, z| y.name <=> z.name}.each.with_index(1) do |a, i|
      puts "#{i}. #{a.artist.name} - #{a.name} - #{a.genre.name}"
    end
    
    def list_artists
    Artist.all.sort{|y, z| y.name <=> z.name}.each.with_index(1) do |b, i|
      puts "#{i}. #{b.name}"
    end
    
    def list_genres
    Genre.all.sort{|y, z| y.name <=> z.name}.each.with_index(1) do |c, i|
      puts "#{i}. #{c.name}"
    end
  end 
  
  def list_songs_by_artist
    puts "please enter the name of an artist:"
    input = gets.strip
    
    if artist = Artist.find_by_name(input)
      artist.songs.sort{|y, z| y.name <=> z.name}.each.with_index(1) do |b, i|
        puts "#{i}. #{b.name} - #{b.genre.name}"
      end 
    end 
  end 
  
  def list_songs_by_genre
    puts "please enter the name of an genre:"
    input = gets.strip
    
    if genre = Genre.find_by_name(input)
      genre.songs.sort{|y, z| y.name <=> z.name}.each.with_index(1) do |c, i|
        puts "#{i}. #{c.artist.name} - #{c.name}"
      end 
    end 
  end 
  
  def play_song 
    puts "Which song number would you like to play?"
    input = gets.strip.to.i 
    if (1..song.all.length).include?(input)
      song = Song.all.sort{|y, z| y.name <=> z.name}[input -1]
    end 
end 