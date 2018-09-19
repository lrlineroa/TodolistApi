class FrontController < ApplicationController
	def index
		render plain: 'Este es el api de todo list por favor no intentar violar la seguridad, por que estamos protegidos por JWT Si quieres saber como utilizar este api te recomiendo la guia https://docs.google.com/document/d/1PZesKGdQlE5KtyVVDBteHJhoWdHxq8v-nCrTbDGGXBI/edit?usp=sharing'
	end
end
