class Pokemon
  attr_accessor :id, :name, :type, :db, :hp

  def initialize(id:nil, name:, type:, hp:nil, db:)
    @id = id
    @name = name
    @type = type
    @hp = hp
    @db = db
  end

  def self.save(name, type, db)
    sql = <<-SQL
      INSERT INTO pokemon (name, type)
      VALUES (?, ?)
    SQL
    db.execute(sql, name, type)
  end

  def self.find(id, db)
    sql = <<-SQL
      SELECT * FROM pokemon
      WHERE pokemon.id = ?
    SQL
    pokey = db.execute(sql, id)
    Pokemon.new(name: pokey[0][1], type: pokey[0][2], id: pokey[0][0], db:db, hp: pokey[0][3])
  end

  def alter_hp(hp, db)
    sql = <<-SQL
      UPDATE pokemon
      SET hp = ?
      WHERE id = ?
    SQL
    db.execute(sql, hp, self.id)
    #binding.pry
  end

end
