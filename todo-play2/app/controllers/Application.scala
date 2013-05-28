package controllers

import play.api._
import play.api.mvc._

import com.novus.salat._
import com.novus.salat.global._
import com.novus.salat.dao._
import com.novus.salat.annotations._
import com.novus.salat.json.{StringDateStrategy, JSONConfig}
import com.mongodb.casbah.Imports._
// import com.mongodb.casbah.MongoConnection

case class Todo ( @Key("_id") id: ObjectId, title: String = "", complete: Boolean = false )

object Todo extends ModelCompanion[Todo, ObjectId] {
  val collection = MongoConnection()("test")("todos")
  val dao = new SalatDAO[Todo, ObjectId](collection = collection) {}
}

// object TodoDAO extends SalatDAO[Todo, Int](collection = MongoConnection()("test")("todos"))

object Application extends Controller {
  
  def index = Action {
    Ok(views.html.index("Your new application is ready."))
  }

  def todos = Action {
    val todos = Todo.find(MongoDBObject.empty).toList
    val jsa = grater[Todo].toCompactJSONArray(todos)
    Ok(jsa).as("application/json")
  }

  def createTodo = TODO

  def updateTodo(id: Long) = TODO
  def deleteTodo(id: Long) = TODO
}