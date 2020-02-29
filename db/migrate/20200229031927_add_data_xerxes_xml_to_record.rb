class AddDataXerxesXmlToRecord < ActiveRecord::Migration[5.2]
  def change
    add_column :records, :data_xerxes_xml, :text
  end
end
