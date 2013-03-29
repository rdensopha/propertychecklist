class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :providerName
      t.string :identifier
      t.string :verifiedEmail
      t.string :prefferedUserName
      t.string :displayName
      t.string :status
      t.string :mobileNumber
      t.timestamps
    end
  end
end
