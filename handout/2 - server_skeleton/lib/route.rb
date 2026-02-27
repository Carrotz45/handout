class Route
  attr_reader 
  def initialize(request)
    @method, @resource, @version, @header, @params = request.method, request.resource, request.version, request.header, request.params

    if @method = "GET"
      
    
    elsif @method = "POST"

    end

  end

  def GET
    case @resource
      
  end

  def POST
  end



  def html_reader(route)
    Dir.chdir("../html")
    html = File.read(route)
    return html
  end

  def make_new_route
  end
end
