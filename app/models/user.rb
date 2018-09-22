class User < ApplicationRecord
	has_secure_password
	
	has_many :logs
	has_many :users_lists
	has_many :lists, dependent: :destroy, through: :users_lists
    has_many :tasks, through: :logs #cuando un usuario da de baja una actividad, o interact'ua con esa tarea

end
