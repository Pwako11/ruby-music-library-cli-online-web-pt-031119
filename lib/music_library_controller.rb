class MusicLibraryController
  def initialize(path = "./db/mp3s")
    MusicImporter.new(path).import 
  end 
  
  def call
    input = ""
    while input != "exit"
    
end 