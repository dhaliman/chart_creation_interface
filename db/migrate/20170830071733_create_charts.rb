class CreateCharts < ActiveRecord::Migration[5.1]
  def change
    create_table :charts do |t|
      t.string :type_of
      t.string :title
      t.string :url

      t.timestamps
    end
  end
end
