class User < ActiveRecord::Base

  self.table_name = "users"

  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :registerable

end
