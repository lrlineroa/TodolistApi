class FrontController < ApplicationController
	def index
		render plain: 'Este es el api de todo list por favor no intentar violar la seguridad, por que estamos protegidos por JWT'
	end
end
