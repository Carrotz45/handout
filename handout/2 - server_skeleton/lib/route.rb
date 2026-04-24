class Route 
  attr_reader :content_type, :matched_route
  def initialize(request)

    @method, @resource = request.method, request.resource

    @routes = {
      [{"part" => nil, "dynamic?" => false}] => "index.html",
      [{"part" => "test", "dynamic?" => false}] => "test_static.html",
      [{"part" => "pictures", "dynamic?" => false}, {"part" => ":id", "dynamic?" => true}] => "pictures.html"
    } #method get

    # @image_file_types = ["jpg", "png"]
    # @audio_file_types = ["mp3", "ogg", "wav"]

    # @file_types = {
    #   "image" => @image_file_types, 
    #   "audio" => @audio_file_types
    # }

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

  def check_matching_route(incoming_resource)

    indexed_incoming_resource = index_resource(incoming_resource)

    incoming_resource_amount_of_parts = indexed_incoming_resource.length

    matches = 0

    @routes.keys.each do |route|

      number_of_parts = route.length

      if number_of_parts == incoming_resource_amount_of_parts

        for i in 0..number_of_parts-1 do

          route_key = route[i]
          incoming_key = indexed_incoming_resource[i]

          #jämför
        end
          

      else
        "404"
      end



      path_part = path["part"]
      path_dynamic = path["dynamic?"] #jämför part till part om det är statiskt, om matchande räkna som matchning, om dynamiskt jämför inte part, men räkna som en matchning. 


      indexed_incoming_resource.each do |segment|

        if path_part == segment["part"] && path_dynamic == segment["dynamic?"] || path_dynamic = segment["dynamic?"]
          matches +=1
        end


      end


    end


  end

  def get(new_resource, &block)

    indexed_new_resource = index_resource(new_resource)

    p block

    p indexed_new_resource

    #make new route med ny path

    #kolla här om det har ett semicolon, om det har det så är det en icke statisk segment
    #spara sedan ordningen av dom

    #block är för saker som det den ska printa eller html filen, vad ska man göra om det inte finns en html fil?

    #2026/04/17


  end

  def post(path)
  end

  def make_new_route(key, value)
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


