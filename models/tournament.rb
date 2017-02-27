require_relative('../db/sql_runner.rb')

class Tournament

  attr_accessor :name, :format
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @format = options['format']
  end

  def save
    sql = "INSERT INTO tournaments (name, format) VALUES ('#{@name}', '#{@format}') RETURNING *;"
    tournament = SqlRunner.run(sql).first
    @id = tournament['id'].to_i
  end

  def self.all
    sql = "SELECT * FROM tournaments;"
    tournaments = SqlRunner.run(sql)
    return tournaments.map { |tournament| Tournament.new(tournament) }
  end

  def self.find(id)
    sql = "SELECT * FROM tournaments WHERE id = #{id}"
    tournament = SqlRunner.run(sql).first
    return Tournament.new(tournament)
  end

  def update
    sql = "UPDATE tournaments SET (name, format) = ('#{@name}', '#{@format}') WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def delete
    sql = "DELETE FROM tournaments WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def self.delete_all
    sql = "DELETE FROM tournaments"
    SqlRunner.run(sql)
  end

end