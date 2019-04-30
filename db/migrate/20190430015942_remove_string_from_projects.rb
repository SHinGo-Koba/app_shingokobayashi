class RemoveStringFromProjects < ActiveRecord::Migration[5.2]
  def up
    remove_column :projects, :string
  end
  
  def down
    add_column :projects, :string, :string
  end
end
