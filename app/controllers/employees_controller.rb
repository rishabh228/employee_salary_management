class EmployeesController < ApplicationController
	
  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      render json: { status: 'Employee created successfully' }, status: :created
    else
      render json: { errors: @employee.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def tax_deduction
    employees = Employee.all
    tax_deductions = employees.map do |employee|
      yearly_salary = calculate_yearly_salary(employee)
      tax_amount = calculate_tax(yearly_salary)
      cess_amount = calculate_cess(yearly_salary)
      total_tax = tax_amount + cess_amount
      {
        employee_id: employee.employee_id,
        first_name: employee.first_name,
        last_name: employee.last_name,
        yearly_salary: yearly_salary,
        tax_amount: tax_amount,
        cess_amount: cess_amount,
        total_tax: total_tax
      }
    end
    render json: { tax_deductions: tax_deductions }, status: :ok
  end

  private

  def employee_params
    params.require(:employee).permit(:employee_id, :first_name, :last_name, :email, :phone_numbers, :doj, :salary)
  end

  def calculate_yearly_salary(employee)
		doj = employee.doj
		current_date = Date.today
		months_worked = (current_date.year - doj.year) * 12 + current_date.month - doj.month
		months_worked -= 1 if current_date.day < doj.day # Deduct a month if the DOJ is in the future for the current month
		months_worked = 0 if months_worked < 0 # Handle cases where DOJ is in the future
		total_salary = employee.salary * months_worked
		total_salary
	end

	def calculate_loss_of_pay_per_day(salary)
		loss_of_pay_per_day = salary / 30.0
		loss_of_pay_per_day
	end

  def calculate_tax(yearly_salary)
    case yearly_salary
    when 0..250000
      0
    when 250001..500000
      (yearly_salary - 250000) * 0.05
    when 500001..1000000
      12500 + (yearly_salary - 500000) * 0.1
    else
      62500 + (yearly_salary - 1000000) * 0.2
    end
  end

  def calculate_cess(yearly_salary)
		excess_amount = yearly_salary - 2500000
		if excess_amount > 0
			cess_amount = excess_amount * 0.02
		else
			cess_amount = 0
		end
		cess_amount
	end
end
