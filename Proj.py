from flask import Flask, request, jsonify
import mysql.connector
from datetime import date
from math import ceil
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
def aquery(bDate, sub, discount, result1):
        cursor = cnx.cursor()
        queryn = f"Insert into online_store.bill (BillDate, Subtotal, Discount, Order_ID) VALUES ('{bDate}', {sub}, {discount}, {result1})"
        cursor.execute(queryn)

def get_user():
    # Get the user data from the request
    username = request.args.get('UserID')
    password = request.args.get('Password')
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
        query = f"INSERT INTO online_store.Account (Account_No, Bank_Name, Customer_ID) VALUES ({bank_account_number}, '{bank_name}', {result[0]});"
        cursor.execute(query)   
        return jsonify({'status': 'success'})
    except:
        return jsonify({'status': 'failed'})

@app.route('/login', methods=['POST', 'GET'])
def login():
    # Get the login credentials from the request
    username = request.args.get('UserID')
    password = request.args.get('Password')
    # Check if the login credentials are valid
    cursor = cnx.cursor()
    try:
        query = f"SELECT * FROM online_store.Customer WHERE UserID='{username}' AND Password='{password}'"
        cursor.execute(query)
        result = cursor.fetchone()
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
    password = request.args.get('Password')
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
    sub = request.args.get('Total')
    sub = int(ceil(eval(sub)))
    discount = request.args.get('Discount')
    discount = int(ceil(eval(discount)))
    username = request.args.get('UserID')
    bDate = date.today()
    items = request.args.get('Items')
    items = items[1:-1]
    items = items.replace("\"","")
    x = ''.join(items)
    x = x.split(',')
    cursor = cnx.cursor()
    item_dict = {}
    for i in x:
        item_dict[i] = item_dict.get(i, [])+ [items.count(i)]

    try:
        query = f"Select Customer_ID from online_store.Customer where UserID='{username}';"
        cursor.execute(query)
        result = cursor.fetchone()
        result = result[0]
        query1 = f"Select Order_ID from online_store.Orders;"
        cursor.execute(query1)
        result1 = cursor.fetchall()
        result1.sort()
        if result1 == []: 
            result1 = 1
        else:
            result1 = result1[-1][0]  
            result1 = result1 + 1
        for key in item_dict:
            query = f"Select ItemID from online_store.Item where Name='{key}';"
            cursor.execute(query)
            result2 = cursor.fetchone()
            result2 = result2[0]
            query = f"Insert into online_store.orders (Order_ID, Customer_ID, ItemID, Quantity) VALUES ({result1}, {result}, {result2}, {item_dict[key][-1]});"
            cursor.execute(query)
            aquery(bDate, sub, discount, result1)
        return jsonify({'status': 'success'})               
    except:
        return jsonify({'status': 'failed'})

@app.route('/popuorders', methods=['POST', 'GET'])
def popuorders():
    try:

        username = request.args.get('UserID')
        cursor = cnx.cursor()

        query = f"Select Customer_ID from online_store.Customer where UserID='{username}';"
        cursor.execute(query)
        result = cursor.fetchone()
        result = result[0]
        query = f"Select SUM(Quantity),Total_Amount, Discount, Subtotal from bill join orders using (Order_ID) where orders.Customer_ID = {result} group by Order_ID;"
        cursor.execute(query)
        result = cursor.fetchall()
        return jsonify({'status': result})
    except:
        return jsonify({'status': []})

@app.route('/populate', methods=['POST', 'GET'])
def Populate():
    try:
        cursor = cnx.cursor()
        query = f"Select Name, Price from online_store.item where `Desc`='Electronics' and Availability = 1;"
        cursor.execute(query)
        result = cursor.fetchall()
        return jsonify({'status': result})
    except:
        return jsonify({'status': []})

@app.route('/populate1', methods=['POST', 'GET'])

def Populate1():
    try:
        cursor = cnx.cursor()
        query = f"Select Name, Price from online_store.item where `Desc`='Grocery' and Availability = 1;"
        cursor.execute(query)
        result = cursor.fetchall()
        return jsonify({'status': result})
    except:
        return jsonify({'status': []})

@app.route('/populate2', methods=['POST', 'GET'])

def Populate2():
    try:
        cursor = cnx.cursor()
        query = f"Select Name, Price from online_store.item where `Desc`='Fashion' and Availability = 1;"
        cursor.execute(query)
        result = cursor.fetchall()
        return jsonify({'status': result})
    except:
        return jsonify({'status': []})

@app.route('/populate3', methods=['POST', 'GET'])
def Populate3():
    try:
        cursor = cnx.cursor()
        query = f"Select Name, Price from online_store.item where Availability = 1;"
        cursor.execute(query)
        result = cursor.fetchall()
        return jsonify({'status': result})
    except:
        return jsonify({'status': []})

if __name__ == '__main__':
  app.run()