class CreateItems < ActiveRecord::Migration
  def change
    enable_extension 'citext'

    create_table :items do |t|
      t.citext :name
      t.string :description
      t.string :unit_price

      t.timestamps null: false
    end
  end
end
