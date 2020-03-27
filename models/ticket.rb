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

end
