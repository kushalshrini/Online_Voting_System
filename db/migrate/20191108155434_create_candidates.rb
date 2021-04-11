class CreateCandidates < ActiveRecord::Migration[6.0]
  def change
    create_table :candidates do |t|
      t.string :name
      t.string :party
      t.string :constituency_code
      t.string :place
      t.integer :vote_count, default: 0

      t.timestamps
    end
  end
end
