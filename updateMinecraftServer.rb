def updateServer(a)

  b = Hash.new

  # Turn minecraft's server.properties into a hash.
  File.open("server.properties").each { |line|
    unless line.match(/^\#/)
      c,d = line.split("=")
      b[c] = d
    end
  }

  # Merge the new hash and the original server.properties hash.
  a.each { |key, value|
    b[key] = value
  }

  # Recreate the server.properties file.
  text = ""
  b.each_key { |key|
    text += "#{key}=#{b[key]}"
  }

  # Overwrite the old server.properties with the newly merged one.
  File.open("server.properties", "w") { |f| f.puts text }
end
