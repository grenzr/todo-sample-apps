package models

import com.novus.salat._
import com.novus.salat.global._
import com.novus.salat.annotations._
import com.novus.salat.dao._
import com.mongodb.casbah.Imports._
import com.mongodb.casbah.MongoConnection
import com.novus.salat.json.{StringDateStrategy, JSONConfig}

case class Todo(@Key("_id") id: Int, 
  title: String, 
  completed: Boolean)

object TodoDAO extends SalatDAO[Todo, Int](collection = MongoConnection()("test_db")("todos"))