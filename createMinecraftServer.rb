# test.rb 
# by meburns - 2/22/2012
require 'net/http'

$clan = "meburns"
$gameType = "classic"
$directoryName = "#{$clan}_#{$gameType}"

# Run all the main functions
def main()
#  makeServerDirectory()
#  getMinecraftServer()
  initMinecraftServer() 
end

# Make the new server's directory
def makeServerDirectory()
  begin
    Dir.chdir(".")
    Dir.mkdir($directoryName)
  rescue
    puts "\n Be Careful!!! This directory already exists!"; puts "\n"
  end
end

# Grab the latest Minecraft_server.jar and toss it in the new servers directory
def getMinecraftServer()
  Net::HTTP.start("s3.amazonaws.com") do |http|
    resp = http.get("/MinecraftDownload/launcher/minecraft_server.jar")
    open("#{$directoryName}/minecraft_server.jar", "wb") do |file|
      file.write(resp.body)
    end
  end
end

def initMinecraftServer()
  Dir.chdir($directoryName)
  system "java -Xms32M -Xmx512M -jar minecraft_server.jar nogui"
end

main()
