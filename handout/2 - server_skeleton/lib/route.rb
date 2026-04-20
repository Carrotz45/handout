class Route 
  attr_reader :content_type, :matched_route
  def initialize(request)

    @method, @resource = request.method, request.resource

    @routes = {"/" => "index.html", "/pictures" => "pictures.html"} #method get

    @image_file_types = ["jpg", "png"]
    @audio_file_types = ["mp3", "ogg", "wav"]

    @file_types = {
      "image" => @image_file_types, 
      "audio" => @audio_file_types
    }

    @matched_route = matched_route


    if @method == "GET"

      path = @resource

      if path.include?("?")
        path = path.split("?").pop
      end

      @matched_route = check_matching_route(path)

    else

    end



  end

  def check_matching_route(resource)

    #kolla om det finns i html
    @routes.each do |key, value|
      if key == resource
        @content_type = "text/html"
        p "html fil finns hos html/#{value}"
        return "html/#{value}"
      end
    end

    #kolla i public för en fil som matchar resource
    if File.exist?("public#{resource}")

      #kolla i file types each value sedan kolla om fil typen efter punkt är med i arrayen

      path_file_type = (resource.split("."))[-1] #splitta vid . och behåll bara det sista värdet

      @file_types.each do |format, file_type|
        if file_type.include?(path_file_type)
          result = resource[1..-1]
          @content_type = "#{format}/#{path_file_type}"
          p "fil finns hos public/#{result}"
          return "public/#{result}"
        end
      end

      

      
    else
      p "404"
      return "html/404.html"
    end

    #ta bort kolla efter andra filer förutom html och att den kan sätta content type, flytta det till respons och kör om det inte hittas en html fil(if matched route true)
    #börja med make new routes, post och dynamic routes som /pictures/:id

  end

  def get(resource, &block)
    path = resource.split("/")
    path.each do |segment|
      
    end

      #kolla här om det har ett semicolon, om det har det så är det en icke statisk segment
      #spara sedan ordningen av dom

      #block är för saker som det den ska printa eller html filen, vad ska man göra om det inte finns en html fil?

      #2026/04/17


  end

  def post(path)
  end

  router.get("/hello/test") |id|
    return "hello"
  end
  def make_new_route(key, value)

  end

end

