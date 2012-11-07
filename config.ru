require 'bundler'
require 'faker'

Bundler.require

# Rack::CoreData requires a Sequel connection to a database
DB = Sequel.connect(ENV['DATABASE_URL'] || "postgres://localhost:5432/core_data_clients")

run Rack::CoreData('./RGCRM.xcdatamodel')

def wipe_db
	Rack::CoreData::Models::Client.each do |client|
		puts "deleting: #{client}"
		client.delete
	end

	Rack::CoreData::Models::Contact.each do |contact|
		puts "deleting: #{contact}"
		contact.delete
	end
end


wipe_db


if Rack::CoreData::Models::Client.count < 100

	clientId = 1
	contactId = 1

	(0..50).each do
		name    = Faker::Company.name
		country = Faker::Address.country
		newClient = Rack::CoreData::Models::Client.create(name: name,  country: country, clientId: clientId)
		clientId = clientId + 1
		
		(0..10).each do
			firstName = Faker::Name.first_name
			lastName = Faker::Name.last_name
			phone = Faker::PhoneNumber.phone_number
			contact = Rack::CoreData::Models::Contact.create(firstName: firstName, lastName: lastName, phone: phone, contactId: contactId, client: newClient) 
			contactId = contactId + 1
		end
	end
end
