# Generated by Django 3.2.9 on 2021-12-11 19:27

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('wallet', '0010_transaction_cancelled'),
    ]

    operations = [
        migrations.AlterField(
            model_name='transaction',
            name='status',
            field=models.CharField(max_length=10),
        ),
    ]
