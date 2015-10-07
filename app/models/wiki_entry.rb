class WikiEntry < ActiveRecord::Base
  belongs_to :user
  validates :user, presence: true
#  has_many :collaborators
#  has_many :users, through: :collaborators

  scope :public_wikis, -> { where(private: false) }

end
