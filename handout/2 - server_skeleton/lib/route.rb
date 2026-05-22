class Route 
  #attr_accessor :request, :new_html_file

  
  def initialize()

    @routes = {
      [{"part" => "", "dynamic?" => false}] => "index.html",
      [{"part" => "test", "dynamic?" => false}] => "test_static.html",
      [{"part" => "pictures", "dynamic?" => false}, {"part" => ":id", "dynamic?" => true}] => "pictures.html"
    } 
    

    if @method == "GET"

    elsif @method == "POST"

    end


  end


  def get_request(request)
    @request = request
  end

  def get_new_file(file)
    @new_html_file = file
  end

  def check_matching_route(app_resource ,incoming_resource)
    app_resource_amount_of_parts = app_resource.length
    incoming_resource_amount_of_parts = incoming_resource.length

    if app_resource_amount_of_parts == incoming_resource_amount_of_parts

      for i in 0..app_resource_amount_of_parts-1 do
        app_segment = app_resource[i]
        incoming_segment = incoming_resource[i]
        if app_segment["dynamic?"] == false && incoming_segment["dynamic?"] == false

          if app_segment["part"] == incoming_segment["part"]
            p "static match"
            matches += 1
          end

        elsif app_segment["dynamic?"] == true
          p "dynamic match"
          matches +=1
          @params << incoming_segment["part"]
        end
        p"-------"
      end

      if matches == app_resource_amount_of_parts
        matched_route = app_resource
        return matched_route
      end

    end

    return false

  end




  def get(app_resource, &block)

    indexed_app_resource = index_resource(app_resource)

    indexed_request_resource = index_resource(@request.resource)

    if check_matching_route(indexed_app_resource, indexed_request_resource) != false
      p @params
      block.call(@params)
    end
  end

  def post(path)
  end

  def make_new_route(key, value)
    @routes[key] = value
  end





  def index_resource(resource)
    path = resource[1..-1].split("/")
    sections = []
    path.each do |segment|
      if segment.include?(":")
        sections << {"part" => segment, "dynamic?" => true}
      else
        sections << {"part" => segment, "dynamic?" => false}
      end
    end
    return sections
  end


end


