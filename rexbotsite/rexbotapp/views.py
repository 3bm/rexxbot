
# ReXbot
# (c)2014 Radical Graphics Studios
# Made with effort in Amsterdam
#
from django.shortcuts import render, get_object_or_404, render_to_response

import sys
import simplejson

from public import getDepth, getTradeHistory
from trade import TradeAPI
from keyhandler import KeyHandler
from common import all_currencies, all_pairs, max_digits, formatCurrency, fees, formatCurrencyDigits, \
    truncateAmount, truncateAmountDigits, BTERConnection

import random
import time
import datetime

import radical_ex_lib
import logic
from rexbotapp.models import Percentages, Currency, MainTickerValue

def home(request):


	pair = "ltc_btc"

	asks, bids = getDepth(pair)

	#print ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
	#print len(asks), len(bids)

	tickerman = radical_ex_lib.getTicker(pair) #tuickerman is the one for LTC-BTC
	

	##### We save the value for the future

	papor = MainTickerValue.objects.create(currency='LTC',time=datetime.datetime.utcnow(),value=tickerman)
	papor.save()


	pair_2 = "ppc_btc"
	ticker_2 = radical_ex_lib.getTicker(pair_2) 

	pair_3 = "nmc_btc"
	ticker_3 = radical_ex_lib.getTicker(pair_3)

	pair_4 = "qrk_btc"
	ticker_4 = radical_ex_lib.getTicker(pair_4)

	# ask = asks[0].replace("(Decimal('", "")

	USD_ticker = radical_ex_lib.getTickerfastUSD()
	EUR_ticker = radical_ex_lib.getTickerfastEUR()



	### Pintando la grafica (que no rula bien de momento)
	nb_element = 25
	start_time = int(time.mktime(datetime.datetime(2014, 1, 1).timetuple()) * 1000)
	
	xdata = range(nb_element)
	
	xdata = map(lambda x: start_time + x * 1000000000, xdata)
	
	ydata = [i + random.randint(1, 2) for i in range(nb_element)]


	datos = MainTickerValue.objects.all();

	#time_list = []
	value_list = []

	for dat in datos:
	#	time_list.append(dat.time)
		value_list.append(dat.value * 100)

	#time_list = list(time_list)
	#time_list_json = simplejson.dumps(time_list)
	
	print value_list

	value_data = simplejson.dumps(value_list)

	print value_data
	ydata2 = map(lambda x: x * 2, ydata)

	#ydata2 = map(lambda x: x * 1, value_data)
	ydata3 = map(lambda x: x * 2, ydata)
	ydata4 = map(lambda x: x * 2, ydata)

	tooltip_date = "%d %b %Y %H:%M:%S %p"
	extra_serie = {"tooltip": {"y_start": "There are ", "y_end": " calls"},
	           "date_format": tooltip_date}

	chartdata = {
	'x': xdata,
	'name1': 'series 1', 'y1': ydata, 'extra1': extra_serie,
	'name2': 'series 2', 'y2': ydata2, 'extra2': extra_serie,
	'name3': 'series 3', 'y3': ydata3, 'extra3': extra_serie,
	'name4': 'series 4', 'y4': ydata4, 'extra4': extra_serie
	}
	charttype = "lineChart"
	chartcontainer = 'lineChart_container'  # container name


	context = {'asks': asks,
		   'bids': bids,
		   'ticker' : tickerman,
		   'ticker2' : ticker_2,
		   'ticker3' : ticker_3,
		   'ticker4' : ticker_4,
		   'pair' : pair,
		   'pair2' : pair_2,
		   'pair3' : pair_3,
		   'pair4' : pair_4,
		   'usdticker' : USD_ticker,
		   'eurticker' : EUR_ticker,
		   'charttype': charttype,
	        'chartdata': chartdata,
	        'chartcontainer': chartcontainer,
	        'extra': {
	            'x_is_date': True,
	            'x_axis_format': '%d %b %Y %H',
	            'tag_script_js': True,
	            'jquery_on_ready': True,
	}
			}

	return render(request, 'dashboard/index.html', context)


def charts(request):

	context = {}

	return render(request, 'dashboard/charts.html', context)


def piechart(request):
    xdata = ["Apple", "Apricot", "Avocado", "Banana", "Boysenberries", "Blueberries", "Dates", "Grapefruit", "Kiwi", "Lemon"]
    ydata = [52, 48, 160, 94, 75, 71, 490, 82, 46, 17]

    color_list = ['#5d8aa8', '#e32636', '#efdecd', '#ffbf00', '#ff033e', '#a4c639', '#b2beb5', '#8db600', '#7fffd4', '#ff007f', '#ff55a3', '#5f9ea0']
    extra_serie = {
        "tooltip": {"y_start": "", "y_end": " cal"},
        "color_list": color_list
    }
    chartdata = {'x': xdata, 'y1': ydata, 'extra1': extra_serie}
    charttype = "pieChart"
    chartcontainer = 'piechart_container'  # container name

    data = {
        'charttype': charttype,
        'chartdata': chartdata,
        'chartcontainer': chartcontainer,
        'extra': {
            'x_is_date': False,
            'x_axis_format': '',
            'tag_script_js': True,
            'jquery_on_ready': False,
        }
    }

    return render_to_response('dashboard/piechart.html', data)




def linechart(request):

    """
    linewithfocuschart page
    """
    nb_element = 100
    start_time = int(time.mktime(datetime.datetime(2012, 6, 1).timetuple()) * 1000)

    xdata = range(nb_element)
    xdata = map(lambda x: start_time + x * 1000000000, xdata)
    ydata = [i + random.randint(1, 10) for i in range(nb_element)]
    ydata2 = map(lambda x: x * 2, ydata)
    ydata3 = map(lambda x: x * 3, ydata)
    ydata4 = map(lambda x: x * 4, ydata)

    tooltip_date = "%d %b %Y %H:%M:%S %p"
    extra_serie = {"tooltip": {"y_start": "There are ", "y_end": " calls"},
                   "date_format": tooltip_date}

    chartdata = {
        'x': xdata,
        'name1': 'series 1', 'y1': ydata, 'extra1': extra_serie,
        'name2': 'series 2', 'y2': ydata2, 'extra2': extra_serie,
        'name3': 'series 3', 'y3': ydata3, 'extra3': extra_serie,
        'name4': 'series 4', 'y4': ydata4, 'extra4': extra_serie
    }
    charttype = "lineWithFocusChart"
    chartcontainer = 'linewithfocuschart_container'  # container name
    data = {
        'charttype': charttype,
        'chartdata': chartdata,
        'chartcontainer': chartcontainer,
        'extra': {
            'x_is_date': True,
            'x_axis_format': '%d %b %Y %H',
            'tag_script_js': True,
            'jquery_on_ready': True,
        }
    }

    return render_to_response('dashboard/linechart.html', data)

def rules_simulation(request):

	"""
	Function to apply the rules over an existing crytocurrency values database

	It needs a starting point (date and paid price)
	Then it has to go over the dates and read the value applying the rules
	"""

	# rateArray = Currency.objects.all().order_by('id')
	rateArray = MainTickerValue.objects.all().order_by('id')

	bought_price = 0.03131

	reference_price = bought_price
	html = "=============== <br>"
	html = html + "Starting Price: " + str(reference_price) + "<br>"

	bought = True
	sold = False

	max_value = reference_price
	min_value = reference_price

	for price in rateArray:

		# SI HA COMPRADO COMPRUEBA QUE TIENE QUE VENDER SI EL VALOR MAXIMO BAJA UN 3%
		# ===========================================================================
		if bought:
			html = html + "Miramos si hay que vender <br>"
			# Obtenemos el porcentaje del precio actual con el de compra (referencia)
			html = html + "Price: " + str(price.value) + "<br>"
			percentage = logic.getPercentage(reference_price, price.value)
			html = html + "Percentage: " + str(percentage) + "<br>"

			# Si el porcentaje actual es mas bajo (o igual) que la regla del 3% tiene que vender
			if percentage <= logic.getMinPercentage():
				# indicamos que hay que vender
				sell = True
				# comprobamos que ya hemos vendido antes o no
				vender = logic.checkToSell(sold, sell)
				# si vender es true hay que colocar la orden de venta
				if vender:
					html = html + "<span style:'color=#00FF00'>Sold: " + str(vender) + "--->" + str(price.value) + "</span><br>"
					# indicamos que hemos vendido
					sold = True
					bought = False
					# actualizamos el precio de referencia al de venta
					reference_price = price.value
					html = html + "Reference Price: " + str(reference_price) + "<br><br>"
					min_value = price.value
			# si el porcentage es positivo actualizamos el precio de referencia (ya que es mayor al actual)
			else:

				# Comprobamos el valor maximo, si el precio actual es mas grande se actualiza
				max_value = logic.checkMaxValue(max_value, price.value)
				html = html + "Max Value: " + str(max_value) + "<br><br>"
				reference_price = max_value

		else:
			html = html + "Miramos si hay que comprar <br>"
			html = html + "Reference Price: " + str(reference_price) + "<br>"
			# Obtenemos el porcentaje del precio actual con el de compra (referencia)
			html = html + "Price: " + str(price.value) + "<br>"
			percentage = logic.getPercentage(reference_price, price.value)
			html = html + "Percentage: " + str(percentage) + "<br>"

			# Si el porcentaje actual es mas alto (o igual) que la regla del 3% tiene que comprar
			if percentage >= logic.getMaxPercentage():
				# indicamos que hay que comprar
				buy = True
				# comprobamos que ya hemos comprado antes o no
				comprar = logic.checkToBuy(bought, buy)
				# si comprar es true hay que colocar la orden de compra
				if comprar:
					html = html + "Bought: " + str(comprar) + "--->" + str(price.value) + "<br><br>"
					# indicamos que hemos comprado
					bought = True
					sold = False
					# actualizamos el precio de referencia al de venta
					reference_price = price.value
			# si el porcentage es negativo actualizamos el precio de referencia (ya que es menor al actual)
			else:

				# Comprobamos el valor minimo, si el precio actual es mas bajo se actualiza
				min_value = logic.checkMinValue(min_value, price.value)
				html = html + "Min Value: " + str(min_value) + "<br><br>"
				reference_price = min_value
				max_value = price.value


	pair = "ltc_btc"

	tickerman = radical_ex_lib.getTicker(pair) #tuickerman is the one for LTC-BTC
	
	##### We save the value for the future

	papor = MainTickerValue.objects.create(currency='LTC',time=datetime.datetime.utcnow(),value=tickerman)
	papor.save()

	context = {'html': html}

	return render(request, 'dashboard/simulation.html', context)



			# negative_percentage = logic.getPercentage(max_value, price.value)
			# positive_percentage = logic.getPercentage(min_value, price.value)
			# buy, sell = logic.checkBuyOrSellPercent (reference_price, price.value)
			# print "Buy: " + str(buy)
			# print "Sell: " + str(sell) + "\n"
			# print "Bought value: " + str(bought) + "<<<<<<"


			# if positive_percentage >= logic.getMaxPercentage():
			# 	buy = True
			# 	comprar = logic.checkToBuy(bought, buy)
			# 	if comprar:
			# 		print "Comprar: " + str(comprar) + "---> " + str(reference_price)
			# 		reference_price = price.value

		# 	if negative_percentage <= logic.getMinPercentage():
		# 		sell = True
		# 		vender = logic.checkToSell(sold, sell)
		# 		if vender:
		# 			print "Sold: " + str(vender) + "--->" + str(price.value) + "\n"
		# 			sold = True
		# 			reference_price = price.value



	
		# # Comprobamos el valor minimo, si el precio actual es mas bajo se actualiza
		# min_value = logic.checkMinValue(min_value, price.value)
		# print "Min Value: " + str(min_value) + "\n"



		# print "reference_price: " + str(reference_price) + "\n"

		# if sold:
		# 	reference_price = min_value

	



