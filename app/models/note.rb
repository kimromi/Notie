class Note < ActiveRecord::Base
  belongs_to :user
  acts_as_taggable
  validates :user_id, :auth, :title, presence: true
  validates_uniqueness_of :uid
  validates_presence_of :uid
  after_initialize :set_uid

  private
  def set_uid
    self.uid = self.uid.blank? ? SecureRandom.urlsafe_base64(6) : self.uid
  end

end
