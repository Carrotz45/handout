require_relative 'tcp_server'
require_relative 'lib/route'

router = Route.new


def call_app()

    router.get("/users/:id") do |id|
        p "Hello, user #{id}"
    end


    router.get("test") do
        p "test"
    end
    
end 

server = HTTPServer.new(router, 4567)
server.start


