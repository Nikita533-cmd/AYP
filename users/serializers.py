from rest_framework import serializers

from .models import User


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = (
            "id",
            "ini",
            "is_superuser",
        )

# class BrnchSerializer(serializers.Serializer):
#     branchDetails = serializers.CharField(max_length=10)