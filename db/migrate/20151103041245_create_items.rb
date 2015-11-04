class CreateItems < ActiveRecord::Migration
  def change
    enable_extension 'citext'

    create_table :items do |t|
      t.citext :name
      t.string :description
      t.decimal :unit_price
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
