class WikiEntriesController < ApplicationController
  include Pundit
  before_action :require_sign_in, :except => [:public, :show]
  after_action :verify_authorized, :except => [:index, :public]
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  before_action :set_wiki_entry, only: [:edit, :update, :destroy, :show]

  def public
    @wiki_entries = WikiEntry.public_wikis
  end

  def index
    @wiki_entries = current_user.wiki_entries
  end

  def show
    authorize @wiki_entry
  end

  def new
    @wiki_entry = WikiEntry.new
    authorize @wiki_entry
  end

  def create
    @wiki_entry = current_user.wiki_entries.new(wiki_entry_params)
    authorize @wiki_entry

    if @wiki_entry.save
      flash[:notice] = "Wiki entry was saved."
      redirect_to(request.referrer || wiki_entries_path)
    else
      flash[:error] = "There was an error saving the wiki entry. Please try again."
      render :new
    end
  end

  def edit
    authorize @wiki_entry
  end

  def update
    authorize @wiki_entry

    if @wiki_entry.update_attributes(wiki_entry_params)
      flash[:notice] = "Wiki was updated."
      redirect_to :back
    else
      flash[:error] = "There was an error saving the wiki. Please try again."
      render :edit
    end
  end

  def destroy
    authorize @wiki_entry

    @wiki_entry.destroy

    respond_to do |format|
      format.html { redirect_to(request.referrer || wiki_entries_path) }
      format.js
    end

  end

  private

  def wiki_entry_params
    params.require(:wiki_entry).permit(:title, :body)
  end

  def user_not_authorized
    flash[:error] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end

  def set_wiki_entry
    @wiki_entry = WikiEntry.find(params[:id])
  end

end
