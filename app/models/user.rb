class User < ActiveRecord::Base
  has_many :articles, inverse_of: :user
end
