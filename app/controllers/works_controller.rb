class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def show
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      redirect_to works_path
      return
    end
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

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

end
