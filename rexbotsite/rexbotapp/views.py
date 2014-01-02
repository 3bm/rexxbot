
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

from rexbotapp.models import MainTickerValue

import random
import time
import datetime

import radical_ex_lib

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