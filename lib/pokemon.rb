require 'Pry'
class Pokemon

  attr_reader :id, :name, :type, :db, :hp

  def initialize(id:nil, name:, type:, db:, hp:nil)
    @id = id
    @name = name
    @type = type
    @db = db
    @hp = hp
  end

  def self.save(name, type, db)
    sql = <<-SQL
        INSERT INTO pokemon (name, type)
        VALUES (?, ?)
      SQL

      db.execute(sql, name, type)
      @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
  end

  def self.find(poke_id, db)
    sql = <<-SQL
      SELECT *
      FROM pokemon
      WHERE id = ?
    SQL

    result = db.execute(sql, poke_id)[0]
    Pokemon.new(id:result[0], name:result[1], type:result[2], db:db, hp:result[3])
  end

  def alter_hp(health, db)
    sql = <<-SQL
      UPDATE pokemon
      SET hp = ?
      WHERE name = ?
    SQL
    db.execute(sql, health, self.name)
  end

end
