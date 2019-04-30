class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :summary
      t.string :string
      t.integer :organizer_id

      t.timestamps
    end
  end
end
