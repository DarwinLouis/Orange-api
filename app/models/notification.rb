class Notification < ActiveRecord::Base
	validates_presence_of :description

	def send_message(message)
		self.description = message
		#TODO actual sending notification
	end

end
