class Pokemon

  attr_accessor :id, :name, :type, :db, :hp

  def initialize(id:, name:, type:, db:, hp: 0)
    @id= id
    @name = name
    @type = type
    @db = db
    @hp = hp
  end

  def self.save (name, type, db)
    sql = <<-SQL

      INSERT INTO pokemon (name, type)
      VALUES (?, ?)
    SQL
    db.execute(sql, name, type)
    id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
  end

  def self.find (xid, db)
    sql = <<-SQL

      SELECT * FROM pokemon WHERE ID = ?

    SQL
    pokerow = db.execute(sql, xid).first
    if pokerow.length == 4
      self.new(id: pokerow[0], name: pokerow[1], type: pokerow[2], hp: pokerow[3], db: db)
    else
      self.new(id: pokerow[0], name: pokerow[1], type: pokerow[2], db: db)
    end
    # id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
  end

  def alter_hp(xhp, db)

    sql = <<-SQL
      UPDATE pokemon SET
        HP = #{xhp}
      WHERE ID = #{id}
    SQL
    # binding.pry

   db.execute ( sql)

#   pokeinst=self.class.find(id, db)

    @hp= xhp
  # binding.pry


  end

end
