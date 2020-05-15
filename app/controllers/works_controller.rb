class WorksController < ApplicationController
  def index
    session[:return_to] = works_path
    @works = Work.all
  end

  def show
    @work = Work.find_by(id: params[:id])
    
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
      redirect_to works_path
      flash[:success] = "Successfully added new work: #{view_context.link_to @work.title, work_path(@work.id) }"
      return
    else 
      render :new, status: :bad_request
      return
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      head :not_found
      return
    end
  end

  def update
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      head :not_found
      return
    elsif @work.update(work_params)
      redirect_to work_path(@work.id)
      return
    else 
      render :edit, status: :bad_request 
      return
    end
  end

  def destroy
    work = Work.find_by(id: params[:id])

    if work.nil?
      head :not_found
      return
    end

    work.destroy

    redirect_to works_path
    return
  end

  def upvote
    if session[:user_id].nil?
      flash[:info] = "Unable to upvote unless logged in. Please login first."
      redirect_to login_path
      return
    end

    work = Work.find_by(id: params[:id])
    user = User.find_by(id: session[:user_id])

    if work.nil? || user.nil?
      head :not_found
      return
    end

    if user.works.include? work
      flash[:warning] = "You have already voted on this work!"
    else
      new_vote = Vote.new(user_id: user.id, work_id: work.id)

      if new_vote.save
        flash[:success] = "You have successfully voted on this work!"
      else
        render :new, status: :bad_request
        return
      end
    end

    # change so that it will go back to wherever it was before
    redirect_to session.delete(:return_to)
    return
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

end
