socket = require "socket.io"


module.exports = (container, callback) ->
  server = container.get "server"

  io = socket.listen server
  io.set "log level", 1

  container.set "io", io

  callback()
