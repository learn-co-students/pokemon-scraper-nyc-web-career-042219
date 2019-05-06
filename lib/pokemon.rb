require 'pry'
class Pokemon

attr_accessor :name, :type, :id, :db

def initialize(name:, type:, db:, id:)
@name = name
@type = type
@id = id
@db = db

end


def self.save(name, type, db)
  sql = <<-SQL
  INSERT INTO pokemon (name, type)
  VALUES (?, ?)
  SQL

  db.execute(sql, name, type)
  @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
end


def self.find(id, db)
  sql = "SELECT id, name, type FROM pokemon WHERE id = ?"
  results = db.execute(sql, id)[0]
  poke = Pokemon.new(id: results[0], name: results[1], type: results[2], db: db)
  poke
end





end
