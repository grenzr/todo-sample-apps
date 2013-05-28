
/**
 * Module dependencies.
 */

var express = require('express')
  , mongoose = require('mongoose')
  , http = require('http');

var app = express();
var db = mongoose.createConnection('localhost', 'test');

var schema = mongoose.Schema({ title: String, completed: Boolean });
var Todo = db.model('Todo', schema);

app.configure(function(){
  app.set('port', 3000);
  app.use(express.favicon());
  app.use(express.logger('dev'));
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(app.router);
  app.use(express.static(__dirname + '/public'));
});

app.configure('development', function(){
  app.use(express.errorHandler());
});

app.get('/todos', function(req, res)
{
  Todo.find().exec(function (err, todos) {
    res.send(todos);
  });
});

app.post('/todos', function(req, res)
{
  var todo = new Todo({ title: req.body.title, completed: false });
  
  todo.save(function (err) {
    res.statusCode = 201;
    res.send(todo);
  });
});

app.put('/todos/:id', function(req, res)
{
  var todo = Todo.findOne({ '_id': req.params.id });

  todo.update({ 
    title: req.body.title, 
    completed: req.body.completed }, 
    function (err, todo) {
      res.statusCode = 200;
      res.send(todo);
    }
  );
});

app.delete('/todos/:id', function(req, res)
{
  var todo = Todo.remove({ '_id': req.params.id }, function(err) {
    res.statusCode = 204;
    res.send('OK');
  });
});



http.createServer(app).listen(app.get('port'), function(){
  console.log("Express server listening on port " + app.get('port'));
});
