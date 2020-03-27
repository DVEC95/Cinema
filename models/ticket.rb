require_relative('../db/sql_runner.rb')
require_relative('./customer.rb')
require_relative('./film.rb')

class Ticket

  attr_accessor :customer_id, :film_id
  attr_reader :id

  def initialize(ticket)
    @customer_id = ticket['customer_id']
    @film_id = ticket['film_id']
    @id = ticket['id'].to_i if ticket['id']
  end

  def save()
    sql = 'INSERT INTO tickets (customer_id, film_id) VALUES ($1, $2) RETURNING *'
    values = [@customer_id, @film_id]
    @id = SQLRunner.run(sql, values)[0]['id'].to_i
  end

  def update()
    sql = 'UPDATE tickets SET (customer_id, film_id) = ($1, $2) WHERE id = $3'
    values = [@customer_id, @film_id, @id]
    SQLRunner.run(sql, values)
  end

  def delete()
    sql = 'DELETE FROM tickets WHERE id = $1'
    values = [@id]
    SQLRunner.run(sql, values)
  end

  def self.delete_all
    sql = 'DELETE FROM tickets'
    SQLRunner.run(sql)
  end

end
