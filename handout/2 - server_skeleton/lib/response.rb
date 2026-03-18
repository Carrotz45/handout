class Response
  attr_reader :content_type
  def initialize(request)
    @method, @resource, @params = request.method, request.resource, request.params
    
    @content_type = "text/html"

    if @method == "GET"
      GET()
    
    elsif @method == "POST"

    end

  end

  @image_file_types = ["jpg", "png"]
  @audio_file_types = ["mp3", "ogg", "wav"]

  @file_types = {
    "image" => @image_file_types, 
    "audio" => @audio_file_types
  }

  

  def GET
    @routes = [
      ["/", "index.html"], 
      ["/pictures", "pictures.html"]
    ].to_h 

    path = @resource

    

    if path.include?("?")
      path = path.split("?").pop
    end


    html_file = @routes[path]


    if File.exist?("html#{html_file}")

      p "html exists at html#{html_file}"
      
      response = File.binread("html/#{html_file}")

      @content_type = "text/html"

      return response

    elsif File.exist?("public#{path}")

      p "file exists at public#{path}"

      response = File.binread("public#{path}")

      file_type = path.split(".").delete_at(0) #fixa så att om filen har flera punkter funkar detta ändå

      @file_types.each do |key, value|
 
        if value.include?(file_type)
          @content_type = "#{key}/#{value}"
        end

      end
      
      return response

    else
      #404
    end


  end



  def POST
  end


  def make_new_route
  end
end
