class ToDosController < ApplicationController
  before_action :require_login
  before_action :set_to_dos_and_counts, only: [ :index, :create ]

  def index
    @to_do = ToDo.new
  end

  def create
    @to_do = current_user.to_dos.build(to_do_params)
    if @to_do.save
      redirect_to to_dos_path
    else
      render :index
    end
  end

  def toggle
    @to_do = current_user.to_dos.find_by(id: params[:id])
    if @to_do && !@to_do.completed?
      @to_do.update(completed: true)
      flash[:notice] = "Task marked as completed."
    else
      flash[:alert] = "Already marked."
    end
    redirect_to to_dos_path
  end


  def destroy
    ToDo.find(params[:id]).destroy
    redirect_to to_dos_path
  end

  private

  def to_do_params
    params.require(:to_do).permit(:title)
  end

  def set_to_dos_and_counts
    @to_dos = current_user.to_dos.order(created_at: :desc)
    @grouped_todos = @to_dos.group_by { |todo| todo.created_at.to_date }
    @total_count = @to_dos.count
    @completed_count = @to_dos.where(completed: true).count
    @uncompleted_count = @to_dos.where(completed: false).count
  end
end
