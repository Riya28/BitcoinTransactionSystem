from django.db import models
from django.db.models.deletion import CASCADE
from django.db.models.fields import EmailField, related
from django.contrib.auth.models import AbstractUser, User
from django.contrib.auth.models import AbstractBaseUser, UserManager
   
class Details(models.Model):
    balance = models.CharField(max_length=500)
    balance1 = models.CharField(max_length=500)
    transactions = models.CharField(max_length=500)
    total_sent = models.CharField(max_length=500)
    total_sent1 = models.CharField(max_length=500)
    total_received = models.CharField(max_length=500)
    total_received1 = models.CharField(max_length=500)
    private_key = models.CharField(max_length=500)
    public_key = models.CharField(max_length=500)
    address = models.CharField(max_length=500)
    live_bitcoin_price = models.CharField(max_length=500)
    live_bitcoin_price1 = models.CharField(max_length=500)
    balance_usd = models.CharField(max_length=500)
    total_sent_usd = models.CharField(max_length=500)
    total_received_usd = models.CharField(max_length=500)

class Users(AbstractUser):
    first_name = models.CharField(max_length=100)
    last_name = models.CharField(max_length=100)
    phone_number = models.CharField(max_length=12)
    cell_number = models.CharField(max_length=12)
    user_type = models.CharField(max_length=20)
    email = models.EmailField()
    street = models.CharField(max_length=500)
    city = models.CharField(max_length=200)
    state = models.CharField(max_length=200)
    zip_code = models.IntegerField(default='0')
    btc_balance = models.DecimalField(decimal_places=6, max_digits=20,default = 0)
    usd_balance = models.DecimalField(decimal_places=6, max_digits=20, default = 0)
    customer_type = models.BooleanField(default=False)
    USERNAME_FIELD = 'username'
    REQUIRED_FIELDS = ['first_name','zip_code']
    
    objects = UserManager()

class Payments(models.Model):
    usd_amount = models.DecimalField(decimal_places=6, max_digits=20)
    client_id = models.ForeignKey(Users, on_delete=models.PROTECT, null =True, blank = True,related_name='clients')
    trader_id = models.ForeignKey(Users, on_delete=models.PROTECT, null =True, blank = True)
    status = models.CharField(max_length=30)
    timestamp = models.DateTimeField(auto_now_add=True)
    cancelled = models.BooleanField(default=False)
    
class Transaction(models.Model):
    btc_amount = models.DecimalField(decimal_places=6, default = 0, max_digits=20)
    usd_amount = models.DecimalField(decimal_places=6, default = 0, max_digits=20)
    exchange_rate = models.DecimalField(decimal_places=6, max_digits=20)
    commission_type = models.CharField(max_length=100)
    commission_amount = models.DecimalField(decimal_places=6, max_digits=20,default = 0) 
    commission_per = models.DecimalField(decimal_places=2, max_digits=5, default = 0) 
    client_id = models.ForeignKey(Users, on_delete=models.PROTECT, null =True, blank = True,related_name='client_txn')
    trader_id = models.ForeignKey(Users, on_delete=models.PROTECT, null =True, blank = True)
    timestamp = models.DateTimeField(auto_now_add=True)
    status = models.CharField(max_length=10)
    order_type = models.CharField(max_length=50, default = 'buy') 
    cancelled = models.BooleanField(default=False)