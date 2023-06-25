class ExpensesController < ApplicationController
  # before_action :set_expense, only: %i[ show edit update destroy ]
  before_action :set_category, only: %i[index new create]

  # GET /expenses or /expenses.json
  def index
    @category_expenses = Expense.where(category_id: params[:category_id])
    @expenses = @category.expenses.includes(:user).order(created_at: :desc)
    @total_amount = @expenses.sum(:amount)
  end

  # GET /expenses/1 or /expenses/1.json
  def show
  end

  # GET /expenses/new
  def new
    @expense = Expense.new
  end

  # GET /expenses/1/edit
  def edit
  end

  # POST /expenses or /expenses.json
  def create
    @expense = @category.expenses.build(expense_params)
    @expense.save
    if @expense.save
      @category.expenses << @expense

      redirect_to category_expenses_path
    else
      render :new
    end
  end

  # PATCH/PUT /expenses/1 or /expenses/1.json
  def update
  end

  # DELETE /expenses/1 or /expenses/1.json
  def destroy
    @expense.destroy
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = Category.find(params[:category_id])
  end

  private

  def expense_params
    params.require(:expense).permit(:name, :amount).merge(author_id: current_user.id)
  end
  # Only allow a list of trusted parameters through.
end


# def set_category
#   @category = Category.find(params[:category_id])
# end