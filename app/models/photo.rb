require 'dotenv'
require 'cloudinary'
load '.env'

class Photo < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :user
  has_many :likes
  has_many :upvoters, through: :likes, source: :upvoter

  validates :photo_url, presence: true

	def self.upload(photo_url)
		auth = {
		  cloud_name: "geekincognito",
		  api_key:    ENV["CLD_KEY"],
		  api_secret: ENV["CLD_SECRET"]
		}
		Cloudinary::Uploader.upload(photo_url, auth)
	end
	

end
