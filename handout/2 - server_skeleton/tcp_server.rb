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


      puts "RECEIVED REQUEST"
      puts '-' * 40
      puts data
      puts params if params
      puts '-' * 40


      
    
      p request

      html = nil
      case request.resource #gör en route fil
      when "/"
        html = File.binread("html/index.html")
      when "/pictures"
        html = File.binread("html/pictures.html")
  
        content_type= "text/html"
      else
        #kolla i public!
        Dir.chdir("public")
        file = request.resource[1..-1]
        content_type= "image/png"
        html = File.binread(file)
      end
 

      session.print "HTTP/1.1 200\r\n"
      session.print "Content-Type: #{content_type}\r\n"
      #lägg till content length
      session.print "\r\n"
      session.print html
      session.close
    end
  end
end

server = HTTPServer.new(4567)
server.start
