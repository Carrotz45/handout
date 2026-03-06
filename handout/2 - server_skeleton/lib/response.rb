class Response
  attr_reader :content_type
  def initialize(request)
    @method, @resource, @version, @header, @params = request.method, request.resource, request.version, request.header, request.params
    
    @content_type = "text/html"

    if @method == "GET"
      GET()
    
    elsif @method == "POST"

    end

  end

  image_file_types = ["jpg", "png"]
  text_file_types = ["html"]
  audio_file_types = ["mp3", "ogg", "wav"]

  file_types = [["image", image_file_types], ["text", text_file_types], ["audio", audio_file_types]].to_h

  routes = [
    ["/", "index.html"], 
    ["/pictures", "pictures.html"]
  ].to_h 


  def GET
    if File.exist?("public/#{@resource}")
      
      p "file exists!"
      response = File.binread("public/#{@resource}")

      file_type = nil

      image_file_types.each do |type| #gör detta så att det fungerar med alla typer av format
        if @resource.include?(type)
          file_type = type
        end



      end


      @content_type = "text/#{file_type}"
      
      return response

    else 

      if File.exist?()
      
      elsif @resource.include?("?")
        path = @resource.split("?").pop

        html_file = routes[path]
      end


      response = File.binread("html/#{html_file}")

      return response


    else
      p "error 404"
    end

  end



  def POST
  end



  def html_reader(route)
    html = File.read("html/#{route}")
    return html
  end

  def make_new_route
  end
end
