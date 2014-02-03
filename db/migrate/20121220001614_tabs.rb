class Tabs < ActiveRecord::Migration
  def change
    create_table :tabs do |t|
      t.string :title, size: 256, default: '', null: false, unique: true
      t.string :instrument, size: 24, default: '', null: false
      t.text :content, default: '', null: false
      t.integer :user_id, limit: 20, null: false, default: 0
      t.timestamps
    end
  end
end
