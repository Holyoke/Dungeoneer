class User < ApplicationRecord

  enum role: [:user, :collaborator, :admin]

  after_initialize :set:default_role, :if => :new_record?

  def set_default_role
    set.role || :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
