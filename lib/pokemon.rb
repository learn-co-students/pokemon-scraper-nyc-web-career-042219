class Pokemon

  def self.save(name, type, db)
    sql = <<-SQL
    INSERT INTO 
      pokemon(name, type)
    VALUES
      (?, ?)
    SQL
    db.execute(sql, name, type)
    @id = db.execute("SELECT last_insert_rowid() FROM pokemon")
  end

  def self.find(id, db)
    sql = <<-SQL
    SELECT
      *
    FROM
      pokemon
    WHERE
      id = ?
    SQL
    data = db.execute(sql, id).flatten
    Pokemon.new(id: data[0], name: data[1], type: data[2], hp: data[3], db: db)
  end

  attr_accessor :id, :name, :type, :db, :hp

  def initialize(poke_hash)
    @id = poke_hash[:id]
    @name = poke_hash[:name]
    @type = poke_hash[:type]
    @db = poke_hash[:db]
    @hp = poke_hash[:hp]
  end

  def alter_hp(hp, db)
    # pokemon = find_by_id.flatten
    sql = <<-SQL
    UPDATE
      pokemon
    SET
      hp = ?
    WHERE
      id = ?
    SQL
    db.execute(sql, hp, id)
    # get_hp = <<-SQL
    # SELECT
    #   *
    # FROM 
    #   pokemon
    # WHERE
    #   hp = ?
    # SQL
    # @hp = db.execute(get_hp, hp).flatten.last
    # binding.pry
  end

  private

  def find_by_id
    sql = <<-SQL
    SELECT
      *
    FROM
      pokemon
    WHERE
      id = ?
    SQL
    db.execute(sql, id)
  end

end