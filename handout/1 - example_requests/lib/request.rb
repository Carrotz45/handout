
class Request

  attr_reader :method, :resource, :version, :header, :params

  def initialize(request_string)
    @request_string = request_string

    @method, @resource, @version, @header, @params = request_arr(@request_string) #can i make this better?
     
  end

  private
  def request_arr(string) #make this function more moduable and work if there is more than two headers. Also work let headers have more values (maybe make a two dim array for headers(?) so it kinda works like a table)
    input = string.split("\n")

    @arr = input[0].split() 

    @params_arr = []

    @header_arr = []
    
    

    for i in 1..input.length-1 do #input.each do |content|

      content = input[i]
      
      if content.include?(":") #else identifiera som param om den har ?, ev gör en identifiera param function

        content = content.split(": ")

        @header_arr << content

      else

      end

    end


    if @arr.include?("?")#lägg detta innan headers eftersom params i resource kommer först

      params = params.split("?")
      params = params.delete_at(1)
      params = params.split("&")

      params.each do |param|
        param = param.split("=")
        @params_arr << param
      end

    end

    @arr << @header_arr.to_h
    @arr << @params_arr.to_h

    # private
    # def param_strip(param_string)

    p @arr
    return @arr
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

