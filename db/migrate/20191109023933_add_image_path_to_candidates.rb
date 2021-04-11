class AddImagePathToCandidates < ActiveRecord::Migration[6.0]
  def change
    add_column :candidates, :image_path, :string, default: nil
  end
end
