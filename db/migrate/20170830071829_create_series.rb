class CreateSeries < ActiveRecord::Migration[5.1]
  def change
    create_table :series do |t|
      t.string :range
      t.references :chart, foreign_key: true

      t.timestamps
    end
  end
end
