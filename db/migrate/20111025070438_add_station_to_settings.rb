class AddStationToSettings < ActiveRecord::Migration
  def self.up
    add_column :settings, :pref, :string
    rename_column :settings, :area, :station
  end


  def self.down
    emove_column :settings, :pref
    rename_column :settings, :station, :area
  end
end

