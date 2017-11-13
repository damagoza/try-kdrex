class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
    has_many :projects
    has_many :tasks
    has_many :user_roles

   after_create :default_role

   def default_role
   	UserRole.create(:user_id => self.id, :role_id => 4)
   end
end
