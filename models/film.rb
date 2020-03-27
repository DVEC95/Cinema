require_relative('../db/sql_runner.rb')

class Film

  attr_accessor :title, :price
  attr_reader :id

  def initialize(film)
    @title = film['title']
    @price = film['price']
    @id = film['id'].to_i if film['id']
  end

  def save()
    sql = 'INSERT INTO films (title, price) VALUES ($1, $2) RETURNING *'
    values = [@title, @price]
    @id = SQLRunner.run(sql, values)[0]['id'].to_i
  end

end
