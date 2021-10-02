class List < ApplicationRecord
	validates :title, presence: true
	validates :filename, presence: true
end
