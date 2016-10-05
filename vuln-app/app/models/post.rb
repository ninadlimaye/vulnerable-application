class Post < ActiveRecord::Base
  validates :name, presence: true
  validates :body, presence: true

  VALID_VOTE_TYPES = %w[like dislike]

  def vote(type)
    unless VALID_VOTE_TYPES.include?(type)
      return { error: "'#{type}' is not a valid type of vote", votes: votes }
    end

    self.votes += (type == "like" ? 1 : -1)
    save!

    { error: "", votes: votes }
  end
end
