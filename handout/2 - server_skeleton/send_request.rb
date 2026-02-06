require 'socket'
require_relative 'lib/request'

socket = TCPSocket.new('localhost', 4567)
socket.print File.read('../1 - example_requests/post-login.request.txt')
puts socket.read
socket.close