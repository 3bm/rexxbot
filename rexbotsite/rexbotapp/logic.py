# Radical Graphics (c)2014
# ========================
# Rexbot Logic


def getPercentage (last_value, current_value):

	"""
	Get a value as reference (lastvalue) and compares it with the current value to return a percentage
	If the percentage result is bigger than 100 it substract the diference to get a percentage from 1-100
	If the percentage is smaller than 100 it substract the diference and it returns a negative value
	"""

	percentage = (current_value*100)/last_value

	percentage = percentage - 100

	# if percentage > 100:
	# 	percentage = percentage - 100
	# else:
	# 	percentage = (percentage - 100) 

	return percentage

def getMaxPercentage():
 	"""
 	It reads from the database the current Max Percentage (+3% by default)
 	"""
 	max_percentage = database_variable_name.max_percentage

 	return max_percentage

def getMinPercentage():
 	"""
 	It reads from the database the current Min Percentage (-3% by default)
 	"""
 	min_percentage = database_variable_name.min_percentage

 	return min_percentage


def checkBuyOrSellPercent (starting_price, current_price):

	"""
	It get the a starting price as refence and compares it with the current price 
	to see if we have to buy or sell applying the 3% rule (max min percent stored in database)
	It returns 2 booleans 'buy' and 'sell' to know if it's ok to buy or sell
	"""

	percentage = getPercentage(starting_price, current_price)

	max_percentage = getMaxPercentage()
	min_percentage = getMinPercentage()

	buy, sell = false
	
	if percentage > max_percentage:
		buy = true
	else if percentage < min_percentage:
		sell = true

	return buy, sell


def checkToBuy (purchased, buy):

	"""
	In order to buy we have to check if we bought/purchases already, if not, we buy
	purchased - Boolean - It means that we bought if true
	but - Boolean - It means that we can buy if true
	"""
	if (not purchased) and (buy):

		# buy logic code here <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


def checkToSell (sold, sell):

	"""
	In order to sell we have to check if we sold already, if not, we sell
	sold - Boolean - It means that we sold if true
	sell - Boolean - It means that we can sell if true
	"""
	if (not sold) and sell:

		# Sell logic code here <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<




def checkMaxValue (maxvalue, current_price):

	"""
	It gets the value that we have as maximum and check it with the current price
	if it is smaller it will update maxvalue to the current_price
	"""

	if maxvalue < current_price:

		maxvalue = current_price

	return maxvalue


def checkMinValue (minvalue, current_price):

	"""
	It gets the value that we have as minimum and check it with the current price
	if it is bigger it will update minvalue to the current_price
	"""

	if minvalue > current_price

		minvalue = current_price

	return minvalue


def buyingPoint (price):

	"""
	It gets the buying price and it saves it in the database
	"""

	buying_price = price

	# CODE to store the value in the database


def sellingPoint (price):

	"""
	It gets the selling price and it saves it in the database
	"""

	selling_price = price

	# CODE to store the value in the database





