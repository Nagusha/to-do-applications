class ToDosController < ApplicationController
  before_action :set_to_dos_and_counts, only: [ :index, :create ]

  def index
    @to_do = ToDo.new
  end

  def create
    @to_do = ToDo.new(to_do_params)
    if @to_do.save
      redirect_to to_dos_path
    else
      render :index
    end
  end

  def toggle
    @to_do = ToDo.find(params[:id])
    @to_do.toggle!(:completed)
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
    @to_dos = ToDo.order(created_at: :desc)
    @grouped_todos = @to_dos.group_by { |todo| todo.created_at.to_date }
    @total_count = @to_dos.count
    @completed_count = @to_dos.where(completed: true).count
    @uncompleted_count = @to_dos.where(completed: false).count
  end
end
