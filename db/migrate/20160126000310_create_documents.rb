class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.attachment :document

      t.timestamps null: false
    end
  end
end
