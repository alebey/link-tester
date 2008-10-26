class Adress < ActiveRecord::Base
  belongs_to :domain
  has_many :test_results
end
