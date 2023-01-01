from flask import Flask, request, jsonify
import mysql.connector
import json
app = Flask(__name__)
# Connect to the MySQL database
cnx = mysql.connector.connect(
    host = 'localhost',
    user='root',
    password='seecs@123',
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
        cursor.execute(query)
        query = f"SELECT * FROM online_store.Customer WHERE UserID='{username}';"
        cursor.execute(query)
        result = cursor.fetchone()
        print(result[0])
        query = f"INSERT INTO online_store.Account (Account_No, Bank_Name, Customer_ID) VALUES ({bank_account_number}, '{bank_name}', {result[0]});"
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
        query = f"SELECT * FROM online_store.Customer WHERE UserID='{username}' AND Password='{password}'"
        print(query)
        cursor.execute(query)
        result = cursor.fetchone()
        print(result)
        if (result != None):
            return jsonify({'status': 'success'})
        else: 
            return jsonify({'status': 'failed'})
    except:
        return jsonify({'status': 'failed'})
@app.route('/pay', methods=['POST', 'GET'])
def pay():
        # Get the user data from the request
    username = request.args.get('UserID')
    print(username)
    password = request.args.get('Password')
    print(password)
    cursor = cnx.cursor()
    try:
        query = f"Select * from online_store.Customer where UserID='{username}' and Password='{password}';"
        cursor.execute(query)
        result = cursor.fetchone()
        if result == None:
            return jsonify({'status': 'failed'})
        else:
            return jsonify({'status': 'success'})               
    except:
        return jsonify({'status': 'failed'})
@app.route('/Order', methods=['POST', 'GET'])
def Order():
        # Get the user data from the request
    username = request.args.get('UserID')
    print(username)
    items = request.args.get('Items')
    items = items[1:-1]
    items = items.replace("\"","")
    x = ''.join(items)
    x = x.split(',')
    print(x)
    cursor = cnx.cursor()
    item_dict = {}
    for i in x:
        item_dict[i] = item_dict.get(i, [])+ [items.count(i)]
    print(item_dict)
    for key in item_dict:
        print(item_dict[key][-1])
    try:
        query = f"Select Customer_ID from online_store.Customer where UserID='{username}';"
        cursor.execute(query)
        result = cursor.fetchone()
        result = result[0]
        query1 = f"Select Order_ID from online_store.Orders;"
        cursor.execute(query1)
        result1 = cursor.fetchall()

        if result1 == None: 
            result1 = 1
        else:
            result1 = result1[-1][0]  
            result1 = result1 + 1
            for key in item_dict:
                query = f"Select ItemID from online_store.Item where Name='{key}';"
                print(query)
                cursor.execute(query)
                result2 = cursor.fetchone()
                result2 = result2[0]
                query = f"Insert into online_store.orders (Order_ID, Customer_ID, ItemID, Quantity) VALUES ({result1}, {result}, {result2}, {item_dict[key][-1]});"
                print(query)
                cursor.execute(query)
        return jsonify({'status': 'success'})               
    except:
        return jsonify({'status': 'failed'})

@app.route('/popuorders', methods=['POST', 'GET'])
def popuorders():
    try:

        username = request.args.get('UserID')
        print(username)

        cursor = cnx.cursor()

        query = f"Select Customer_ID from online_store.Customer where UserID='{username}';"
        cursor.execute(query)
        result = cursor.fetchone()
        result = result[0]

        query = f"Select bill_id, total_amount, discount, subtotal from online_store.bill where Customer_ID = {result};"
        cursor.execute(query)
        result = cursor.fetchall()
        print(result)
        return jsonify({'status': result})
    except:
        popuorders()

@app.route('/populate', methods=['POST', 'GET'])
def Populate():
    try:
        cursor = cnx.cursor()
        query = f"Select Name, Price from online_store.item where `Desc`='Electronics';"
        cursor.execute(query)
        result = cursor.fetchall()
        print(result)
        return jsonify({'status': result})
    except:
        Populate()

@app.route('/populate1', methods=['POST', 'GET'])

def Populate1():
    try:
        cursor = cnx.cursor()
        query = f"Select Name, Price from online_store.item where `Desc`='Grocery';"
        cursor.execute(query)
        result = cursor.fetchall()
        print(result)
        return jsonify({'status': result})
    except:
        Populate1()

@app.route('/populate2', methods=['POST', 'GET'])

def Populate2():
    try:
        cursor = cnx.cursor()
        query = f"Select Name, Price from online_store.item where `Desc`='Fashion';"
        cursor.execute(query)
        result = cursor.fetchall()
        print(result)
        return jsonify({'status': result})
    except:
        Populate2()

@app.route('/populate3', methods=['POST', 'GET'])
def Populate3():
    try:
        cursor = cnx.cursor()
        query = f"Select Name, Price from online_store.item;"
        cursor.execute(query)
        result = cursor.fetchall()
        print(result)
        return jsonify({'status': result})
    except:
        Populate3()
if __name__ == '__main__':
  app.run()