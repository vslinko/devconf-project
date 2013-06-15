module.exports = (container, callback) ->
  connection = container.get "connection"
  mongoose = container.get "mongoose"
  app = container.get "app"
  io = container.get "io"

  OptionSchema = new mongoose.Schema
    title: type: String
    value: type: Number, default: 0

  ThemeSchema = new mongoose.Schema
    title: type: String
    values: [OptionSchema]
    createdAt: type: Date, default: Date.now

  Theme = connection.model "themes", ThemeSchema

  app.get "/themes", (req, res) ->
    Theme.find().exec (err, docs) ->
      return res.send 500 if err
      res.send docs

  app.post "/themes", (req, res) ->
    doc = new Theme req.body

    doc.save (err) ->
      return res.send 400, err if err?.name is "ValidationError"
      return res.send 500 if err
      res.send 201, doc
      io.sockets.emit "theme"

  app.put "/themes/:id", (req, res) ->
    data = req.body
    delete data._id if data._id

    Theme.findOne _id: req.params.id, (err, doc) ->
      return res.send 500 if err
      return res.send 404 unless doc

      for key, value of data
        doc[key] = value

      doc.save (err) ->
        return res.send 500 if err

        res.set "Location", req.url
        res.send 200, doc
        io.sockets.emit "theme"

  app.delete "/themes/:id", (req, res) ->
    Theme.remove _id: req.params.id, (err) ->
      return res.send 500 if err
      res.send 200
      io.sockets.emit "theme"

  callback()
