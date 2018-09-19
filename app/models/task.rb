class Task < ApplicationRecord
	belongs_to :list
	has_many :logs

	has_many :users, through: :logs
    has_many :states, through: :logs

end
