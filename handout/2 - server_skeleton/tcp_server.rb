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

      if Request.new(@header = session.gets).method == "GET"
        data =+ @header
        while line = session.gets and line !~ /^\s*$/
          data += line
        end
      else
        data =+ @header
        while line = session.gets
          data += line
          
          if Request.new(data).params != {}
            break
          end
        end
      end


      puts "RECEIVED REQUEST"
      puts '-' * 40
      puts data
      puts '-' * 40

      request = Request.new(data)

      p request

      html = nil
      case request.resource #gör en route fil
      when "/"
        html = File.read("html/index.html")
      when "/pictures"
        html = File.read("html/pictures.html")
      else
        #error page
      end
 

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
