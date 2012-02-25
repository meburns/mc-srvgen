def updateServer()
  text = File.read("server.properties")
  text = text.sub(/white-list=.*/,"white-list=true")
  text = text.sub(/motd=A Minecraft Server/,"motd=apple")
  
  File.open("server.properties", "w") { |f| f.puts text }
end
