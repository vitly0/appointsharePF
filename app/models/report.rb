class Report < ApplicationRecord
  belongs_to :end_user
  belongs_to :schedule
end
