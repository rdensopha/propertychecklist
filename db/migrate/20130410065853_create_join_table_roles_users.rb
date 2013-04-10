class CreateJoinTableRolesUsers < ActiveRecord::Migration
  def up
    drop_table :users_roles

    create_table(:roles_users, :id => false) do |t|
      t.references :user
      t.references :role
    end
  end

  def down
    drop_table :roles_users

    create_table(:users_roles, :id => false) do |t|
      t.references :user
      t.references :role
    end
  end
end
