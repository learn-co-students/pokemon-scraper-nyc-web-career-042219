require 'pry'

class Pokemon

  attr_accessor :id, :name, :type, :db

  def initialize(id:, name:, type:, db:)
   @id = id
   @name = name
   @type = type
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
    sql = <<-SQL
    SELECT * FROM pokemon
    WHERE pokemon.id = ?
    LIMIT 1
    SQL

    poke = db.execute(sql, id)
    pokemon = Pokemon.new(id: poke[0][0], name: poke[0][1], type: poke[0][2], db: db)
    end
  end
