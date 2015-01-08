module TeamsHelper

  def teamSize(team_id)
    @members = User.where(:team_id => team_id).count
    return @members
  end

end
