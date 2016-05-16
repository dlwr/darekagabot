class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :line_mid, null: false
    end
  end
end
