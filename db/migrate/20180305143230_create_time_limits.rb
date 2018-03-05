class CreateTimeLimits < ActiveRecord::Migration[5.1]
  def change
    create_table :time_limits do |t|
      t.string :studentTime
      t.string :limits
      t.timestamps
    end
  end
end
