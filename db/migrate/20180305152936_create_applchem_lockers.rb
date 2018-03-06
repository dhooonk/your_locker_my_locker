class CreateApplchemLockers < ActiveRecord::Migration[5.1]
  def change
    create_table :applchem_lockers do |t|
      t.belongs_to :user
      t.string :lockerNumber
      t.string :major
      t.timestamps
    end
  end
end
