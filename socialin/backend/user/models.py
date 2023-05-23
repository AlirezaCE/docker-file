from django.db import models
from django.contrib.auth.models import AbstractUser
from django.conf import settings
from django.core.validators import validate_email


class CustomUser(AbstractUser):
    username = models.CharField(unique=True, max_length=32, null = False, blank= False )
    email = models.EmailField(max_length=32, blank=False, null=False, validators=[validate_email])
    otp = models.CharField(max_length=32)
    otp_expiry = models.DateTimeField(blank=True, null=True)
    max_otp_try = models.CharField(max_length=2, default=settings.MAX_OTP_TRY)
    otp_max_out = models.DateTimeField(blank=True, null=True)
    USERNAME_FIELD = 'username'
    REQUIRED_FIELDS = ['email']
    phone = models.CharField(max_length=32, blank=True, null=True)
    gender = models.CharField(max_length=16, blank=True, null=True)
    session_token = models.CharField(max_length=16, default=0)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return "userneme : " + self.username


