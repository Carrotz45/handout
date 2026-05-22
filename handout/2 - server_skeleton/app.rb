require_relative 'tcp_server'

router = Route.new

router.get("/users/:id") do |id|
    "Hello, user #{id}"
end


router.get("test") do
    
end


server = HTTPServer.new(router, 4567)
server.start
