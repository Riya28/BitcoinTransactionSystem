from django.shortcuts import render, redirect
from django.contrib.auth.models import auth
from django.contrib import messages
from .models import *
from bitcoin import *
import bs4
import requests
from decimal import Decimal

def index(request):
    
    
    print(request.POST)
    
    # check if user is trader or client
    # if client then you insert in payments table 
    # increase the wallet balance
    clients = Users.objects.filter(user_type='Client')
    users = Users.objects.all()
    payments = Payments.objects.all()
    txns = Transaction.objects.all()
    response = requests.get('https://api.coindesk.com/v1/bpi/currentprice/USD.json')
    btc_rate = response.json()['bpi']['USD']['rate_float']
    print(btc_rate)
    context = {'clients' :clients,'users':users,'btc_rate':btc_rate,'payments':payments,
               'txns':txns}
    if 'payment-cancel-id' in request.POST:
        p = Payments.objects.get(id=request.POST['payment-cancel-id'])
        p.cancelled= True
        p.status= 'Cancelled'
        p.save()
    if 'txn-cancel-id' in request.POST:
        p = Transaction.objects.get(id=request.POST['txn-cancel-id'])
        p.cancelled= True
        p.status= 'Cancelled'
        p.save()
        
        
    if 'payment-btn'  in request.POST:
        usd_amount =  request.POST['usd-amount']
        status = 'Completed'
        if request.user.user_type == 'Trader':
            client_id = request.POST['client-id']
        else:
            client_id = request.user.id
        
        Payments.objects.create(usd_amount = usd_amount, client_id_id = client_id, status = status)
    
    if 'trade-btn'  in request.POST:
        print(request.POST)
        order_type = request.POST.get('order-type', None)
        btc_amount = request.POST.get('buy-btc-amount', Decimal(0))
        usd_amount = request.POST.get('buy-usd-amount', Decimal(0))
        commission_type = request.POST.get('comm-type', None)
        client_id = request.POST.get('client-id', request.user.id)
        trader_id = request.user.id if request.user.user_type == 'Trader' else None
        btc_rate  = request.POST.get('btc-rate', None)
        client = Users.objects.get(id = client_id)
        comm_percentage = Decimal('0.1')
        
        if order_type == 'buy':
            btc_amount = round(Decimal(usd_amount)/Decimal(btc_rate),6)
        else:
            usd_amount = round(Decimal(btc_rate) * Decimal(btc_amount),2)

        if commission_type == 'btc':
            comm_amount = round(comm_percentage * Decimal(btc_amount) * Decimal(0.01),6)
        else:
            comm_amount = round(comm_percentage * Decimal(usd_amount) * Decimal(0.01),2)
        if order_type:
            # add the payment to client address
            try:
                Transaction.objects.create(client_id_id=client_id,trader_id_id=trader_id,exchange_rate=btc_rate,
                                     commission_type=commission_type,commission_per=comm_percentage,
                                     commission_amount=comm_amount,order_type=order_type,btc_amount = btc_amount,usd_amount=usd_amount,status='Completed')    
            except Exception as e:
                context['error'] = str(e)
                return render(request, 'index.htm',context= context )
                            
    
        return redirect('/')
    
    return render(request, 'index.htm',context= context )

def login(request):
    
    if request.method == 'POST':
        username = request.POST['username']
        password = request.POST['password']

        user = auth.authenticate(username=username, password=password)

        if user is not None:
            auth.login(request, user)
            return redirect('/')
        else:
            messages.info(request, 'Invalid Credentials')
            return redirect('login')

    else:
        return render(request, 'login.htm')

def register(request):
    
    detail = Details()


    if request.method == 'POST':
        username = request.POST['username']
        email = request.POST['email']
        first_name = request.POST['first_name']
        last_name = request.POST['last_name']
        password = request.POST['password']
        password2 = request.POST['password2']
        city = request.POST['city']
        phone_number = request.POST['phone_number']
        cell_number = request.POST['cell_number']
        state = request.POST['state']
        zip_code = request.POST['zip_code']
        street = request.POST['street']
        user_type = request.POST['user_type']
        
        

        if password==password2:       
            if Users.objects.filter(email=email).exists():
                messages.info(request, 'Email Taken')
                return redirect('register')
            elif Users.objects.filter(username=username).exists():
                messages.info(request, 'Username Taken')
                return redirect('register')
            else:
                user = Users.objects.create_user(username=username, email=email, password=password, last_name=last_name, first_name=first_name, city=city, phone_number = phone_number, cell_number = cell_number, state = state, zip_code = zip_code, street = street, user_type = user_type)
                user.save();
                print('User Created')
                return redirect('login')

        else:
            messages.info(request, 'Password Not Matching')
            return redirect('register')
        return redirect('/')

    else:
        return render(request, 'register.htm', {'detail': detail})

def logout(request):
    auth.logout(request)
    return redirect('/')

def profile(request):
    if request.method == 'POST':
         addr = request.POST['addr']
    else:
        detail = '    '
    return render(request,'profile.htm', {'detail' : detail})