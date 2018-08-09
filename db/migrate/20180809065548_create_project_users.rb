class CreateProjectUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :project_users do |t|
      t.references :user, foreign_key: true
      t.references :project, foreign_key: true
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
