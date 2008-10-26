class CreateTestResults < ActiveRecord::Migration
  def self.up
    create_table :test_results do |t|
      t.integer :adress_id, :response_size
      t.float :response_time
      t.string :title, :description, :measurement, :response_code, :test_path, :cache_control, :content_type, :date, :server
      t.timestamps
    end
  end

  def self.down
    drop_table :test_results
  end
end
