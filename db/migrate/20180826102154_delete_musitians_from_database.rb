class DeleteMusitiansFromDatabase < ActiveRecord::Migration[5.2]
  def change
    drop_table :musicians
  end
end
