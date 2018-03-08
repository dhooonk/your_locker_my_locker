class CreateTimeLimits < ActiveRecord::Migration[5.1]
  def change
    create_table :time_limits do |t|
      t.string :studentTimeStart
      t.string :studentTimeEnd
      t.timestamps
    end
  end
end
