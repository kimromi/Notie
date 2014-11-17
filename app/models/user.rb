class User < ActiveRecord::Base
  has_many :note, dependent: :destroy
end
