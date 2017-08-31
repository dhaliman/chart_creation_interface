class CreateXAxis < ActiveRecord::Migration[5.1]
  def change
    create_table :x_axis do |t|
      t.string :range
      t.references :chart, foreign_key: true

      t.timestamps
    end
  end
end
