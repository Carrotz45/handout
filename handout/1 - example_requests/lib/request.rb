
class Request

  attr_reader :method, :resource, :version, :header, :params

  def initialize(request_string)
    @request_string = request_string
    @method, @resource, @version, @header, @params = request_arr(@request_string) #can i make this better?
     
    p request_arr(@request_string)

  end

  private
  def request_arr(string) #make this function more moduable and work if there is more than two headers. Also work let headers have more values (maybe make a two dim array for headers(?) so it kinda works like a table)
    arr = string.split("\n")

    @me_re_ve_arr = arr[1].split()

    @header_arr = []

    arr.each do |header|
      temp
      if header.include?(":")
        @header_arr << header.delete(":"),

      end
    end

    
    @params_arr = []
    #join arr[3] + arr[4] and arr[5] + arr[6], done

    # join_headers(arr, 3, 4)
    # join_headers(arr, 4, 5)

    #add a way to seperate headers from params

    return arr
  end

  private
  def join_headers(arr, num1, num2)
    arr[num1] = [arr[num1], arr[num2]].join(" ")
    arr.delete_at(num2)
  end


end

request_string = File.read("get-index.request.txt")

request = Request.new(request_string)

p request.method
p request.header