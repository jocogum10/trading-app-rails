class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  
  has_many :transactions

  enum role: [:trader, :admin]
  enum is_approved: [:not_verified, :verified]

  after_initialize :set_default_role, :if => :new_record?

  after_initialize :set_default_is_approved, :if => :new_record?

  validates :role, inclusion: {in: ['trader', 'admin']}

  ROLE_OPTIONS = [
      ['Trader', 'trader'],
      ['Administrator', 'admin']
  ]

  VERIFY_OPTIONS = [
    ['Verified', 'verified'],
    ['Not Verified', 'not_verified']
]

  def set_default_role
    self.role ||= :user
  end

  def set_default_is_approved
    self.role ||= :not_verified
  end
end
