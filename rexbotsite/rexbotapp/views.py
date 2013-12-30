
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

import radical_ex_lib

def home(request):


	pair = "ltc_btc"

	asks, bids = getDepth(pair)

	print ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
	print len(asks), len(bids)

	tickerman = radical_ex_lib.getTicker(pair)
	
	pair_2 = "ppc_btc"
	ticker_2 = radical_ex_lib.getTicker(pair_2) 

	pair_3 = "nmc_btc"
	ticker_3 = radical_ex_lib.getTicker(pair_3)

	pair_4 = "qrk_btc"
	ticker_4 = radical_ex_lib.getTicker(pair_4)

	# ask = asks[0].replace("(Decimal('", "")

	USD_ticker = radical_ex_lib.getTickerfastUSD()
	EUR_ticker = radical_ex_lib.getTickerfastEUR()

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
				}

	return render(request, 'dashboard/index.html', context)


def charts(request):

	context = {}

	return render(request, 'dashboard/charts.html', context)