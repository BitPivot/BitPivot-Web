class CreateInquiryTable < ActiveRecord::Migration
  def change
    create_table :inquiries do |t|
      t.string :author
      t.string :email
      t.string :phone
      t.string :content

      t.timestamps
    end
  end
end
