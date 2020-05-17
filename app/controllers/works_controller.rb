class WorksController < ApplicationController
  before_action :require_login, only: [:upvote] 
  before_action :find_work, only: [:show, :edit, :update, :destroy, :upvote]
  
  CATEGORIES = ["album", "book", "movie"]

  def index
    session[:return_to] = works_path
    @works, @categories = Work.all, CATEGORIES
  end

  def show    
    if @work.nil?
      redirect_to works_path
      return
    end

    session[:return_to] = work_path(@work.id)
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params) 

    if @work.save 
      redirect_to work_path(@work.id)
      flash[:success] = "Successfully added new work: #{view_context.link_to "##{@work.id} #{@work.title}", work_path(@work.id) }"
      return
    else 
      render :new, status: :bad_request
      return
    end
  end

  def edit
    if @work.nil?
      head :not_found
      return
    end
  end

  def update
    if @work.nil?
      head :not_found
      return
    elsif @work.update(work_params)
      flash[:success] = "Successfully edited #{view_context.link_to @work.title, work_path(@work.id)}" 
      redirect_to work_path(@work.id)
      return
    else 
      render :edit, status: :bad_request 
      return
    end
  end

  def destroy
    if @work.nil?
      head :not_found
      return
    end

    @work.votes.each {|vote| vote.destroy}
    @work.destroy

    redirect_to works_path
    return
  end

  def upvote
    user = current_user

    if @work.nil? || user.nil?
      head :not_found
      return
    end

    if user.works.include? @work
      flash[:warning] = "You have already voted on #{view_context.link_to @work.title, work_path(@work.id)}!"
    else
      new_vote = Vote.new(user_id: user.id, work_id: @work.id)

      if new_vote.save
        flash[:success] = "You have successfully voted on #{view_context.link_to @work.title, work_path(@work.id)}!"
      else
        render :new, status: :bad_request
        return
      end
    end

    redirect_to session.delete(:return_to)
    return
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

  def find_work
    @work = Work.find_by(id: params[:id])
  end

end
