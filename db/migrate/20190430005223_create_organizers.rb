class CreateOrganizers < ActiveRecord::Migration[5.2]
  def change
    create_table :organizers do |t|
      t.string :organizer_name
      t.integer :user_id

      t.timestamps
    end
  end
end
