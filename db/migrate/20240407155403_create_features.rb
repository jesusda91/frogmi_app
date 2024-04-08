class CreateFeatures < ActiveRecord::Migration[7.1]
  def change
    create_table :features do |t|
      t.string :external_id, null: false
      t.decimal :magnitude
      t.string :place, null: false
      t.string :time
      t.string :url, null: false
      t.boolean :tsunami, default: false
      t.string :mag_type, null: false
      t.string :title, null: false
      t.decimal :longitude, null: false
      t.decimal :latitude, null: false

      t.timestamps
    end

    add_index :features, :external_id, unique: true
  end
end

