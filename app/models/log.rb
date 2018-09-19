class Log < ApplicationRecord
  belongs_to :task
  belongs_to :user
  belongs_to :state
end
