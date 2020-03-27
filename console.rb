require('pry-byebug')

require_relative('models/customer.rb')
require_relative('models/film.rb')
require_relative('models/ticket.rb')

Customer.delete_all()
Film.delete_all()
Ticket.delete_all()

#CUSTOMER DATA ------------
customer1 = Customer.new({
  'name' => 'Humphrey Bogart',
  'funds' => 30
  })
customer1.save()

customer2 = Customer.new({
  'name' => 'Lee Van Cleef',
  'funds' => 20
  })
customer2.save()

#FILM DATA ---------------
film1 = Film.new({
  'title' => 'Casablanca',
  'price' => 5
  })
film1.save()

#TICKET DATA --------------
ticket1 = Ticket.new ({
  'customer_id' => customer1.id,
  'film_id' => film1.id
  })
ticket1.save()

binding.pry
nil
