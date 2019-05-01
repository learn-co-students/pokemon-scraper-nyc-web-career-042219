class Pokemon
  attr_accessor :id, :name, :type, :db, :hp

  def initialize(id:, name:, type:, db:, hp: nil)
    @id = id
    @name = name
    @type = type
    @hp = hp
  end

  def self.save(name, type, db)
    #binding.pry
    sql = <<-SQL
      INSERT INTO pokemon(name, type)
      VALUES (?, ?)
    SQL

    db.execute(sql, name, type)
    @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
  end

  def self.find(index, db)
    sql = <<-SQL
      SELECT *
      FROM pokemon
      WHERE pokemon.id = ?
    SQL

    db.execute(sql, index).map do |row|
      Pokemon.new(id: row[0], name: row[1], type: row[2], db: db, hp: row[3])
    end.first
  end

  def alter_hp(new_hp, db)
    sql = "UPDATE pokemon SET hp = ? WHERE pokemon.id = ?"

    db.execute(sql, new_hp, self.id)
  end
end
