from flask import Flask, request, jsonify
import mysql.connector
import time
app = Flask(__name__)
# Connect to the MySQL database
cnx = mysql.connector.connect(
    host = 'localhost',
    user='root',
    password='sns@123',
    database="online_store",
    autocommit=True
)
@app.route('/get_user', methods=['POST', 'GET'])

def get_user():
    print(123)
    # Get the user data from the request
    username = request.args.get('UserID')
    print(username)
    #username = data['UserID']
    password = request.args.get('Password')
    print(password)
    #bank_account_number = data['Account_No']
    #bank_name = data['Bank_Name']
    # Insert the user data into the database
    cursor = cnx.cursor()
    query = f"INSERT INTO online_store.Customer (UserID, Password) VALUES ('{username}', '{password}');"
    cursor.execute(query)
    #query = f"INSERT INTO online_store.Account (Account_No, Bank_Name) VALUES ({bank_account_number}, '{bank_name}');"
    #cursor.execute(query)
    return "Success" 
@app.route('/login', methods=['POST'])
def login():
    # Get the login credentials from the request
    data = request.get_json()
    username = data['UserID']
    password = data['Password']

    # Check if the login credentials are valid
    cursor = cnx.cursor()
    query = f"SELECT * FROM Customer WHERE UserID={username} AND Password={password}"
    cursor.execute(query)
    result = cursor.fetchone()

if __name__ == '__main__':
  app.run()