class CreateEdibles < ActiveRecord::Migration
  def change
    create_table :edibles do |t|
      t.string :name
     

      t.timestamps null: false
    end
  end
end
