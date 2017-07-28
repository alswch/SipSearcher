class CreateAdmins < ActiveRecord::Migration[5.1]
  def change
    create_table :admins do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :username
      t.string :password

      t.timestamps
    end
  end
end

# < ======= firstname, lastname, email, username, password ======= >
