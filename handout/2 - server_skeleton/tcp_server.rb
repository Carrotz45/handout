require 'socket'
require_relative 'lib/request'
require_relative 'lib/response'
require_relative 'lib/route'

class HTTPServer

  def initialize(router, port)
    @router = router
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



      @router.get_request(request)
      
      


      #p matched_route

      #response som inte kan ta emot post eller params:

      #route_test = Route.new()

      #route_test.get_request(request)

     # route_test.get("/hello/:id/test") do
     #   p "hello"

     #   file("hello")
     # end
    
      #route truthy
      #false falsy
      html = nil
      


      # session.print "HTTP/1.1 200\r\n"
      # p html.content_type
      # session.print "Content-Type: #{html.content_type}\r\n"
      # p html
      # #lägg till content length
      # session.print "\r\n"
      # session.print html
      # session.close


      session.print "HTTP/1.1 200\r\n"
      session.print "Content-Type: text\r\n"
      session.print "\r\n"
      session.print html
      session.close
    end
  end
end

