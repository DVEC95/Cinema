require_relative('../db/sql_runner.rb')

class Customer

  attr_accessor :name, :funds
  attr_reader :id

  def initialize(customer)
    @name = customer['name']
    @funds = customer['funds']
    @id = customer['id'].to_i if customer['id']
  end

end
