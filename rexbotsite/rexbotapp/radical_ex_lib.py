# Copyright (c) 2014 Radical Graphics Studios

import decimal

import common

import datetime

import sys

from rexbotapp.models import MainTickerValue


def getTicker(pair, connection=None, error_handler=None):
    """
    Retrieve the ticker
    """
    common.validatePair(pair)
    
    if connection is None:
        connection = common.BTERConnection()
    
    depth = common.validateResponse(connection.makeJSONRequest('/api/1/ticker/%s' % pair, method='GET'),
                                    error_handler=error_handler)
    

    buy = depth.get(u'buy')


    # asks = depth.get(u'asks')
    # if type(asks) is not list:
    #     raise Exception("The response does not contain an asks list.")
        
    # bids = depth.get(u'bids') 
    # if type(bids) is not list:
    #     raise Exception("The response does not contain a bids list.")

    # if len(asks) > 0:
    #     ask_prices, ask_sizes = zip(*asks)
    #     ask_prices = [decimal.Decimal(p) for p in ask_prices]
    #     ask_sizes = [decimal.Decimal(s) for s in ask_sizes]
    #     asks = zip(ask_prices, ask_sizes)
    # else:
    #     asks = []
    # if len(bids) > 0:
    #     bid_prices, bid_sizes = zip(*bids)
    #     bid_prices = [decimal.Decimal(p) for p in bid_prices]
    #     bid_sizes = [decimal.Decimal(s) for s in bid_sizes]
    #     bids = zip(bid_prices, bid_sizes)
    # else:
    #     bids = []
    
    return buy


def getHistory(pair, connection=None, error_handler=None):
    """
    Retrieve the last 80 trade history for the given pair (oon BTER)
    """

    common.validatePair(pair)

    if connection is None:
        connection = common.BTERConnection()

    depth = common.validateResponse(connection.makeJSONRequest('/api/1/trade/%s' % pair, method='GET'),
                                    error_handler=error_handler)

    if error_handler is not None:
        print "ERROR: " + error_handler

    



def getTickerfastUSD(error_handler=None, connection=None):
	
	if connection is None:
		connection = common.MTGOXConnection()


	depth = common.validateResponse(connection.makeJSONRequest('/api/1/BTCUSD/ticker_fast', method='GET'),
                                    error_handler=error_handler)

	if error_handler is not None:
		print "ERROR: " + error_handler

	BTCUSD = depth.get(u'return')

	BTCUSD = BTCUSD.get(u'last')

	return BTCUSD


def getTickerfastEUR(error_handler=None, connection=None):

	if connection is None:
		connection = common.MTGOXConnection()


	depth = common.validateResponse(connection.makeJSONRequest('/api/1/BTCEUR/ticker_fast', method='GET'),
                                    error_handler=error_handler)

	if error_handler is not None:
		print error_handler

	BTCEUR = depth.get(u'return')

	BTCEUR = BTCEUR.get(u'last')

	return BTCEUR

def saveCurrencies():

    CURR = [
        ['LTC', 'ltc_btc'],
        ['PPC', 'ppc_btc'],
        ['NMC', 'nmc_btc'],
        ['QRK', 'qrk_btc'],
        ]

    for pair in CURR:


        #print pair[1]
        #sys.exit()

        ticker = getTicker(pair[1])

        papor = MainTickerValue.objects.create(currency=pair[0],time=datetime.datetime.utcnow(),value=ticker)
        papor.save()

