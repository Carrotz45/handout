
class Request

  attr_reader :method, :resource, :version, :header, :params

  def initialize(request_string)
    @request_string = request_string

    @method, @resource, @version, @header, @params = request_arr(@request_string) #can i make this better?
     
  end

  private
  def request_arr(string) #make this function more moduable and work if there is more than two headers. Also work let headers have more values (maybe make a two dim array for headers(?) so it kinda works like a table)
    input = string.split("\n")


    @method_resource_version = input[0].split() 

    possible_params = []

    possible_params << @method_resource_version[1]

    @params_arr = []

    @header_arr = []

    @result = []
    

    for i in 1..input.length-1 do #input.each do |content|

      content = input[i]
      
      if content.include?(":") #else identifiera som param om den har ?, ev gör en identifiera param function

        content = content.split(": ")

        @header_arr << content


      else
        if content.empty? == false
          possible_params << content
        end


      end

    end

    p possible_params
    possible_params.each do |param| #använd .map D:<, GÖR OM ALLT
      if param.include?("?")
        _resource, param = param.split("?")
        params = param.split("&")
      elsif param.include?("/") == false
        param = param.split("&")
      end
      
      if param.class == Array
        param.each do |param|
          param = param.split("=")
          @params_arr << param
        end
      else
        param = param.split("=")
        @params_arr << param
      end

    end


    @result = @method_resource_version
    @result << @header_arr.to_h
    @result << @params_arr.to_h

    # private
    # def param_strip(param_string)

    return @result
  end

end

request_string1 = File.read("get-index.request.txt")
request_string2 = File.read("get-examples.request.txt")
request_string3 = File.read("get-fruits-with-filter.request.txt")
request_string4 = File.read("post-login.request.txt")

request = Request.new(request_string4)

p request.method
p request.resource
p request.version
p request.header
p request.params

