class CreatePlaywrights < ActiveRecord::Migration
  def change
    create_table :playwrights do |t|
      t.text :text, null: false, default: ''
      t.timestamps null: false
    end
  end
end
