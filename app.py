from flask import Flask, render_template, request, redirect, url_for, session, flash
from flask_mysqldb import MySQL
import subprocess
import os
import datetime
from datetime import datetime 

app = Flask(__name__)
app.secret_key = 'your_secret_key'  # Set a secret key for session management

app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'root'
app.config['MYSQL_DB'] = 'umar'

mysql = MySQL(app)


# Routes




# Index
@app.route('/')
def index():
    return render_template('index.html')




# Login
@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']

        # Fetch user from database
        cur = mysql.connection.cursor()
        cur.execute("SELECT * FROM users WHERE username = %s AND password = %s", (username, password))
        user = cur.fetchone()
        cur.close()

        if user:
            session['logged_in'] = True
            session['username'] = username
            # Login successful
            flash('Login successful!', 'success')  # Flash success message
            return redirect(url_for('dashboard'))
        else:
            # Incorrect username or password
            flash('Incorrect username or password', 'error')  # Flash error message
            return render_template('login.html')

    return render_template('login.html')

def is_logged_in():
    return 'logged_in' in session and session['logged_in']



# Logout
@app.route('/logout')
def logout():
    session.clear()
    session['logged_in'] = False
    return redirect(url_for('login'))




   

#dashboard
@app.route('/dashboard', methods=['GET', 'POST'])
def dashboard():
    if is_logged_in():
        # Retrieve data from the database
        cur = mysql.connection.cursor()
        
        # Get the total number of customers
        cur.execute("SELECT COUNT(*) as total_customers FROM customers")
        total_customers = cur.fetchone()[0]  # Access the first element of the tuple
        
        # Get the total number of instructors
        cur.execute("SELECT COUNT(*) as total_instructors FROM instructors")
        total_instructors = cur.fetchone()[0]  # Access the first element of the tuple
        
        # Calculate total revenue as the sum of payments and due fees
        cur.execute("SELECT COALESCE(SUM(amount), 0) as total_payments FROM payments")
        total_payments = cur.fetchone()[0] or 0
        cur.execute("SELECT COALESCE(SUM(amount), 0) as total_duefees FROM duefees")
        total_duefees = cur.fetchone()[0] or 0
        total_revenue = total_payments + total_duefees
        
        # Calculate total expenses from salaries and rentals
        cur.execute("SELECT COALESCE(SUM(amount), 0) as total_salaries FROM salaries")
        total_salaries = cur.fetchone()[0] or 0
        cur.execute("SELECT COALESCE(SUM(amount), 0) as total_rentals FROM rentals")
        total_rentals = cur.fetchone()[0] or 0
        total_expenses = total_salaries + total_rentals
        
        # Calculate profit
        profit = total_revenue - total_expenses
        
        # Get the total number of workouts
        cur.execute("SELECT COUNT(*) as total_workouts FROM workouts")
        total_workouts = cur.fetchone()[0]  # Access the first element of the tuple
        
        # Close the cursor
        cur.close()
        
        # Render the dashboard template with the collected data
        return render_template('dashboard.html', total_customers=total_customers,
                                total_instructors=total_instructors,
                                total_revenue=total_revenue,
                                total_expenses=total_expenses,
                                profit=profit,
                                total_workouts=total_workouts)
    else:
        return redirect(url_for('login'))






# Define the BMI calculation function
def calculate_bmi(height, weight):
    # Calculate BMI using the formula: BMI = weight (kg) / (height (m) * height (m))
    height_meters = height / 100  # Convert height from cm to meters
    bmi = weight / (height_meters * height_meters)
    return bmi

@app.route('/interview', methods=['GET', 'POST'])
def interview():
    if is_logged_in():
        
        if request.method == 'POST':
            # Get form data including height, weight, and interview details
            height = float(request.form['height'])
            weight = float(request.form['weight'])
            food_intake = request.form['food_intake']
            activities = request.form['activities']
            goal = request.form['goal']
            
            # Calculate BMI
            bmi = calculate_bmi(height, weight)
            
            # Determine if BMI is within healthy range and provide workout recommendations
            if bmi < 18.5:
                recommendation = "You are underweight. Consider focusing on strength training and a balanced diet to gain muscle mass."
            elif 18.5 <= bmi < 24.9:
                recommendation = "Your BMI is within a healthy range. Continue with regular exercise and a balanced diet to maintain your health."
            elif 25 <= bmi < 29.9:
                recommendation = "You are overweight. Focus on cardio exercises and calorie control to reduce body fat."
            else:
                recommendation = "You are obese. Consult with a fitness trainer and nutritionist to develop a comprehensive plan for weight loss."
            
            # Render dashboard template with collected information, BMI, and recommendations
            return render_template('interview.html', bmi=bmi, height=height, weight=weight,
                                   food_intake=food_intake, activities=activities, goal=goal,
                                   recommendation=recommendation)
        else:
            return render_template('interview.html')
    else:
        return redirect(url_for('login'))
    




#Customers    
# Customer Registration
@app.route('/customer_registration', methods=['GET', 'POST'])
def customer_registration():
    if is_logged_in():
        # Fetch workouts from the database
        cur = mysql.connection.cursor()
        cur.execute("SELECT * FROM workouts")
        workouts = cur.fetchall()
        cur.close()
        # Render the customer registration form and pass the workouts
        return render_template('customer_registration.html', workouts=workouts)
    else:
        return redirect(url_for('login'))

# Route to handle customer registration form submission
@app.route('/add_customer', methods=['POST'])
def add_customer():
    if is_logged_in():
        if request.method == 'POST':
            # Extract form data
            name = request.form['name']
            email = request.form['email']
            phone = request.form['phone']
            height = request.form['height']
            weight = request.form['weight']
            waist = request.form['waist']
            workout = request.form['workout']
            goal = request.form['goal']
            # Save data to the database
            cur = mysql.connection.cursor()
            cur.execute("INSERT INTO customers (name, email, phone, height, weight, waist, workout, goal) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)",
                        (name, email, phone, height, weight, waist, workout, goal))
            mysql.connection.commit()
            cur.close()
            # Redirect to confirmation page
            return redirect(url_for('customer_registration_confirmation'))
        else:
            # Handle GET request if needed
            pass
            return redirect(url_for('customer_registration_confirmation'))

    else:
        return redirect(url_for('login'))
    
@app.route('/customers')
def view_customers():
    
    if is_logged_in():
        current_url = request.path
        cur = mysql.connection.cursor()
        cur.execute("SELECT * FROM customers")
        customers = cur.fetchall()
        cur.close()
        return render_template('view_customers.html', customers=customers, current_url=current_url)  
          
    else:
        return redirect(url_for('login'))  
    

@app.route('/customer_registration_confirmation')
def customer_registration_confirmation():
    if is_logged_in():
          
        return render_template('customer_registration_confirmation.html')
    else:
        return redirect(url_for('login'))  
    
   
@app.route('/edit_customer/<int:customer_id>', methods=['GET', 'POST'])
def edit_customer(customer_id):
    if is_logged_in():
        if request.method == 'GET':
            # Fetch customer data from the database
            cursor = mysql.connection.cursor()
            cursor.execute("SELECT * FROM customers WHERE customer_id = %s", (customer_id,))
            customer = cursor.fetchone()  # Fetch a single row
            cursor.close()

            # Render the edit_customer.html template with customer data
            return render_template('edit_customer.html', customer=customer)
        elif request.method == 'POST':
            # Get form data from the request
            name = request.form['name']
            email = request.form['email']
            phone = request.form['phone']
            height = request.form['height']
            weight = request.form['weight']
            waist = request.form['waist']
            workout = request.form['workout']
            goal = request.form['goal']

            # Update customer data in the database
            with mysql.connection.cursor() as cursor:
                cursor.execute("UPDATE customers SET name=%s, email=%s, phone=%s, height=%s, weight=%s, waist=%s, workout=%s, goal=%s WHERE customer_id=%s", (name, email, phone, height, weight, waist, workout, goal, customer_id))
                mysql.connection.commit()
                cursor.close()
            # Redirect to the edit_customer_confirmation route after updating
            return redirect(url_for('edit_customer_confirmation'))
        # Render the edit_customer form with pre-filled data
        return render_template('edit_customer.html', customer=customer) 
          
    else:
        return redirect(url_for('login'))  
    


@app.route('/edit_customer_confirmation', methods=['GET'])
def edit_customer_confirmation():
    if is_logged_in():
          
          return render_template('edit_customer_confirmation.html')

    else:
        return redirect(url_for('login')) 
    
  # Route to delete an customer  
@app.route('/delete_customer/<int:customer_id>', methods=['POST'])
def delete_customer(customer_id):
    if is_logged_in():
        cur = mysql.connection.cursor()
        cur.execute("DELETE FROM customers WHERE customer_id = %s", (customer_id,))
        mysql.connection.commit()
        cur.close()
        return redirect(url_for('view_customers'))
    else:
        return redirect(url_for('login')) 
    





#Instructors
# Route to handle GET requests for instructor registration form
@app.route('/instructor_registration', methods=['GET'])
def show_instructor_registration_form():
    if is_logged_in():
        # Render the instructor registration form template
        return render_template('instructor_registration_form.html')
    else:
        return redirect(url_for('login')) 
    
# Route to handle POST requests for instructor registration form submission
@app.route('/register_instructor', methods=['POST'])
def register_instructor():
    if is_logged_in():
            
            # Get form data
        name = request.form['name']
        email = request.form['email']
        qualification = request.form['qualification']
        timings = request.form['timings']
        phone = request.form['phone']

        # Connect to MySQL and insert data into the database
        cur = mysql.connection.cursor()
        cur.execute("INSERT INTO instructors (name, email, qualification, timings, phone) VALUES (%s, %s, %s, %s, %s)", (name, email, qualification, timings, phone))
        mysql.connection.commit()
        cur.close()
        # After processing, you can redirect to a confirmation page
        return redirect(url_for('instructor_registration_confirmation'))
    else:
        return redirect(url_for('login')) 
# Route to display instructor registration confirmation page
@app.route('/instructor_registration_confirmation')
def instructor_registration_confirmation():
    if is_logged_in():
        return render_template('instructor_registration_confirmation.html')
    else:
        return redirect(url_for('login')) 
    
@app.route('/instructors')
def view_instructors():
    if is_logged_in():
        cur = mysql.connection.cursor()
        cur.execute("SELECT * FROM instructors")
        instructors = cur.fetchall()
        cur.close()
        return render_template('view_instructors.html', instructors=instructors)
    else:
        return redirect(url_for('login')) 
    
@app.route('/edit_instructor/<int:instructor_id>', methods=['GET', 'POST'])
def edit_instructor(instructor_id):
    if is_logged_in():
        if request.method == 'GET':
            # Fetch instructor data from the database
            cursor = mysql.connection.cursor()
            cursor.execute("SELECT * FROM instructors WHERE instructor_id = %s", (instructor_id,))
            instructor = cursor.fetchone()  # Fetch a single row
            cursor.close()

            # Render the edit_instructor.html template with instructor data
            return render_template('edit_instructor.html', instructor=instructor)
        
        elif request.method == 'POST':
            # Get form data from the request
            name = request.form['name']
            email = request.form['email']
            phone = request.form['phone']
            qualification = request.form['qualification']
            timings = request.form['timings']

            # Update instructor data in the database
            with mysql.connection.cursor() as cursor:
                cursor.execute("UPDATE instructors SET name=%s, email=%s, phone=%s, qualification=%s, timings=%s WHERE instructor_id=%s", (name, email, phone, qualification, timings, instructor_id))
                mysql.connection.commit()
            # Redirect to the edit_instructor_confirmation route after updating
            return redirect(url_for('edit_instructor_confirmation'))
        
        # Handle other HTTP methods if needed
        return redirect(url_for('dashboard'))
    else:
        return redirect(url_for('login')) 

@app.route('/edit_instructor_confirmation', methods=['GET'])
def edit_instructor_confirmation():
    if is_logged_in():
        return render_template('edit_instructor_confirmation.html')
    else:
        return redirect(url_for('login')) 
# Route to delete an instructor
@app.route('/delete_instructor/<int:instructor_id>', methods=['POST'])
def delete_instructor(instructor_id):
    if is_logged_in():
        cur = mysql.connection.cursor()
        cur.execute("DELETE FROM instructors WHERE instructor_id = %s", (instructor_id,))
        mysql.connection.commit()
        cur.close()
        return redirect(url_for('view_instructors'))
    else:
        return redirect(url_for('login')) 





#Workouts
# Route for rendering the workout management page
@app.route('/workout_management')
def workout_management():
    if is_logged_in():
        cur = mysql.connection.cursor()
        
        # Fetch existing workouts from database
        cur.execute("SELECT * FROM workouts")
        workouts = cur.fetchall()
        
        # Fetch existing Customers from database
        cur.execute("SELECT * FROM customers")
        customers = cur.fetchall()

        # Fetch categories from the workout_categories table
        cur.execute("SELECT category_id, category_name FROM workout_categories")
        categories = cur.fetchall()
        
        # Execute the join query
        cur.execute(
            "SELECT workouts.Name AS workout_name, workout_categories.category_name, workouts.workout_id "
            "FROM workouts "
            "JOIN workout_categories ON workouts.category_id = workout_categories.category_id;"
        )
        # Fetch all the results
        query_results = cur.fetchall()

        # Close the cursor and connection
        cur.close()
        
        # Pass both workouts and categories to the template
        return render_template('workout_management.html', workouts=workouts, customers=customers, categories=categories, query_results=query_results)
    else:
        return redirect(url_for('login')) 
    
# Route for adding a new workout
@app.route('/add_workout', methods=['POST'])
def add_workout():
    if is_logged_in():
        if request.method == 'POST':
            workout_name = request.form['workout_name']
            category = request.form['category']
            
            cur = mysql.connection.cursor()

            # Insert new workout into database
            sql = "INSERT INTO workouts (name, category_id) VALUES (%s, %s)"
            val = (workout_name, category)
            cur.execute(sql, val)
            mysql.connection.commit()
            cur.close()
            flash('Workout added successfully!', 'success')
            return redirect(url_for('workout_management'))
    else:
        return redirect(url_for('login')) 
# Route for deleting a workout
@app.route('/delete_workout/<int:workout_id>', methods=['POST'])
def delete_workout(workout_id):
    if is_logged_in():
        cur = mysql.connection.cursor()
        # Delete the workout record from the database
        cur.execute("DELETE FROM workouts WHERE workout_id = %s", (workout_id,))
        mysql.connection.commit()
        cur.close()
        flash('Workout deleted successfully!', 'success')
        return redirect(url_for('workout_management'))
    else:
        return redirect(url_for('login')) 
    
@app.route('/edit_workout/<int:workout_id>', methods=['GET', 'POST'])
def edit_workout(workout_id):
    if is_logged_in():
        
        if request.method == 'POST':
            try:
                # Get updated workout details from the form
                workout_name = request.form['workout_name']
                category = request.form['category']
                
                cur = mysql.connection.cursor()
                # Update the workout record in the database
                cur.execute("UPDATE workouts SET name = %s, category_id = %s WHERE workout_id = %s", (workout_name, category, workout_id))
                mysql.connection.commit()
                flash('Workout updated successfully', 'success')  # Flash success message
                # Redirect to the workout management page after editing
                return redirect('/workout_management')  # Redirect to the workout management page
            except Exception as e:
                # Handle the error here
                flash('An error occurred while updating the workout', 'error')
                return redirect(request.url)  # Redirect back to the same page to display the error message

        else:
            try:
                cur = mysql.connection.cursor()
                # Fetch the workout details from the database
                cur.execute("SELECT name, category_id FROM workouts WHERE workout_id = %s", (workout_id,))
                workout = cur.fetchone()
                
                # Fetch categories from the workout_categories table
                cur.execute("SELECT category_id, category_name FROM workout_categories")
                categories = cur.fetchall()
                
                return render_template('edit_workout.html', workout=workout, categories=categories, workout_id=workout_id)
            except Exception as e:
                # Handle the error here
                flash('An error occurred while fetching the workout details', 'error')
                return redirect('/workout_management')  # Redirect to the workout management page if an error occurs during fetching
    else:
        return redirect(url_for('login'))
           
# Route for assigning a workout to a customer
@app.route('/assign_workout', methods=['POST'])
def assign_workout():
    if is_logged_in():
        if request.method == 'POST':
            customer_id = request.form['customer_name']
            workout_id = request.form['workout_select']
            cur = mysql.connection.cursor()
            cur.execute('INSERT INTO Customer_Workout_plans (customer_id, workout_id) VALUES (%s, %s)', (customer_id, workout_id))
            mysql.connection.commit()
            cur.close()
            flash('Workout assigned to customer successfully!', 'success')
            return redirect(url_for('workout_management'))
    else:
        return redirect(url_for('login'))
        



#Accounts
@app.route('/accounts')
def accounts():
    if is_logged_in():
        # Fetch and display payments, salaries, rentals, and due fees
        payments = get_payments_from_database()  # Fetch payments from the database
        salaries = get_salaries_from_database()  # Fetch salaries from the database
        rentals = get_rentals_from_database()    # Fetch rentals from the database
        due_fees = get_due_fees_from_database()  # Fetch due fees from the database
        return render_template('accounts.html', payments=payments, salaries=salaries, rentals=rentals, due_fees=due_fees)
    else:
        return redirect(url_for('login'))
    
@app.route('/add_payment', methods=['POST'])
def add_payment():
    if is_logged_in():
        # Retrieve data from the form
        customer_id = request.form['customer_id']
        amount = request.form['amount']
        payment_date = request.form['payment_date']
        
        cur = mysql.connection.cursor()
        cur.execute('INSERT INTO Payments (customer_id, amount, payment_date) VALUES (%s, %s, %s)',(customer_id, amount, payment_date))
        mysql.connection.commit()
        cur.close()
        flash('Added the Customer payment successfully!', 'success')
        return redirect('/accounts')
    else:
        return redirect(url_for('login'))
    
@app.route('/add_salary', methods=['POST'])
def add_salary():
    if is_logged_in():
        # Get form data
        employee_id = request.form['employee_id']
        salary_amount = request.form['salary_amount']
        salary_date = request.form['salary_date']
        
        cur = mysql.connection.cursor()
        cur.execute('INSERT INTO Salaries (instructor_id, amount, salary_date) VALUES (%s, %s, %s)',(employee_id, salary_amount, salary_date))
        mysql.connection.commit()
        cur.close()
        
        flash('Added the Salary payment successfully!', 'success')
        return redirect('/accounts')
    else:
        return redirect(url_for('login'))

@app.route('/add_rental', methods=['POST'])
def add_rental():
    if is_logged_in():
        # Get form data
        Name = request.form['Name']
        rental_amount = request.form['rental_amount']
        rental_date = request.form['rental_date']
            
        cur = mysql.connection.cursor()
        cur.execute('INSERT INTO Rentals (name, amount, rental_date) VALUES (%s, %s, %s)',(Name, rental_amount, rental_date))
        mysql.connection.commit()
        cur.close()
        
        flash('Added the Rental payment successfully!', 'success')
        return redirect('/accounts')
    else:
        return redirect(url_for('login'))

@app.route('/add_due_fee', methods=['POST'])
def add_due_fee():
    if is_logged_in():
        # Extract data from the form submission
        customer_id = request.form['customer_id']
        amount = request.form['amount']
        due_date = request.form['due_date']
        
        cur = mysql.connection.cursor()
        cur.execute('INSERT INTO DueFees (customer_id, amount, due_date) VALUES (%s, %s, %s)',(customer_id, amount, due_date))
        mysql.connection.commit()
        cur.close()
        
        flash('Added the Due Fee successfully!', 'success')
        return redirect('/accounts')
    else:
        return redirect(url_for('login'))

# Functions to fetch data from the database
def get_payments_from_database():
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM Payments")
    payments = cur.fetchall()
    return payments

def get_salaries_from_database():
    # Fetch salaries from the database
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM Salaries")
    salaries = cur.fetchall()
    return salaries

def get_rentals_from_database():
    # Fetch rentals from the database
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM Rentals")
    rentals = cur.fetchall()
    return rentals

def get_due_fees_from_database():
    # Fetch due fees from the database
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM DueFees")
    due_fees = cur.fetchall()
    return due_fees





# Route to display reports
@app.route('/reports', methods=['GET'])
def show_reports():
    if is_logged_in():
        cur = mysql.connection.cursor()
        cur.execute("SELECT * FROM reports")
        allreports = cur.fetchall()
        # Convert fetched data into dictionaries
        allreports_dict = []
        for row in allreports:
            report_dict = {
                'report_id': row[0],
                'report_type': row[1],
                'data': row[2],
                'report_date': row[3]
            }
            allreports_dict.append(report_dict)
        cur.close()
        return render_template('reports.html', allreports=allreports_dict)
    else:
        return redirect(url_for('login'))
    
   

# POST route for generating reports
@app.route('/generate_report', methods=['POST'])
def generate_report():
    if is_logged_in():
        report_type = request.form['report_type']
        report_period = request.form['report_period']
        
        cur = mysql.connection.cursor()

        # Fetch data from database based on report type and period
        if report_period == 'daily':
            query = f"SELECT * FROM reports WHERE report_type = '{report_type}' AND report_date = CURDATE()"
        elif report_period == 'weekly':
            query = f"SELECT * FROM reports WHERE report_type = '{report_type}' AND YEARWEEK(report_date) = YEARWEEK(NOW())"
        elif report_period == 'monthly':
            query = f"SELECT * FROM reports WHERE report_type = '{report_type}' AND MONTH(report_date) = MONTH(NOW()) AND YEAR(report_date) = YEAR(NOW())"
        else:
            query = f"SELECT * FROM reports WHERE report_type = '{report_type}'"
    
        cur.execute(query)
        reports = cur.fetchall()
        
        if report_type == 'Weight':
            # Fetch weight data from customers table
            cur.execute("SELECT name, weight FROM customers")
            weight_data = cur.fetchall()
            reports = [{'report_id': None, 'report_type': 'Weight', 'data': f"{row[0]}: {row[1]}", 'report_date': datetime.datetime.now().strftime("%Y-%m-%d_%H-%M-%S") } for row in weight_data]

        elif report_type == 'Fee':
            # Fetch fee data from payments table
            cur.execute("SELECT customer_id, amount FROM payments")
            fee_data = cur.fetchall()
            reports = [{'report_id': None, 'report_type': 'Fee', 'data': f"Customer ID: {row[0]}, Amount: {row[1]}", 'report_date': datetime.datetime.now().strftime("%Y-%m-%d_%H-%M-%S") } for row in fee_data]

        elif report_type == 'Due Fees':
            # Fetch due fee data from duefees table
            cur.execute("SELECT customer_id, amount FROM duefees")
            due_fee_data = cur.fetchall()
            reports = [{'report_id': None, 'report_type': 'Due Fees', 'data': f"Customer ID: {row[0]}, Amount: {row[1]}", 'report_date': datetime.datetime.now().strftime("%Y-%m-%d_%H-%M-%S") } for row in due_fee_data]

        elif report_type == 'Salary':
            # Fetch salary data from salaries table
            cur.execute("SELECT instructor_id, amount FROM salaries")
            salary_data = cur.fetchall()
            reports = [{'report_id': None, 'report_type': 'Salary', 'data': f"Instructor ID: {row[0]}, Amount: {row[1]}", 'report_date': datetime.datetime.now().strftime("%Y-%m-%d_%H-%M-%S") } for row in salary_data]

        elif report_type == 'Expense':
            # Calculate total expenses dynamically from relevant tables
            cur.execute("SELECT COALESCE(SUM(amount), 0) FROM salaries")
            total_salaries = cur.fetchone()[0] or 0
            cur.execute("SELECT COALESCE(SUM(amount), 0) FROM rentals")
            total_rentals = cur.fetchone()[0] or 0
            total_expenses = total_salaries + total_rentals
            reports = [{'report_id': None, 'report_type': 'Expense', 'data': f"Total Expenses: {total_expenses}", 'report_date': datetime.datetime.now().strftime("%Y-%m-%d_%H-%M-%S") }]

        elif report_type == 'Profit':
            # Calculate profit by subtracting dynamically calculated expenses from total revenue
            cur.execute("SELECT COALESCE(SUM(amount), 0) FROM payments")
            total_revenue_from_payments = cur.fetchone()[0] or 0
            cur.execute("SELECT COALESCE(SUM(amount), 0) FROM duefees")
            total_revenue_from_duefees = cur.fetchone()[0] or 0
            total_revenue = total_revenue_from_payments + total_revenue_from_duefees

            cur.execute("SELECT COALESCE(SUM(amount), 0) FROM salaries")
            total_salaries = cur.fetchone()[0] or 0
            cur.execute("SELECT COALESCE(SUM(amount), 0) FROM rentals")
            total_rentals = cur.fetchone()[0] or 0
            total_expenses = total_salaries + total_rentals

            profit = total_revenue - total_expenses
            reports = [{'report_id': None, 'report_type': 'Profit', 'data': f"Profit: {profit}", 'report_date': datetime.datetime.now().strftime("%Y-%m-%d_%H-%M-%S") }]

        else:
            reports = []

        # Insert reports into the reports table
        for report in reports:
            cur.execute("INSERT INTO reports (report_type, data, report_date) VALUES (%s, %s, %s)", (report['report_type'], report['data'], report['report_date']))
            mysql.connection.commit()

        # Fetch report IDs from the reports table
        cur.execute("SELECT report_id FROM reports ORDER BY report_id DESC LIMIT %s", (len(reports),))
        report_ids = cur.fetchall()

        # Update report IDs in the generated reports
        for i, report in enumerate(reports):
            reports[i]['report_id'] = report_ids[i][0]

        cur.close()
        flash('Report generated successfully', 'success')
        return render_template('reports.html', selected_report_type=report_type, allreports=reports)
    else:
        return redirect(url_for('login'))





#Backups
# Define the path to the MySQL bin directory
mysql_bin_path = r'C:\Program Files\MySQL\MySQL Server 8.0\bin'

# Import the datetime module
import datetime

# Define the route for handling backup creation
@app.route('/backup', methods=['GET', 'POST'])
def backup():
    if is_logged_in():
        if request.method == 'POST':
            try:
                backup_folder = 'C:/FitnessClubManagementSystem/Backup'  # Specify the full path to the backup folder
                if not os.path.exists(backup_folder):
                    os.makedirs(backup_folder)
                
                current_time = datetime.datetime.now().strftime("%Y-%m-%d_%H-%M-%S")  # Corrected usage of datetime module
                backup_file = f"{backup_folder}/backup_{current_time}.sql"

                # Replace placeholders with actual MySQL credentials and database name
                username = 'root'
                password = 'root'  
                dbname = 'umar'

                # Execute mysqldump command to create a backup including data
                subprocess.run([f'{mysql_bin_path}/mysqldump', '-u', username, '-p' + password, dbname, '>', backup_file], shell=True)

                return render_template('backup.html', backup_success=True, message=f"Backup created successfully. Filename: {backup_file}")
            except Exception as e:
                print(e)  # Print the error for debugging
                return render_template('backup.html', backup_success=False, message=f"Failed to create backup: {str(e)}")
        else:
            return render_template('backup.html', backup_success=False, message="")
    else:
        return redirect(url_for('login'))




if __name__ == '__main__':
    app.run(debug=True)
