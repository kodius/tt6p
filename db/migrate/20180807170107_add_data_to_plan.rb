class AddDataToPlan < ActiveRecord::Migration[5.2]
  def change
    add_column :plans, :height, :decimal, :precision => 15, :scale => 2
    add_column :plans, :age, :integer
    add_column :plans, :gender, :string
    add_column :plans, :activity_level, :string
  end
end
