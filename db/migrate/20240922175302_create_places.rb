class CreatePlaces < ActiveRecord::Migration[7.2]
  def change
    create_table :places do |t|
      t.string :state
      t.string :city
      t.string :street
      t.string :number
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
