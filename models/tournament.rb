require_relative('../db/sql_runner.rb')

class Tournament

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @format = options['format']
  end

  

end