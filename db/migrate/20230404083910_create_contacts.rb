class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.string :title, null: false
      t.text :contact, null: false

      t.timestamps
    end
  end
end
