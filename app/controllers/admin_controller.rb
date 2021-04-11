class AdminController < ApplicationController
  http_basic_authenticate_with name: "manoj", password: "manoj"

  def index
    @candidates = Candidate.all
    @voters = Voter.all
    @winners = Candidate.order(:vote_count).reverse
  end

  def add_candidate
    @candidate = Candidate.new
  end

  def create_candidate
    @candidate = Candidate.new(candidate_params)
    if @candidate.save
      redirect_to admin_path
    else
      render "add_candidate"
    end
  end

  def reset_election
    Voter.delete_all
    @candidates = Candidate.all
    @candidates.each do |i|
      i.vote_count = 0
      i.save
    end
    redirect_to admin_path
  end

  private

  def candidate_params
    params.require(:candidate).permit(:name, :party, :constituency_code, :place, :image_path)
  end

end
