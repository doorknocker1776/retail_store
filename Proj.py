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
    autocommit = True
)
@app.route('/get_user', methods=['POST', 'GET'])

def get_user():
    # Get the user data from the request
    username = request.args.get('UserID')
    print(username)
    password = request.args.get('Password')
    print(password)
    bank_account_number = request.args.get('Account_No')
    bank_name = request.args.get('Bank_Name')
    # Insert the user data into the database
    cursor = cnx.cursor()
    try:
        query = f"INSERT INTO online_store.Customer (UserID, Password) VALUES ('{username}', '{password}');"
        print(query)
        cursor.execute(query)
        print(query)
        query = f"SELECT * FROM online_store.Customer;"
        print(query)
        cursor.execute(query)
        print(query)
        result = cursor.rowcount
        print(result)
        query = f"INSERT INTO online_store.Account (Account_No, Bank_Name, Customer_ID) VALUES ({bank_account_number}, '{bank_name}', {result+1});"
        print(query)
        cursor.execute(query)    
        return jsonify({'status': 'success'})
    except:
        return jsonify({'status': 'failed'})
@app.route('/login', methods=['POST', 'GET'])
def login():
    # Get the login credentials from the request
    username = request.args.get('UserID')
    print(username)
    password = request.args.get('Password')
    print(password)
    # Check if the login credentials are valid
    cursor = cnx.cursor()
    try:
        query = f"SELECT * FROM Customer WHERE UserID={username} AND Password={password}"
        cursor.execute(query)
        result = cursor.rowcount
        if (result != 0):
            cnx.commit()
            return jsonify({'status': 'success'})
        else: 
            return jsonify({'status': 'failed'})
    except:
        return jsonify({'status': 'failed'})
if __name__ == '__main__':
  app.run()