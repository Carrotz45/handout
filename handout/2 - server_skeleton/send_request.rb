require 'socket'
require_relative 'lib/request'

post = "../1 - example_requests/post-login.request.txt"
get = "../1 - example_requests/get-fruits-with-filter.request.txt"

socket = TCPSocket.new('localhost', 4567)
socket.print File.read(post)
puts socket.read
socket.close