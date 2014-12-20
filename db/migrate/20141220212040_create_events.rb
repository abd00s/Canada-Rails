class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.date :date_from
      t.date :date_to
      t.string :location
      t.text :description
      t.integer :status

      t.timestamps
    end
  end
end
