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

end
