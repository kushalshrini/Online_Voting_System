class VoterController < ApplicationController
  before_action :check_if_not_voted?
  include ApplicationHelper

  def voter_registration
    @voter = Voter.new
  end

  def submit_voter_registration
    @usn = Voter.where(usn: params["voter"]["usn"].upcase)
    if @usn.count > 0
      redirect_to voter_registration_path, status: 302
      flash[:notice] = "Already Voted!"
    else
      @voter = Voter.new(voter_params)
      if @voter.save
        redirect_to root_path
        session[:user_id] = @voter.id
      else
        render "voter_registration"
      end
    end
  end

  def vote_now
    @candidates = Candidate.all
  end

  def register_vote
    @candidate = Candidate.find_by_id(params["id"].to_i)
    @candidate.vote_count += 1
    if @candidate.save
      @voter = Voter.where(id: current_user)
      @voter.first.toggle!(:voted)
      redirect_to root_path(voted: true)
    else
      render 'vote_now'
    end
  end

  def voter_pdf
    @voter = Voter.where(id: current_user.id).first
    respond_to do |format|
        format.pdf do
          pdf = Prawn::Document.new
          pdf.font_size 25
          pdf.text_box "Thanks #{@voter.name} for Voting!", at: [100,500]
          send_data pdf.render, filename: "#{ @voter.name }-vote-certificate.pdf"
        end
      end
  end

end

private

def voter_params
  params.require(:voter).permit(:name, :usn, :email)
end

def check_if_not_voted?
  session["voted"] == false
end
