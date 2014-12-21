class User < ActiveRecord::Base
  has_many :events
  
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  validates :email, uniqueness: true

  def absences
    duration = 0
    if self.events.where(status: 2)
      self.events.where(status: 2).each {|e| duration += (e.date_to - e.date_from).to_i }
      duration
    else
      0
    end
  end

  def presence
    duration = 0
    self.events.where(status: 1).each {|e| duration += (e.date_to - e.date_from).to_i }
    duration
  end
end
