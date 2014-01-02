from django.db import models
from imagekit.models import ImageSpecField
from imagekit.processors import ResizeToFill
# Create your models here.


class Percentages(models.Model):

# max_percentage: The positive percentage to buy (3.00%)
# min_percentage: The negative percentage to sell (-3.00%)
# stop_loss_percentage: A percentage set to avoid losses (experimental variable)

	max_percentage = models.DecimalField(max_digits=5, decimal_places=2, default=0.00)
	min_percentage = models.DecimalField(max_digits=5, decimal_places=2, default=0.00)
	stop_loss_percentage = models.DecimalField(max_digits=5, decimal_places=2, default=0.00)


class Currency(models.Model):

# name: CryptoCurrency name
# image: CryptoCurrency logo/picture (disabled)
# image_thumbnail: CryptoCurrency logo/picture resize to 50px-50px (disabled)
# symbol: CryptoCurrency symbol/code (BTC, LTC, ...)
# amount: Number of coins in the wallet
# paid: Invested money in Euro or Dollars
# rate: CryptoCurrency current value
# value: The value of the amount of coins in Euro or Dollars
# profit: The profit that you have (profit = paid - value)
# fee: The exchange trade fee (bter.com)

	name = models.CharField(max_length=50)
	# image = models.ImageField(upload_to="images/currencies,default_images/default_currency.png")
    # image_thumbnail = ImageSpecField(source='image',
 	#                                   processors=[ResizeToFill(50, 50)],
 	#                                   format='JPEG',
 	#                                   options={'quality': 100})

	symbol = models.CharField(max_length=4)
	amount = models.DecimalField(max_digits=20, decimal_places=8, default=0.00000000)
	paid = models.DecimalField(max_digits=20, decimal_places=2, default=0.00)
	rate = models.DecimalField(max_digits=20, decimal_places=2, default=0.00)
	value = models.DecimalField(max_digits=20, decimal_places=2, default=0.00)

	profit = models.DecimalField(max_digits=20, decimal_places=2, default=0.00)

	fee = models.DecimalField(max_digits=5, decimal_places=2, default=0.00)



class MainTickerValue(models.Model):

	currency = models.CharField(max_length=50)
	time = models.DateTimeField()
	value = models.DecimalField(max_digits=25, decimal_places=5, default=0.00000) #Exchange in BTC

