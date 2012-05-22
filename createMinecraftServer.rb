# test.rb 
# by meburns - 2/22/2012
require 'net/http'
require 'updateMinecraftServer'

# Dummy Data for Testing
$clan = "meburns"
$gameType = "classic"
$directoryName = "#{$clan}_#{$gameType}"
$serverProperties = Hash["white-list" => "true", "level-seed" => "1", "server-ip" => "127.0.0.1"]

# Make the new server's directory
def makeServerDirectory()
  begin
    Dir.chdir(".")
    Dir.mkdir($directoryName)
    puts "Directory Created for " + $directoryName + ".\n"
  rescue
    puts "\n Be Careful!!! This directory already exists!" + "\n"
    abort
  end
end

# Grab the latest Minecraft_server.jar and toss it in the new servers directory
def getMinecraftServer()
  Net::HTTP.start("s3.amazonaws.com") do |http|
    resp = http.get("/MinecraftDownload/launcher/minecraft_server.jar")
    open("#{$directoryName}/minecraft_server.jar", "wb") do |file|
      file.write(resp.body)
    end
    puts "minecraft_server.jar downloaded.\n"
  end
end

def initMinecraftServer()
  Dir.chdir($directoryName)
  # Initialize the server, give it a second to populate the files, kill the server, remove the corrupted world folder
  system "java -Xms32M -Xmx512M -jar minecraft_server.jar nogui >/dev/null 2>&1 & sleep 1 && kill -9 $! && rm -r world"
  puts "Server Initialized.\n"
  updateServer($serverProperties)

end

# Run all the main functions
  makeServerDirectory()
  getMinecraftServer()
  initMinecraftServer()
