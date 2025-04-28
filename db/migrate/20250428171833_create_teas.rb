class CreateTeas < ActiveRecord::Migration[7.1]
  def change
    create_table :teas do |t|
      t.string :title
      t.text :description
      t.integer :brew_time
      t.string :image_url

      t.timestamps
    end
  end
end
