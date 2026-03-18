class Route 
  attr_reader :content_type, :matched_route
  def initialize(request)

    @method, @resource = request.method, request.resource

    @routes = {} #method get


    if @method = "GET"

      path = @resource

      if path.include?("?")
        path = path.split("?").pop
      end

      

    end



  end

  def get(path)
  end

  def post(path)
  end

  def make_new_route(key, value)

  end

end

