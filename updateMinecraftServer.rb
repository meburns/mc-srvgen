def updateServer(a)

  b = Hash.new
  File.open("server.properties").each { |line|
    c,d = line.split("=")
    b[c] = d
  }

  a.each { |key, value|
    b[key] = value
  }

  text = ""
  b.each_key { |key|
    text += "#{key}=#{b[key]}"
  }

  File.open("server.properties", "w") { |f| f.puts text }
end
