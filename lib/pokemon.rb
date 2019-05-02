require 'pry'
class Pokemon

	attr_accessor :name, :type, :id, :db, :hp

	def initialize(name:, type:, id: nil, db:, hp: nil)
		@name = name 
		@type = type
		@id = id
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

	def self.find(id, db)
		sql = <<-SQL
			SELECT * 
			FROM pokemon
			WHERE id = ?
		SQL
		db.execute(sql, id).map do |row|
			# binding.pry
			new_poke = Pokemon.new(name: row[1], type: row[2], id: row[0], db: db, hp: row[3])
		end.first
	end

	def alter_hp(hp, db)
		  sql = <<-SQL
    UPDATE
      pokemon
    SET
      hp = ?
    WHERE
      id = ?
    SQL
    db.execute(sql, hp, id)
		# sql = <<-SQL
		# 	UPDATE pokemon
		# 	SET hp = ?
		# 	WHERE id = ?
		# SQL
		# db.execute(sql, hp, id)
		# binding.pry
	end

end


