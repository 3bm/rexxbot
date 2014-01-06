# Copyright (c) 2014 Radical Graphics Studios

import decimal

import common

import datetime

import sys

from rexbotapp.models import MainTickerValue, MaxMinValue


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

    

def getTickerBTC_E_EUR(error_handler=None, connection=None):

    if connection is None:
        connection = common.BTC_EConnection()


    depth = common.validateResponseBTCE(connection.makeJSONRequest('/api/2/btc_eur/ticker', method='GET'),
                                    error_handler=error_handler)

    if error_handler is not None:
        print error_handler

    BTCEUR = depth.get(u'ticker')
    
    BTCEUR = BTCEUR.get(u'last')

    return BTCEUR


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


    ### We save also USD and EUR...
    ticker_eur = getTickerfastEUR()
    ticker_eur = ticker_eur.get(u'value')
    papor = MainTickerValue.objects.create(currency='EUR',time=datetime.datetime.utcnow(),value=ticker_eur)
    papor.save()

    ticker_usd = getTickerfastUSD()
    ticker_usd = ticker_usd.get(u'value')
    papor = MainTickerValue.objects.create(currency='USD',time=datetime.datetime.utcnow(),value=ticker_usd)    
    papor.save()

def updateTrends():

    cambio = False

    current_ticker_usd = getTickerfastUSD()
    current_ticker_eur = getTickerfastEUR()

    current_ticker_usd = current_ticker_usd.get(u'value')
    current_ticker_eur = current_ticker_eur.get(u'value')
    
    latest = MaxMinValue.objects.all().reverse()[0]

    if current_ticker_usd > latest.maximum_usd:

        latest.maximum_usd = current_ticker_usd
        cambio = True

    if current_ticker_usd < latest.minimum_usd:

        latest.minimum_usd = current_ticker_usd
        cambio = True


    if current_ticker_eur > latest.maximum_eur:

        latest.maximum_eur = current_ticker_eur
        cambio = True

    if current_ticker_eur < latest.minimum_eur:

        latest.minimum_eur = current_ticker_eur
        cambio = True


    if cambio:
        latest.time = datetime.datetime.utcnow()
        latest.save()


def getTrends():

    delta = datetime.timedelta(hours=1)
    primero = datetime.datetime.utcnow() - delta

    usdtrend = MainTickerValue.objects.filter(time__gt=primero, currency='USD')
    
    usdtrend_inicio = usdtrend[0].value

    usdtrend_final = usdtrend[len(usdtrend)-1].value
    
    variazzione = usdtrend_final - usdtrend_inicio

    percentual = variazzione * 100 / usdtrend_final

    perc_hour = percentual

    ### the same but for 24 hours

    delta = datetime.timedelta(hours=24)
    primero = datetime.datetime.utcnow() - delta

    usdtrend = MainTickerValue.objects.filter(time__gt=primero, currency='USD')
    
    usdtrend_inicio = usdtrend[0].value

    usdtrend_final = usdtrend[len(usdtrend)-1].value
    
    variazzione = usdtrend_final - usdtrend_inicio

    percentual = variazzione * 100 / usdtrend_final

    perc_day = percentual

    re_list = []

    re_list.append(perc_hour)
    re_list.append(perc_day)
    

    return re_list