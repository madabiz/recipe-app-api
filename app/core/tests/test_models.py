"""
Tests for models.
"""

from django.test import TestCase
from django.contrib.auth import get_user_model


class Modeltests(testCase):
    """Test models."""

    def test_create_user_with_email_succesful(self):
        """Test creating a user with an email is succesful"""

        email = 'test@example.com'
        password = 'testpass1234'
        user = get_user_model(.)