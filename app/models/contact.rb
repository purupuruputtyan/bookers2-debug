class Contact < ApplicationRecord
  validates :title, presence: true
  validates :contact, presence: true
end
