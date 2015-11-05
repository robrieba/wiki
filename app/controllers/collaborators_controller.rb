class CollaboratorsController < ApplicationController

  before_action :set_wiki_entry

  def index
    @users = User.where("id <> ?", current_user.id)
  end

  def create
    @collaborator = @wiki_entry.collaborators.new(user_id: params[:user_id])

    if @collaborator.save
      # flash
    else
      #flash bad
    end

    redirect_to wiki_entry_collaborators_path(@wiki_entry)
  end

  def destroy
    @collaborator = Collaborator.find(params[:id])

    if @collaborator.destroy
      #flash
    else
      #flash bad
    end

    redirect_to wiki_entry_collaborators_path(@wiki_entry)
  end

  private

  def set_wiki_entry
    @wiki_entry = WikiEntry.find(params[:wiki_entry_id])
  end
end
