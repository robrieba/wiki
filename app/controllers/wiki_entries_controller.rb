class WikiEntriesController < ApplicationController
  before_action :require_sign_in

  def index
    @wiki_entries = WikiEntry.where(user_id: current_user.id)
  end

  def show
    @wiki_entry = WikiEntry.find(params[:id])
  end

  def new
    @wiki_entry = WikiEntry.new
  end

  def create
    wiki_entry = WikiEntry.new(wiki_entry_params)
    wiki_entry.user_id = current_user.id

    if wiki_entry.save
      flash[:notice] = "Wiki entry was saved."
      redirect_to wiki_entries_path
    else
      flash[:error] = "There was an error saving the wiki entry. Please try again."
      render :new
    end

  end

  def edit
    @wiki_entry = WikiEntry.find(params[:id])
  end

  def update
    wiki_entry = WikiEntry.find(params[:id])

    if wiki_entry.update_attributes(wiki_entry_params)
      flash[:notice] = "Wiki was updated."
      redirect_to wiki_entries_path
    else
      flash[:error] = "There was an error saving the wiki. Please try again."
      render :edit
    end
  end

  def destroy
    wiki_entry = WikiEntry.find(params[:id])

    if wiki_entry.destroy
      flash[:notice] = "\"#{wiki_entry.title}\" was deleted successfully."
      redirect_to action: :index
    else
      flash[:error] = "There was an error deleting the wiki."
      render :show
    end
  end

  private

  def wiki_entry_params
    params.require(:wiki_entry).permit(:title, :body)
  end

end
