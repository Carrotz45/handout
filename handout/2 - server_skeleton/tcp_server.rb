require 'socket'
require_relative 'lib/request'
require_relative 'lib/response'
require_relative 'lib/route'

class HTTPServer

  def initialize(port)
    @port = port
  end

  def start
    server = TCPServer.new(@port)
    puts "Listening on #{@port}"

    while session = server.accept
      data = ''

      line = session.gets
      while line && line !~ /^\s*$/
        data += line
        line = session.gets  # läs nästa rad
      end

      request = Request.new(data)

      if request.method == "POST"
        bytes = request.header["Content-Length"]
        p bytes
        params = session.read(bytes.to_i)
        p params
        request.add_post_params(params)
      end

      p request


      puts "RECEIVED REQUEST"
      puts '-' * 40
      puts data
      puts params if params
      puts '-' * 40

      
      


      #p matched_route

      #response som inte kan ta emot post eller params:

      route_test = Route.new(request)


      html = nil
      
      content_type = route_test.content_type
      matched_route = route_test.matched_route

  
      html = File.binread(matched_route)
      #


      #html = Response.new(request)

      # session.print "HTTP/1.1 200\r\n"
      # p html.content_type
      # session.print "Content-Type: #{html.content_type}\r\n"
      # p html
      # #lägg till content length
      # session.print "\r\n"
      # session.print html
      # session.close


      session.print "HTTP/1.1 200\r\n"
      session.print "Content-Type: #{content_type}\r\n"
      p content_type
      session.print "\r\n"
      session.print html
      session.close
    end
  end
end

server = HTTPServer.new(4567)
server.start
