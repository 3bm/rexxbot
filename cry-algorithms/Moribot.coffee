###
Moribot EMA 7-20 
###


#@ema_previous Module by Ken
class Functions
  @ema_previous: (data, period) ->
    results = talib.EMA
      inReal: data
      startIdx: 0
      endIdx: data.length - 2
      optInTimePeriod: period
    _.last(results)   

init: (context) ->
#DON'T MESS w/ this part
#@ema_previous Module by Ken
    context.invested = null




#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# USER CONTROL PANEL
    
    # Buying Slope
    context.BUY_min  = -0.3   #-0.3 #Start buying at this slope   
    context.BUY_max  = 0.1    #0.1  #Stop buying at this slope
    
    #Selling Slope
    context.SELL_max = -0.3   #-0.3 #Start selling at this slope
    context.SELL_min = -0.6   #-0.6 #Stop selling at this slope
    
    
    context.EMA_L   = 7     #Order Limit EMA; EMA(2) for 2h
    context.EMA     = 20     #Slope EMA; EMA(5) for 2h
    
    # % above and below Limit EMA to buy and sell
    context.B_limit = 1.00      #1.002 for more consistant orders
    context.S_limit = 0.99      #0.998 for more consistant orders
 
    # Minimum balance and buy/sell quantities
    # may use "null" for any of these
    context.bal_min = null  # if balance < this; sell all market order
    context.B = null      # buy this many units per candle  
    context.S = null      # sell this many units per candle
    
    context.buy_sell_price = 0
    context.bought = true
# /USER CONTROL PANEL
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


# PERFORM EACH TICK    
handle: (context, data)->
    instrument = data.instruments[0]
    EMA_LAST = Functions.ema_previous(instrument.close,context.EMA)    
    EMA = instrument.ema(context.EMA)
    LIMIT = instrument.ema(context.EMA_L)
    SLOPE = EMA - EMA_LAST
    balance = portfolio.positions[instrument.asset()].amount
    Cbalance = portfolio.positions[instrument.curr()].amount
    
    price = instrument.price

    if context.buy_sell_price == 0
        context.buy_sell_price = price

    high_price = instrument.high[instrument.high.length-1] # Displays current High value
    low_price = instrument.low[instrument.low.length-1] # Displays current High value
    average_price = (high_price + low_price) / 2

    results = talib.AROON
        high: instrument.high
        low: instrument.low
        startIdx: 0
        endIdx: instrument.close.length-1
        optInTimePeriod:22
    aroon_up = _.last(results.outAroonUp)
    aroon_down = _.last(results.outAroonDown)
    # buy_sell_price = price
 # DRAW
    plot 
        EMA: EMA
        LIMIT: LIMIT
        price: instrument.price
        Average: average_price
        buy_sell_price : context.buy_sell_price
        
# LOGIC
    

    greediness = 5
    bought = context.bought
    buy_sell_price = context.buy_sell_price
    # debug 'HIGH: ' + instrument.high[instrument.high.length-1] # Displays current High value
    # debug 'LOW: ' + instrument.low[instrument.low.length-1] # Displays current High value
    #debug buy_sell_price - price
    #debug 'price' + price
    #debug 'buy_sell_price' + buy_sell_price 
    # if instrument.price < (buy_sell_price-greediness) and EMA < average_price
    #   if (buy instrument)
    #     context.bought = true
    #     context.buy_sell_price = instrument.price

    # if instrument.price > (buy_sell_price+greediness) and average_price < EMA
    #    if (sell instrument)
    #     context.bought = false
    #     context.buy_sell_price = instrument.price

    if bought == false and instrument.price > buy_sell_price
        buy instrument
        context.buy_sell_price = instrument.price
        context.bought = true

    if (LIMIT > EMA and average_price > EMA) and (instrument.price < (buy_sell_price-greediness))
       if (buy instrument)
            context.bought = true
            context.buy_sell_price = instrument.price

    else if (average_price < EMA and bought == true) and (instrument.price > (buy_sell_price+greediness))
        if (sell instrument)
            context.bought = false
            context.buy_sell_price = instrument.price

    # debug 'Average: ' + average_price
    # if average_price < EMA and bought == true
    #   sell(instrument)
    #   context.bought = false
    # if LIMIT > EMA and average_price > EMA
    #   buy(instrument)
    #   context.bought = true
      # if buy(instrument,context.B,(Math.round(context.B_limit*LIMIT*100))/100,179)
      #   debug 'Assets: ' + (Math.floor(balance*100)/100) + ' | ' + 'Currency: ' + (Math.floor(Cbalance*1000)/1000)+' |' + ' Buy : LIMIT:' + LIMIT + ' EMA: ' + EMA
    # if LIMIT < EMA
      # if sell(instrument,context.S,(Math.round(context.S_limit*LIMIT*100))/100,179)
      #    debug 'Assets: ' + (Math.floor(balance*1000)/1000) + ' | ' + 'Currency: ' + (Math.floor(Cbalance*1000)/1000)+' |' + ' Sell : LIMIT:' + LIMIT + ' EMA: ' + EMA

# 1-jan -> 27-jan
# 7-20  : 5.5 -> 6.16
# 6-20  : 5.5 -> 5.50
# 5-20  : 5.5 -> 5.65
# 4-20  : 5.5 -> 5.45
# 3-20  : 5.5 -> 5.22
# 2-20  : 5.5 -> 4.39
# 5-19  : 5.5 -> 5.73
# 6-19  : 5.5 -> 5.54
# 6-10  : 5.5 -> 4.94
# EMA with price
# 7-20+price  : 5.5 -> 6.16

# aroon - 5.87
# aroon - 70-50 -> 5.58