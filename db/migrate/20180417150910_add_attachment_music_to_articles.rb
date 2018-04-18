class AddAttachmentMusicToArticles < ActiveRecord::Migration[5.1]
  def self.up
    change_table :articles do |t|
      t.attachment :music
    end
  end

  def self.down
    remove_attachment :articles, :music
  end
end
