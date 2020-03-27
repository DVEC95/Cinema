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

  def self.delete_all()
    sql = 'DELETE FROM customers'
    SQLRunner.run(sql)
  end

end
