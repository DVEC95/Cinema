require_relative('../db/sql_runner.rb')

class Customer

  attr_accessor :name, :funds
  attr_reader :id

  def initialize(customer)
    @name = customer['name']
    @funds = customer['funds']
    @id = customer['id'].to_i if customer['id']
  end

  def save()
    sql = 'INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING *'
    values = [@name, @funds]
    @id = SQLRunner.run(sql, values)[0]['id'].to_i
  end

  def update()
    sql = 'UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3'
    values = [@name, @funds, @id]
    SQLRunner.run(sql, values)
  end

  def delete()
    sql = 'DELETE FROM customers WHERE id = $1'
    values = [@id]
    SQLRunner.run(sql, values)
  end

  def films()
    sql = 'SELECT films.* FROM films INNER JOIN tickets ON films.id = tickets.film_id WHERE customer_id = $1'
    values = [@id]
    film_data = SQLRunner.run(sql, values)
    return film_data.map {|film| Film.new(film)}
  end

  def tickets()
    sql = 'SELECT films.* FROM films INNER JOIN tickets ON films.id = tickets.film_id WHERE customer_id = $1'
    values = [@id]
    film_data = SQLRunner.run(sql, values)
    return film_data.count
  end

  def buy_tickets
    tickets = self.films()
    total = tickets.map{|ticket| ticket.price.to_i}
    total_amount = total.sum
    @funds -= total_amount
    self.update()
  end

  def self.delete_all()
    sql = 'DELETE FROM customers'
    SQLRunner.run(sql)
  end

end
