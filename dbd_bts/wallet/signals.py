from decimal import Decimal
from wallet.models import *
from django.db.models.signals import pre_save, post_save
from django.dispatch import receiver


class CustomException(Exception):
    pass

@receiver(post_save, sender=Payments)
def update_balance(sender,instance,created,**kwargs):
    user = Users.objects.get(id = instance.client_id.id)
    instance.usd_amount = Decimal(instance.usd_amount)
    print(instance.usd_amount,"USD BALANCE")
    if instance.cancelled:
        user.usd_balance = user.usd_balance - instance.usd_amount
    else:
        user.usd_balance = user.usd_balance + instance.usd_amount
    print(user.usd_balance,"Wallet Balance")
    user.save()
    return instance 

@receiver(pre_save, sender=Transaction)
def update_balance_tx(sender,instance,**kwargs):
    u = Users.objects.get(id=instance.client_id.id)
    instance.btc_amount = Decimal(instance.btc_amount)
    instance.usd_amount = Decimal(instance.usd_amount)
    instance.comm_amount = Decimal(instance.commission_amount)
    if instance.order_type == 'buy':
        if not instance.cancelled:
            u.btc_balance = u.btc_balance + instance.btc_amount
            u.usd_balance = u.usd_balance - instance.usd_amount
            if u.usd_balance < 0:
                raise CustomException("Not Enough USD Balance")
        else:
            # Reverse
            u.btc_balance = u.btc_balance - instance.btc_amount
            u.usd_balance = u.usd_balance + instance.usd_amount

    else:
        if not instance.cancelled:
            # Subtract btc to wallet and add usd
            u.btc_balance = u.btc_balance - instance.btc_amount
            u.usd_balance = u.usd_balance + instance.usd_amount
            if u.btc_balance < 0:
                raise CustomException("Not Enough BTC Balance")
        else:
            # Reverse
            u.btc_balance = u.btc_balance + instance.btc_amount
            u.usd_balance = u.usd_balance - instance.usd_amount

    if instance.commission_type == 'usd':
        if not instance.cancelled:
            # Subtract from wallet
            u.usd_balance = u.usd_balance - instance.comm_amount
            if u.usd_balance < 0:
                raise CustomException("Not Enough USD Balance for Commission")
        else:
            # add to wallet
            u.usd_balance = u.usd_balance + instance.comm_amount
    else:
        if not instance.cancelled:
            # Subtract from wallet
            u.btc_balance = u.btc_balance - instance.comm_amount
            if u.btc_balance < 0:
                raise CustomException("Not Enough BTC Balance for Commission")
        else:
            # add to wallet
            u.btc_balance = u.btc_balance + instance.comm_amount

    u.save()
    return instance