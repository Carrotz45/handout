
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

    for i in 1..input.length-1 do #ändra till each istället
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

    possible_params.each do |param| #använd .map D:<, GÖR OM ALLT
      temp_param = nil
      if param.include?("?")
        _resource, temp_param = param.split("?")
        temp_param = temp_param.split("&").map{|x| x.split("=")}
        temp_param.each do |key_and_value|
          @params_arr << key_and_value
        end
      elsif param.include?("/") == false
        temp_param = param
        temp_param = temp_param.split("&").map{|x| x.split("=")}
        temp_param.each do |key_and_value|
          @params_arr << key_and_value
        end
      end
    end

    @result = @method_resource_version
    @result << @header_arr.to_h
    @result << @params_arr.to_h
    return @result

  end
end


