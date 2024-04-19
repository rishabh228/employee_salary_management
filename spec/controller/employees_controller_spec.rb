require 'rails_helper'

RSpec.describe EmployeesController, type: :controller do
   describe 'POST #create' do
		context 'with valid parameters' do
		  it 'creates a new employee' do
			 employee_params = {
				employee: {
				  employee_id: 'EMP001',
				  first_name: 'John',
				  last_name: 'Doe',
				  email: 'john@example.com',
				  phone_numbers: '1234567890',
				  doj: Date.parse('2023-01-01'),
				  salary: 50000
				}
			 }
  
			 expect {
				post :create, params: employee_params
			 }.to change(Employee, :count).by(1)
  
			 expect(response).to have_http_status(:created)
			 expect(JSON.parse(response.body)['status']).to eq('Employee created successfully')
		  end
		end

		context 'with invalid parameters' do
			it 'does not create a new employee' do
			  invalid_employee_params = {
				 employee: {
					employee_id: 'EMP001',
					first_name: 'John',
					last_name: 'Doe',
					email: 'john@example.com',
					phone_numbers: '', # Invalid, phone numbers can't be blank
					doj: Date.parse('2023-01-01'),
					salary: 50000
				 }
			  }
		 
			  expect {
				 post :create, params: invalid_employee_params
			  }.not_to change(Employee, :count)
		 
			  expect(response).to have_http_status(:unprocessable_entity)
			  expect(JSON.parse(response.body)['errors']).to include("Phone numbers can't be blank", "Phone numbers should be comma-separated 10 digit numbers")
			end
		end
	end

	describe 'GET #tax_deduction' do
		it 'returns JSON with tax deductions for each employee' do
		  # Create sample employees
		  employee1 = Employee.create(
			 employee_id: 'EMP001',
			 first_name: 'John',
			 last_name: 'Doe',
			 email: 'john@example.com',
			 phone_numbers: '1234567890',
			 doj: Date.parse('2023-01-01'),
			 salary: 50000
		  )

		  employee2 = Employee.create(
			 employee_id: 'EMP002',
			 first_name: 'Jane',
			 last_name: 'Smith',
			 email: 'jane@example.com',
			 phone_numbers: '9876543210',
			 doj: Date.parse('2023-06-15'),
			 salary: 75000
		  )

		  get :tax_deduction

		  expect(response).to have_http_status(:ok)
		  json_response = JSON.parse(response.body)

		  expect(json_response).to have_key('tax_deductions')
		  expect(json_response['tax_deductions']).to be_an(Array)
		  tax_deductions = json_response['tax_deductions']
  
		  employee1_deduction = tax_deductions.find { |deduction| deduction['employee_id'] == employee1.employee_id }
		  expect(employee1_deduction).not_to be_nil
		  expect(employee1_deduction['first_name']).to eq(employee1.first_name)
		  expect(employee1_deduction['last_name']).to eq(employee1.last_name)

		  employee2_deduction = tax_deductions.find { |deduction| deduction['employee_id'] == employee2.employee_id }
		  expect(employee2_deduction).not_to be_nil
		  expect(employee2_deduction['first_name']).to eq(employee2.first_name)
		  expect(employee2_deduction['last_name']).to eq(employee2.last_name)

		end
	end
end
