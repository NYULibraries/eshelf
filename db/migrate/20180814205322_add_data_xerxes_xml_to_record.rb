class AddDataXerxesXmlToRecord < ActiveRecord::Migration
  def up
    add_column :records, :data_xerxes_xml, :text, limit: 4294967295
  end
  def down
    remove_column :records, :data_xerxes_xml
  end
end
