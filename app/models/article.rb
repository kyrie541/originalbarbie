class Article < ApplicationRecord
	has_many :comments, dependent: :destroy
	validates :title, presence: true,
			  length: {minimum: 3}
	validates :text, presence: true,
			  length: {minimum: 2}

	# for photo - special characters
	has_attached_file :photo, styles: {large: "450x450>", thumb: "50x50#"}
	validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/

	# For Music 
	has_attached_file :music
	validates_attachment :music,
	:content_type => {:content_type => ["audio/mpeg", "audio/mp3"]},
	:file_type => {:matches => [/mp3\Z/]}

	# For movie
	has_attached_file :movie, :styles =>
	{
		:medium => {:geometry => "640x480", :format => 'mp4'},
		:thumb => {:geometry => "100x50", :format => 'jpg', :time => 10}
	}, :processor => [:transcoder]
	validates_attachment_content_type :movie, content_type: /\Avideo\/.*\z/


	def self.search(params)
		articles = Article.where("text LIKE ? or title LIKE ?", "%#{params[:search]}%", 
			"%#{params[:search]}%") if params[:search].present?
		articles #returns the articles containing the searching words
	end
end
