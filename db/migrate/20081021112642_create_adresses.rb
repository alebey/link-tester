class CreateAdresses < ActiveRecord::Migration
  def self.up
    create_table :adresses do |t|
      t.string :uri, :path, :title
      t.integer :domain_id
      t.text :description
      t.datetime :crawled_at

      t.timestamps
    end
  end

  def self.down
    drop_table :adresses
  end
end
