class AddVotedToVoters < ActiveRecord::Migration[6.0]
  def change
    add_column :voters, :voted, :boolean, default: false
  end
end
