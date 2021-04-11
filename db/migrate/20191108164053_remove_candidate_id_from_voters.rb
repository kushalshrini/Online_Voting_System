class RemoveCandidateIdFromVoters < ActiveRecord::Migration[6.0]
  def change

    remove_column :voters, :candidate_id, :integer
  end
end
