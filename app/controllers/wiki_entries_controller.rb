class WikiEntriesController < ApplicationController
  include Pundit
  before_action :require_sign_in, :except => :public
  after_action :verify_authorized, :except => [:index, :public]
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def public
    @wiki_entries = WikiEntry.where(private: false)
  end

  def index
    @wiki_entries = current_user.wiki_entries
  end

  def show
    @wiki_entry = WikiEntry.find(params[:id])
    authorize @wiki_entry
  end

  def new
    @wiki_entry = current_user.wiki_entries.new
    authorize @wiki_entry
  end

  def create
    @wiki_entry = current_user.wiki_entries.new(wiki_entry_params)
    @wiki_entry.user_id = current_user.id

    if @wiki_entry.save
      flash[:notice] = "Wiki entry was saved."
      redirect_to(request.referrer || wiki_entries_path)
    else
      flash[:error] = "There was an error saving the wiki entry. Please try again."
      render :new
    end
    authorize @wiki_entry
  end

  def edit
    @wiki_entry = WikiEntry.find(params[:id])
    authorize @wiki_entry
  end

  def update
    @wiki_entry = WikiEntry.find(params[:id])
    authorize @wiki_entry

    if @wiki_entry.update_attributes(wiki_entry_params)
      flash[:notice] = "Wiki was updated."
      redirect_to (request.referrer || wiki_entries_path)
    else
      flash[:error] = "There was an error saving the wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki_entry = current_user.wiki_entries.find(params[:id])
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

end
