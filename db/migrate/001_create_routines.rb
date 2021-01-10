class CreateRoutines < ActiveRecord::Migration
    def change
      create_table :routines do |t|
        t.string :exercise
        t.integer :user_id # because chores belongs to a specific user
        t.timestamps null: false
      end
    end
  end