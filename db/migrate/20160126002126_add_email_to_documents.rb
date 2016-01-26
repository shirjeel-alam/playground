class AddEmailToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :email, :string
  end
end
