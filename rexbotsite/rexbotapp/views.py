
# ReXbot
# (c)2014 Radical Graphics Studios
# Made with effort in Amsterdam
#
from django.shortcuts import render, get_object_or_404, render_to_response

import sys

from public import getDepth, getTradeHistory
from trade import TradeAPI
from keyhandler import KeyHandler
from common import all_currencies, all_pairs, max_digits, formatCurrency, fees, formatCurrencyDigits, \
    truncateAmount, truncateAmountDigits, BTERConnection


def home(request):


	pair = "ltc_btc"

	asks, bids = getDepth(pair)

	print ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
	print len(asks), len(bids)

	

	# ask = asks[0].replace("(Decimal('", "")


	# print ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
	# print ask 

	context = {'asks': asks,
			   'bids': bids
				}

	return render(request, 'dashboard/index.html', context)


def charts(request):

	context = {}

	return render(request, 'dashboard/charts.html', context)