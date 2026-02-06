require 'socket'
require_relative 'lib/request'

class HTTPServer

  def initialize(port)
    @port = port
  end

  def start
    server = TCPServer.new(@port)
    puts "Listening on #{@port}"

    while session = server.accept
      data = ''

      body = ''

      params = ''

      while line = session.gets and line !~ /^\s*$/
        header += line
      end
      #session läser av varje linje, få tag på de linjerna efter tom rad och lägg in i params


      data = body, params #uhh är detta rätt


      puts "RECEIVED REQUEST"
      puts '-' * 40
      puts data
      puts '-' * 40

      request = Request.new(data)

      p request

      html = "<h1>Hello, World!</h1>"

      session.print "HTTP/1.1 200\r\n"
      session.print "Content-Type: text/html\r\n"
      session.print "\r\n"
      session.print html
      session.close
    end
  end
end

server = HTTPServer.new(4567)
server.start
