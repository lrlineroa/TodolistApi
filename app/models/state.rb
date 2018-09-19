class State < ApplicationRecord
    has_many :logs

    has_many :tasks, through: :logs

end
