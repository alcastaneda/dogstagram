class Like < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :upvoter, class_name: :User, foreign_key: :user_id
  belongs_to :photo

end
