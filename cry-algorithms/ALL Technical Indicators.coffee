###########################################################  
#
# Thanasis      ALL INDICATORS    CODING
#
# Full name:    Thanasis Efthymiou
#
# BTC:          1CRSH4LGGRWVWqgwfquky2Rk5eJK6gsyus
#
# e-mail:       cryptotrader.thanasis@gmail.com
#
###########################################################

class Init

  @init_context: (context) ->
      
    context.lag		        = 1
    context.period		    = 10
    context.NbDevUp         = 2
    context.NbDevDn         = 2
    context.FastPeriod  	= 5
    context.SlowPeriod  	= 10
    context.MAType		    = 1
    context.SignalPeriod	= 5
    context.FastMAType	    = 1
    context.SlowMAType	    = 1
    context.SignalMAType	= 1
    context.FastLimitPeriod	= 5
    context.SlowLimitPeriod = 10
    context.periods         = 10
    context.MinPeriod	    = 5
    context.MaxPeriod	    = 10
    context.StartValue	    = 0
    context.OffsetOnReverse	= 0
    context.accel           = 0.02
    context.accelmax        = 0.20
    context.AccelerationInitLong	= 0.02
    context.AccelerationLong	    = 0.02
    context.AccelerationMaxLong	    = 2.00
    context.AccelerationInitShort	= 0.02
    context.AccelerationShort	    = 0.02
    context.AccelerationMaxShort	= 2.00
    context.fastK_period	= 5
    context.slowK_period	= 10
    context.slowK_MAType	= 1
    context.slowD_period	= 10
    context.slowD_MAType	= 1
    context.fastD_period	= 5
    context.fastD_MAType	= 1
    context.vfactor		    = 1
    context.Period1        = 5
    context.Period2        = 10
    context.Period3        = 20
    context.NbDev           = 1
    context.NbVar		    = 1





###########################################################

class Functions
 
  @diff: (x, y) ->
    ((x - y) / ((x + y) / 2)) * 100
    
  @percent: (x,y) ->
    ((x-y)/y) * 100

 
  

  @accbands: (high, low, close, lag, period) ->
    results = talib.ACCBANDS
      high: high
      low: low
      close: close
      startIdx: 0
      endIdx: high.length - lag
      optInTimePeriod: period
    result =
      UpperBand: _.last(results.outRealUpperBand)
      MiddleBand: _.last(results.outRealMiddleBand)
      LowerBand: _.last(results.outRealLowerBand)
    result
    
  @ad: (high,low,close,volume,lag,period) ->
   	results = talib.AD
   	    high: high
   	    low: low
   	    close: close
   	    volume: volume
   	    startIdx: 0
   	    endIdx: high.length - lag
   	    optInTimePeriod: period
   	_.last(results)  

  @adosc: (high, low, close, volume,lag,FastPeriod,SlowPeriod) ->
    results = talib.ADOSC
      high: high
      low: low
      close: close
      volume: volume
      startIdx: 0
      endIdx: high.length - lag
      optInFastPeriod: FastPeriod
      optInSlowPeriod: SlowPeriod
    _.last(results)
  
  @adx: (high, low, close, lag, period) ->
    results = talib.ADX
      high: high
      low: low
      close: close
      startIdx: 0
      endIdx: high.length - lag
      optInTimePeriod: period
     _.last(results)
     
  @adxr: (high,low,close,lag,period) ->
    results = talib.ADXR
        high: high
        low: low
        close: close
        startIdx: 0
        endIdx: high.length - lag
        optInTimePeriod: period
     _.last(results)
     
  @apo: (data, lag, FastPeriod, SlowPeriod, MAType) ->
    results = talib.APO
      inReal: data
      startIdx: 0
      endIdx: data.length - lag
      optInFastPeriod: FastPeriod
      optInSlowPeriod: SlowPeriod
      optInMAType: MAType
    _.last(results)   
     
  @aroon: (high, low, lag, period) ->
    results = talib.AROON
      high: high
      low: low
      startIdx: 0
      endIdx: high.length - lag
      optInTimePeriod: period
    result =
      up: _.last(results.outAroonUp)
      down: _.last(results.outAroonDown)
    result
    
  @aroonosc: (high, low, lag, period) ->
    results = talib.AROONOSC
        high: high
        low: low
        startIdx: 0
        endIdx: high.length - lag
        optInTimePeriod: period
     _.last(results)
     
  @atr: (high, low, close, lag, period) ->
    results = talib.ATR
      high: high
      low: low
      close: close
      startIdx: 0
      endIdx: high.length - lag
      optInTimePeriod: period
     _.last(results)
  
  @avgprice: (open,high,low,close,lag,period) ->
   	results = talib.AVGPRICE
        open: open
        high: high
        low: low
        close: close
        startIdx: 0
        endIdx: open.length - lag
        optInTimePeriod: period
     _.last(results)
     
  @bbands: (data, period, lag, NbDevUp, NbDevDn,MAType) ->
    results = talib.BBANDS
      inReal: data
      startIdx: 0
      endIdx: data.length - lag
      optInTimePeriod: period
      optInNbDevUp: NbDevUp
      optInNbDevDn: NbDevDn
      optInMAType: MAType
    result =
      UpperBand: _.last(results.outRealUpperBand)
      MiddleBand: _.last(results.outRealMiddleBand)
      LowerBand: _.last(results.outRealLowerBand)
    result
  
  @beta: (data_0,data_1,lag,period) ->
    results = talib.BETA
        inReal0: data_0
        inReal1: data_1
        startIdx: 0
        endIdx: data_0.length - lag
        optInTimePeriod: period
     _.last(results)
  
  @bop: (open, high, low, close, lag) ->
    results = talib.BOP
      open: open
      high: high
      low: low
      close: close
      startIdx: 0
      endIdx: high.length - lag
     _.last(results)

  @cci: (high, low, close, lag, period) ->
    results = talib.CCI
      high: high
      low: low
      close: close
      startIdx: 0
      endIdx: high.length - lag
      optInTimePeriod: period
     _.last(results)
  
  @cmo: (data,lag, period) ->
    results = talib.CMO
      inReal: data
      startIdx: 0
      endIdx: data.length - lag
      optInTimePeriod: period
    _.last(results) 
  
  @correl: (data_0, data_1, lag, period) ->
    results = talib.CORREL
      inReal0: data_0
      inReal1: data_1
      startIdx: 0
      endIdx: data_0.length - lag
      optInTimePeriod: period
    _.last(results) 
   
  @dema: (data, lag, period) ->
    results = talib.DEMA
      inReal: data
      startIdx: 0
      endIdx: data.length - lag
      optInTimePeriod: period
    _.last(results)
    
  @dx: (high, low, close, lag, period) ->
    results = talib.DX
      high: high
      low: low
      close: close
      startIdx: 0
      endIdx: high.length - lag
      optInTimePeriod: period
     _.last(results)
  
  @ema: (data, lag, period) ->
    results = talib.EMA
      inReal: data
      startIdx: 0
      endIdx: data.length - lag
      optInTimePeriod: period
    _.last(results)
 
  @ht_dcperiod: (data,lag) ->
    results = talib.HT_DCPERIOD
      inReal: data
      startIdx: 0
      endIdx: data.length - lag
    _.last(results)
    
  @ht_dcphase: (data,lag) ->
    results = talib.HT_DCPHASE
      inReal: data
      startIdx: 0
      endIdx: data.length - lag
    _.last(results)
    
  @ht_phasor: (data,lag) ->
   	results = talib.HT_PHASOR
      inReal: data
      startIdx: 0
      endIdx: data.length - lag
    result =
      phase: _.last(results.outInPhase)
      quadrature: _.last(results.outQuadrature)
    result

  @ht_sine: (data,lag) ->
    results = talib.HT_SINE
      inReal: data
      startIdx: 0
      endIdx: data.length - lag
    _.last(results)   
    result =
      sine: _.last(results.outSine)
      leadsine: _.last(results.outLeadSine)
    result
  
   @ht_trendline: (data,lag) ->
    results = talib.HT_TRENDLINE
      inReal: data
      startIdx: 0
      endIdx: data.length - lag
    _.last(results) 

  @ht_trendmode: (data,lag) ->
    results = talib.HT_TRENDMODE
      inReal: data
      startIdx: 0
      endIdx: data.length - lag
    _.last(results)
 
  @imi: (high, close, lag, period) ->
    results = talib.IMI
      open: open
      close: close
      startIdx: 0
      endIdx: open.length - lag
      optInTimePeriod: period
     _.last(results)
 
  @kama: (data, lag, period) ->
    results = talib.KAMA
      inReal: data
      startIdx: 0
      endIdx: data.length - lag
      optInTimePeriod: period
    _.last(results)
 
  @linearreg: (data, lag, period) ->
    results = talib.LINEARREG
      inReal : data
      startIdx: 0
      endIdx: data.length-lag
      optInTimePeriod:period
    _.last(results)

  @linearreg_angle: (data, lag, period) ->
    results = talib.LINEARREG_ANGLE
      inReal : data
      startIdx: 0
      endIdx: data.length-lag
      optInTimePeriod:period
    _.last(results)


  @linearreg_intercept: (data, lag, period) ->
    results = talib.LINEARREG_INTERCEPT
      inReal : data
      startIdx: 0
      endIdx: data.length-lag
      optInTimePeriod:period
    _.last(results)
 
  @linearreg_slope: (data, lag, period) ->
    results = talib.LINEARREG_SLOPE
      inReal : data
      startIdx: 0
      endIdx: data.length-lag
      optInTimePeriod:period
    _.last(results)
    
 
  @ma: (data, lag, period,MAType) ->
    results = talib.MA
      inReal: data
      startIdx: 0
      endIdx: data.length - lag
      optInTimePeriod: period
      optInMAType: MAType
    _.last(results)

  
  @macd: (data, lag, FastPeriod,SlowPeriod,SignalPeriod) ->
    results = talib.MACD
     inReal: data
     startIdx: 0
     endIdx: data.length - lag
     optInFastPeriod: FastPeriod
     optInSlowPeriod: SlowPeriod
     optInSignalPeriod: SignalPeriod
    result =
      macd: _.last(results.outMACD)
      signal: _.last(results.outMACDSignal)
      histogram: _.last(results.outMACDHist)
    result
 
 
  @macdext: (data, lag, FastPeriod,FastMAType, SlowPeriod,SlowMAType, SignalPeriod,SignalMAType) ->
    results = talib.MACDEXT
     inReal: data
     startIdx: 0
     endIdx: data.length - lag
     optInFastPeriod: FastPeriod
     optInFastMAType: FastMAType
     optInSlowPeriod: SlowPeriod
     optInSlowMAType: SlowMAType
     optInSignalPeriod: SignalPeriod
     optInSignalMAType: SignalMAType
    result =
      macd: _.last(results.outMACD)
      signal: _.last(results.outMACDSignal)
      histogram: _.last(results.outMACDHist)
    result
 
  @macdfix: (data,lag, SignalPeriod) ->
    results = talib.MACDFIX
     inReal: data
     startIdx: 0
     endIdx: data.length - lag
     optInSignalPeriod: SignalPeriod
    result =
      macd: _.last(results.outMACD)
      signal: _.last(results.outMACDSignal)
      histogram: _.last(results.outMACDHist)
    result

  @mama: (data, lag, FastLimitPeriod, SlowLimitPeriod) ->
    results = talib.MAMA
      inReal: data
      startIdx: 0
      endIdx: data.length - lag
      optInFastLimit: FastLimitPeriod
      optInSlowLimit: SlowLimitPeriod
    result =
      mama: _.last(results.outMAMA)
      fama: _.last(results.outFAMA)
    result   

  @mavp: (data,periods, lag,MinPeriod,MaxPeriod, MAType) ->
    results = talib.MAVP
      inReal: data
      inPeriods: periods
      startIdx: 0
      endIdx: data.length - lag
      optInMinPeriod: MinPeriod
      optInMaxPeriod: MaxPeriod
      optInMAType: MAType
     _.last(results)
    	
  @max: (data, lag,period) ->
    results = talib.MAX
      inReal: data
      startIdx: 0
      endIdx: data.length - lag
      optInTimePeriod: period
    _.last(results) 
  
  @maxindex: (data, lag,period) ->
    results = talib.MAXINDEX
      inReal: data
      startIdx: 0
      endIdx: data.length - lag
      optInTimePeriod: period
    _.last(results)
    
  
  @medprice: (high,low,lag,period) ->
    results = talib.MEDPRICE
      high: high
      low: low
      startIdx: 0
      endIdx: high.length - lag
      optInTimePeriod: period
    _.last(results)
  
  @mfi: (high, low, close, volume,lag, period) ->
    results = talib.MFI
      high: high
      low: low
      close: close
      volume: volume
      startIdx: 0
      endIdx: high.length - lag
      optInTimePeriod: period
    _.last(results)
   
  @midpoint: (data,lag,period) ->
    results = talib.MIDPOINT
      inReal: data
      startIdx: 0
      endIdx: data.length - lag
      optInTimePeriod: period
    _.last(results)  
  
  @midprice: (high, low, lag, period) ->
    results = talib.MIDPRICE
      high: high
      low: low
      startIdx: 0
      endIdx: high.length - lag
      optInTimePeriod: period
    _.last(results) 

  @min: (data, lag,period) ->
    results = talib.MIN
      inReal: data
      startIdx: 0
      endIdx: data.length - lag
      optInTimePeriod: period
    _.last(results)

  @minindex: (data, lag,period) ->
    results = talib.MININDEX
      inReal: data
      startIdx: 0
      endIdx: data.length - lag
      optInTimePeriod: period
    _.last(results)
    
  @minmax: (data,lag,period) ->
    results = talib.MINMAX
      inReal: data
      startIdx: 0
      endIdx: data.length - lag
      optInTimePeriod: period
    result =
      min: _.last(results.outMin)
      max: _.last(results.outMax)
    result  
  
   @minmaxindex: (data, lag,period) ->
    results = talib.MINMAXINDEX
      inReal: data
      startIdx: 0
      endIdx: data.length - lag
      optInTimePeriod: period
    result =
      min: _.last(results.outMinIdx)
      max: _.last(results.outMaxIdx)
    result
   
    
  @minus_di: (high, low, close, lag, period) ->
    results = talib.MINUS_DI
      high: high
      low: low
      close: close
      startIdx: 0
      endIdx: high.length - lag
      optInTimePeriod: period
     _.last(results)
     
  @minus_dm: (high, low, lag, period) ->
    results = talib.MINUS_DM
      high: high
      low: low
      startIdx: 0
      endIdx: high.length - lag
      optInTimePeriod: period
     _.last(results)
     
  @mom: (data,lag, period) ->
    results = talib.MOM
      inReal: data
      startIdx: 0
      endIdx: data.length - lag
      optInTimePeriod: period
    _.last(results)
    
  @natr: (high, low, close, lag, period) ->
    results = talib.NATR
      high: high
      low: low
      close: close
      startIdx: 0
      endIdx: high.length - lag
      optInTimePeriod: period
     _.last(results)  
  
  @obv: (data,volume,lag) ->
    results = talib.OBV
      inReal: data
      volume: volume
      startIdx: 0
      endIdx: data.length - lag
     _.last(results)  
     
  @plus_di: (high, low, close,lag, period) ->
    results = talib.PLUS_DI
      high: high
      low: low
      close: close
      startIdx: 0
      endIdx: high.length - lag
      optInTimePeriod: period
     _.last(results)
  
  @plus_dm: (high, low, lag, period) ->
    results = talib.PLUS_DM
      high: high
      low: low
      startIdx: 0
      endIdx: high.length - lag
      optInTimePeriod: period
     _.last(results)   
  
  @ppo: (data, lag, FastPeriod, SlowPeriod, MAType) ->
    results = talib.PPO
      inReal: data
      startIdx: 0
      endIdx: data.length - lag
      optInFastPeriod: FastPeriod
      optInSlowPeriod: SlowPeriod
      optInMAType: MAType
    _.last(results)  
  
  @roc: (data, lag, period) ->
    results = talib.ROC
      inReal: data
      startIdx: 0
      endIdx: data.length - lag
      optInTimePeriod: period
    _.last(results) 
  
  @rocp: (data, lag, period) ->
    results = talib.ROCP
      inReal: data
      startIdx: 0
      endIdx: data.length - lag
      optInTimePeriod: period
    _.last(results) 
  
  @rocr: (data, lag, period) ->
    results = talib.ROCR
      inReal: data
      startIdx: 0
      endIdx: data.length - lag
      optInTimePeriod: period
    _.last(results) 
  
  @rocr100: (data, lag, period) ->
    results = talib.ROCR100
      inReal: data
      startIdx: 0
      endIdx: data.length - lag
      optInTimePeriod: period
    _.last(results) 
  
  @rsi: (data, lag, period) ->
    results = talib.RSI
      inReal: data
      startIdx: 0
      endIdx: data.length - lag
      optInTimePeriod: period
    _.last(results) 
    
  @sar: (high, low, lag, accel, accelmax) ->
    results = talib.SAR
      high: high
      low: low
      startIdx: 0
      endIdx: high.length - lag
      optInAcceleration: accel
      optInMaximum: accelmax
    _.last(results) 
  
  @sarext: (high,low,lag,StartValue, OffsetOnReverse, AccelerationInitLong,AccelerationLong,AccelerationMaxLong,AccelerationInitShort, AccelerationShort, AccelerationMaxShort) ->
    results = talib.SAREXT
      high: high
      low: low
      startIdx: 0
      endIdx: high.length - lag
      optInStartValue: StartValue
      optInOffsetOnReverse: OffsetOnReverse
      optInAccelerationInitLong: AccelerationInitLong
      optInAccelerationLong: AccelerationLong
      optInAccelerationMaxLong: AccelerationMaxLong
      optInAccelerationInitShort: AccelerationInitShort
      optInAccelerationShort: AccelerationShort
      optInAccelerationMaxShort: AccelerationMaxShort
    _.last(results)   
  
  @sma: (data, lag, period) ->
    results = talib.SMA
      inReal: data
      startIdx: 0
      endIdx: data.length - lag
      optInTimePeriod: period
    _.last(results) 
    
    
  @stddev: (data,  lag, period,NbDev) ->
    results = talib.STDDEV
      inReal: data
      startIdx: 0
      endIdx: data.length - lag
      optInTimePeriod: period
      optInNbDev: NbDev
    _.last(results)
    
  @stoch: (high,low,close,lag,fastK_period,slowK_period, slowK_MAType,slowD_period,slowD_MAType) ->
    results = talib.STOCH
      high: high
      low: low
      close: close
      startIdx: 0
      endIdx: high.length - lag
      optInFastK_Period: fastK_period
      optInSlowK_Period: slowK_period
      optInSlowK_MAType: slowK_MAType	
      optInSlowD_Period: slowD_period
      optInSlowD_MAType: slowD_MAType
    result =
      K: _.last(results.outSlowK)
      D: _.last(results.outSlowD)
    result  

  @stochf: (high, low, close, lag, fastK_period,fastD_period,fastD_MAType) ->
    results = talib.STOCHF
      high: high
      low: low
      close: close
      startIdx: 0
      endIdx: high.length - lag
      optInFastK_Period: fastK_period
      optInFastD_Period: fastD_period
      optInFastD_MAType: fastD_MAType
    result =
      K: _.last(results.outFastK)
      D: _.last(results.outFastD)
    result
  
  @stochrsi: (data, lag, period, fastK_period,fastD_period,fastD_MAType) ->
    results = talib.STOCHRSI
      inReal: data
      startIdx: 0
      endIdx: data.length - lag
      optInTimePeriod: period
      optInFastK_Period: fastK_period
      optInFastD_Period: fastD_period
      optInFastD_MAType: fastD_MAType
    result =
      K: _.last(results.outFastK)
      D: _.last(results.outFastD)
    result
  
  @sum: (data, lag, period) ->
    results = talib.SUM
      inReal: data
      startIdx: 0
      endIdx: data.length - lag
      optInTimePeriod: period
    _.last(results)
  
  @t3: (data, lag, period,vfactor ) ->
    results = talib.T3
      inReal: data
      startIdx: 0
      endIdx: data.length - lag
      optInTimePeriod: period
      optInVFactor: vfactor
    _.last(results)
    
  @tema: (data, lag, period) ->
    results = talib.TEMA
      inReal: data
      startIdx: 0
      endIdx: data.length - lag
      optInTimePeriod: period
    _.last(results)
 
  @trange: (high, low, close,lag, period) ->
    results = talib.TRANGE
      high: high
      low: low
      close: close
      startIdx: 0
      endIdx: high.length - lag
      optInTimePeriod: period
     _.last(results)  
  
  @trima: (data, lag, period) ->
    results = talib.TRIMA
      inReal: data
      startIdx: 0
      endIdx: data.length - lag
      optInTimePeriod: period
    _.last(results)
    
  @trix: (data, lag, period) ->
    results = talib.TRIX
      inReal: data
      startIdx: 0
      endIdx: data.length - lag
      optInTimePeriod: period
    _.last(results)  
    
  @tsf: (data,  lag, period) ->
    results = talib.TSF
      inReal: data
      startIdx: 0
      endIdx: data.length - lag
      optInTimePeriod: period
    _.last(results)
    
  @typprice: (high, low, close, lag, period) ->
    results = talib.TYPPRICE
      high: high
      low: low
      close: close
      startIdx: 0
      endIdx: high.length - lag
      optInTimePeriod: period
     _.last(results)
     
  @ultosc: (high, low, close, lag, Period1,Period2,Period3) ->
    results = talib.ULTOSC
      high: high
      low: low
      close: close
      startIdx: 0
      endIdx: high.length - lag
      optInTimePeriod1: Period1
      optInTimePeriod2: Period2
      optInTimePeriod3: Period3
    _.last(results) 
  
  @variance: (data,  lag, period,NbVar) ->
    results = talib.VAR
      inReal: data
      startIdx: 0
      endIdx: data.length - lag
      optInTimePeriod: period
      optInNbDev: NbVar
    _.last(results)   
  
  @wclprice: (high, low, close, lag, period) ->
    results = talib.WCLPRICE
      high: high
      low: low
      close: close
      startIdx: 0
      endIdx: high.length - lag
      optInTimePeriod: period
     _.last(results)
     
  @willr: (high, low, close, lag, period) ->
    results = talib.WILLR
      high: high
      low: low
      close: close
      startIdx: 0
      endIdx: high.length - lag
      optInTimePeriod: period
     _.last(results) 
     
  @wma: (data, lag, period) ->
    results = talib.WMA
      inReal: data
      startIdx: 0
      endIdx: data.length - lag
      optInTimePeriod: period
    _.last(results)
    
  
init: (context) ->
  Init.init_context(context)

handle: (context, data)->
    instrument = data.instruments[0]

    #ad = Functions.ad(instrument.high,instrument.low,instrument.close,instrument.volumes,context.lag,context.period)
    #accbands= Functions.accbands(instrument.high, instrument.low, instrument.close, context.lag, context.period)
    #adosc = Functions.adosc(instrument.high, instrument.low, instrument.close, instrument.volumes,context.lag,context.FastPeriod,context.SlowPeriod)    
    #adx = Functions.adx(instrument.high, instrument.low, instrument.close,context.lag, context.period) 
    #adxr = Functions.adxr(instrument.high,instrument.low,instrument.close,context.lag,context.period) 
    #apo = Functions.apo(instrument.close,context.lag,context.FastPeriod,context.SlowPeriod,context.MAType)
    #aroon = Functions.aroon(instrument.high, instrument.low,context.lag,context.period)    
    #aroonosc = Functions.aroonosc(instrument.high,instrument.low,context.lag,context.period) 
    #atr = Functions.atr(instrument.high, instrument.low, instrument.close, context.lag, context.period) 
    #avgprice = Functions.avgprice(instrument.open,instrument.high,instrument.low,instrument.close,context.lag,context.period)
    #bbands =  Functions.bbands(instrument.close, context.period, context.lag, context.NbDevUp, context.NbDevDn,context.MAType) 
    #beta =  Functions.beta(instrument.high,instrument.low,context.lag,context.period) 
    #bop = Functions.bop(instrument.open,instrument.high,instrument.low,instrument.close,context.lag)
    #cci = Functions.cci(instrument.high, instrument.low, instrument.close, context.lag,context.period) 
    #cmo = Functions.cmo(instrument.close,context.lag, context.period) 
    #correl = Functions.correl(instrument.high, instrument.low, context.lag, context.period)     
    #dema = Functions.dema(instrument.close,context.lag,context.period) 
    #dx = Functions.dx(instrument.high,instrument.low,instrument.close,context.lag,context.period) 
    #ema  = Functions.ema(instrument.close,context.lag,context.period)
    #ht_dcperiod = Functions.ht_dcperiod(instrument.close,context.lag)
    #ht_dcphase = Functions.ht_dcphase(instrument.close,context.lag) 
    #ht_phasor = Functions.ht_phasor(instrument.close,context.lag) 
    #ht_sine = Functions.ht_sine(instrument.close,context.lag)
    #ht_trendline= Functions.ht_trendline(instrument.close,context.lag)
    #ht_trendmode = Functions.ht_trendmode(instrument.close,context.lag)
    #imi = Functions.imi(instrument.open,instrument.close,context.lag,context.period) 
    #kama = Functions.kama(instrument.close,context.lag,context.period) 
    #linearreg = Functions.linearreg(instrument.close,context.lag,context.period) 
    #linearreg_angle = Functions.linearreg_angle(instrument.close,context.lag,context.period) 
    #linearreg_intercept = Functions.linearreg_intercept(instrument.close,context.lag,context.period) 
    #linearreg_slope = Functions.linearreg_slope(instrument.close,context.lag,context.period)
    #ma = Functions.ma(instrument.close,context.lag,context.period,context.MAType) 
    #macd = Functions.macd(instrument.close, context.lag, context.FastPeriod,context.SlowPeriod,context.SignalPeriod)
    #macdext = Functions.macdext(instrument.close, context.lag, context.FastPeriod,context.FastMAType, context.SlowPeriod,context.SlowMAType, context.SignalPeriod,context.SignalMAType) 
    #macdfix = Functions.macdfix(instrument.close,context.lag,context.SignalPeriod) 
    #mama = Functions.mama(instrument.close,context.lag,context.FastLimitPeriod,context.SlowLimitPeriod) 
    #mavp= Functions.mavp(instrument.close,context.periods,context.lag,context.MinPeriod,context.MaxPeriod, context.MAType) 
    #max_high = Functions.max(instrument.high, context.lag,context.period)
    #max_high = Functions.max(instrument.high, context.lag,context.period)
    #maxindex = Functions.maxindex(instrument.close,context.lag,context.period) 
    #medprice = Functions.medprice(instrument.high,instrument.low,context.lag,context.period) 
    #mfi = Functions.mfi(instrument.high, instrument.low, instrument.close, instrument.volumes, context.lag,context.period) 
    #midpoint = Functions.midpoint(instrument.close,context.lag,context.period) 
    #midprice = Functions.midprice(instrument.high, instrument.low,context.lag, context.period) 
    #min_low = Functions.min(instrument.low, context.lag,context.period)
    #minindex = Functions.minindex(instrument.close,context.lag,context.period) 
    #minmax = Functions.minmax(instrument.close,context.lag,context.period) 
    #minmaxindex = Functions.minmaxindex(instrument.close,context.lag,context.period) 
    #minus_di = Functions.minus_di(instrument.high, instrument.low, instrument.close, context.lag, context.period)    
    #minus_dm = Functions.minus_dm(instrument.high,instrument.low,context.lag,context.period)
    #mom = Functions.mom(instrument.close,context.lag,context.period) 
    #natr = Functions.natr(instrument.high,instrument.low,instrument.close,context.lag,context.period) 
    #obv = Functions.obv(instrument.close,instrument.volumes,context.lag)
    #plus_di = Functions. plus_di(instrument.high, instrument.low, instrument.close,context.lag, context.period) 
    #plus_dm = Functions.plus_dm(instrument.high,instrument.low,context.lag,context.period) 
    #ppo = Functions.ppo(instrument.close, context.lag, context.FastPeriod,context.SlowPeriod,context.MAType)
    #roc  = Functions.roc(instrument.close,context.lag,context.period)
    #rocp = Functions.rocp(instrument.close,context.lag,context.period) 
    #rocr = Functions.rocr(instrument.close,context.lag,context.period) 
    #rocr100 = Functions.rocr100(instrument.close,context.lag,context.period) 
    #rsi  = Functions.rsi(instrument.close,context.lag,context.period)
    #sar = Functions.sar(instrument.high, instrument.low, context.lag,context.accel, context.accelmax)   	
    #sarext = Functions.sarext(instrument.high,instrument.low,context.lag,context.StartValue, context.OffsetOnReverse, context.AccelerationInitLong,context.AccelerationLong,context.AccelerationMaxLong,context.AccelerationInitShort, context.AccelerationShort, context.AccelerationMaxShort) 
    #sma = Functions.sma(instrument.close,context.lag,context.period) 
    #stddev = Functions.stddev(instrument.close,  context.lag, context.period,context.NbDev) 
    #stoch = Functions.stoch(instrument.high,instrument.low,instrument.close,context.lag,context.fastK_period,context.slowK_period, context.slowK_MAType,context.slowD_period,context.slowD_MAType)
    #stochf = Functions.stochf(instrument.high, instrument.low, instrument.close, context.lag, context.fastK_period,context.fastD_period,context.fastD_MAType)
    #stochrsi = Functions.stochrsi(instrument.close,context.lag,context.period,context.fastK_period,context.fastD_period,context.fastD_MAType) 
    #sum = Functions.sum(instrument.close,context.lag,context.period) 
    #t3 = Functions.t3(instrument.close,context.lag,context.period,context.vfactor)
    #tema = Functions.tema(instrument.close,context.lag,context.period)
    #trange = Functions.trange(instrument.high,instrument.low,instrument.close, context.lag,context.period)
    #trima = Functions.trima(instrument.close,context.lag,context.period) 
    #trix = Functions.trix(instrument.close,context.lag,context.period)
    #tsf = Functions.tsf(instrument.close, context.lag, context.period) 
    #typprice = Functions.typprice(instrument.high, instrument.low, instrument.close, context.lag, context.period) 
    #ultosc = Functions.ultosc(instrument.high, instrument.low, instrument.close,context.lag, context.Period1,context.Period2,context.Period3) 
    #variance = Functions.variance(instrument.close,context.lag,context.period,context.NbVar) 
    #wclprice = Functions.wclprice(instrument.high,instrument.low,instrument.close, context.lag,context.period) 
    #willr = Functions.willr(instrument.high,instrument.low,instrument.close, context.lag,context.period)
    #wma = Functions.wma(instrument.close,context.lag,context.period)

  
    
 ###########################################################   
   
    #diff = Functions.diff(6,10)
    #percent = Functions.percent(6,10)
 
    #debug "#{diff}"
    #debug "#{percent}"


 ###########################################################
 
    #debug "#{ad}"
    #debug "#{accbands.UpperBand}  #{accbands.MiddleBand} #{accbands.LowerBand}"
    #debug "#{adosc}"
    #debug "#{adx}" 
    #debug "#{adxr}"
    #debug "#{apo}"
    #debug "#{aroon.up} #{aroon.down}"
    #debug "#{aroonosc}"
    #debug "#{atr} "
    #debug "#{avgprice}"
    #debug "#{bbands.UpperBand} #{bbands.MiddleBand} #{bbands.LowerBand}"
    #debug "#{beta}"
    #debug "#{bop}"
    #debug "#{cci}"
    #debug "#{cmo}"
    #debug "#{correl}"
    #debug "#{dema}"
    #debug "#{dx}"
    #debug "#{ema}"
    #debug "#{ht_dcperiod}"
    #debug "#{ht_dcphase}"
    #debug "#{ht_phasor.phase} #{ht_phasor.quadrature}"
    #debug "#{ht_sine.sine} #{ht_sine.leadsine}"
    #debug "#{ht_trendline}"   
    #debug "#{ht_trendmode}"
    #debug "#{imi}"
    #debug "#{kama}"
    #debug "#{linearreg}"
    #debug "#{linearreg_angle}"
    #debug "#{linearreg_intercept}"
    #debug "#{linearreg_slope}"
    #debug "#{ma}" 
    #debug "#{macd.macd}  #{macd.signal}  #{macd.histogram}"
    #debug "#{macdext.macd}  #{macdext.signal} #{macdext.histogram}"
    #debug "#{macdfix.macd}  #{macdfix.signal} #{macdfix.histogram}"
    #debug "#{mama.mama} #{mama.fama}"
    #debug "#{mavp}"
    #debug "#{max_high}
    #debug "#{maxindex}"
    #debug "#{medprice}"
    #debug "#{mfi}"
    #debug "#{midpoint}"
    #debug "#{midprice}"
    #debug {#{min_low}"
    #debug "#{minindex}"
    #debug "#{minmax.min} #{minmax.max}"
    #debug "#{minmaxindex.min} #{minmaxindex.max}"
    #debug "#{minus_di}"
    #debug "#{minus_dm}"
    #debug "#{mom}"
    #debug "#{natr}"
    #debug "#{obv}" 
    #debug "#{plus_di}"
    #debug "#{plus_dm}"
    #debug "#{ppo}"
    #debug "#{roc}"
    #debug "#{rocp}"
    #debug "#{rocr}"
    #debug "#{rocr100}"
    #debug "#{rsi}"
    #debug "#{sar}"
    #debug "#{sarext}"
    #debug "#{sma}"
    #debug "#{stddev}"
    #debug "#{stoch.K} #{stoch.D}"
    #debug "#{stochf.K} #{stochf.D}"
    #debug "#{stochrsi.K}#{stochrsi.D} "
    #debug "#{sum}"
    #debug "#{t3}"
    #debug "#{tema}"
    #debug "#{trange}"
    #debug "#{trima}"
    #debug "#{trix}"
    #debug "#{tsf }"
    #debug "#{typprice}"   
    #debug "#{ultosc} "   
    #debug "#{variance}"
    #debug "#{wclprice}"
    #debug "#{willr}"
    #debug "#{wma}"

 
############################################################

 
    
    