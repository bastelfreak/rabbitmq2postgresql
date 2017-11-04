class Schema < ActiveRecord::Migration
  def change
    create_table :payloads, force: true do |t|
      t.string :content
      t.string :delivery_info
      t.string :metadata
    end
  end
end
