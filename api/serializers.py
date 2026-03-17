"""Сериализаторы для API."""

import re

from django.contrib.auth import get_user_model
from django.shortcuts import get_object_or_404
from rest_framework import serializers
from rest_framework_simplejwt.tokens import RefreshToken

User = get_user_model()


class SignupSerializer(serializers.Serializer):
    """Сериализатор для класса SignupViewSet."""

    username = serializers.CharField(max_length=LEN_2)
    email = serializers.EmailField(max_length=LEN_3)

    def validate_username(self, value):
        if not re.match(PATTERN, value):
            raise serializers.ValidationError(
                'Недопустимые символы в username.'
            )
        if value == ME:
            raise serializers.ValidationError(f'Запрещено имя "{ME}".')
        return value

    def validate(self, data):
        email = data['email']
        username = data['username']
        if (User.objects.filter(username=username, email=email).exists()):
            return data
        if email and User.objects.filter(email=email).exists():
            raise serializers.ValidationError(
                {'email': 'Пользователь с таким email уже существует'}
            )
        if User.objects.filter(username=username).exists():
            raise serializers.ValidationError(
                {'username': 'Пользователь с таким username уже существует'}
            )
        return data

    def create(self, validated_data):
        email = validated_data['email']
        username = validated_data['username']
        user = User.objects.get_or_create(username=username, email=email)[0]
        return user


class UsersSerializer(serializers.ModelSerializer):
    """Сериализатор для класса UsersViewSet."""

    class Meta:
        model = User
        fields = (
            'email',
            'username',
            'first_name',
            'last_name',
            "bio",
            "role"
        )


class TokenSerializer(serializers.Serializer):
    """Сериализатор для класса TokenViewSet."""

    username = serializers.CharField(max_length=LEN_2)
    confirmation_code = serializers.CharField()

    def validate(self, data):
        user = get_object_or_404(User, username=data['username'])
        if (
            not user.confirmation_code
            or user.confirmation_code != data['confirmation_code']
        ):
            raise serializers.ValidationError(
                {'confirmation_code': 'Неверный код подтверждения'}
            )
        return data

    def validate_username(self, value):
        if not re.match(PATTERN, value):
            raise serializers.ValidationError(
                'Недопустимые символы в username.'
            )
        if value == ME:
            raise serializers.ValidationError(f'Запрещено имя "{ME}".')
        return value

    def to_representation(self):
        user = User.objects.get(username=self.validated_data['username'])
        refresh = RefreshToken.for_user(user)
        return {'token': str(refresh.access_token)}


# Сериализаторы для категорий, жанров, произведений
class CategorySerializer(serializers.ModelSerializer):
    """Сериализатор для модели Category."""

    class Meta:
        model = Category
        fields = ('name', 'slug')


class GenreSerializer(serializers.ModelSerializer):
    """Сериализатор для модели Genre."""

    class Meta:
        model = Genre
        fields = ('name', 'slug')


class TitleSerializer(serializers.ModelSerializer):
    """Сериализатор для модели Title (только чтение)."""

    category = CategorySerializer(read_only=True)
    genre = GenreSerializer(many=True, read_only=True)
    rating = serializers.IntegerField(read_only=True)

    class Meta:
        model = Title
        fields = (
            'id', 'name', 'year', 'rating', 'description',
            'genre', 'category'
        )


class TitleWriteSerializer(serializers.ModelSerializer):
    """
    Сериализатор для создания/обновления произведений.
    Принимает slug'и категории и жанров вместо вложенных объектов.
    """

    category = serializers.SlugRelatedField(
        queryset=Category.objects.all(),
        slug_field='slug'
    )
    genre = serializers.SlugRelatedField(
        queryset=Genre.objects.all(),
        slug_field='slug',
        many=True,
        allow_empty=False
    )

    class Meta:
        model = Title
        fields = ('id', 'name', 'year', 'description', 'genre', 'category')

    def to_representation(self, instance):
        """При чтении (после создания/обновления) возвращаем полные данные."""
        return TitleSerializer(instance, context=self.context).data


class ReviewSerializer(serializers.ModelSerializer):
    """Сериализатор отзывов."""

    author = serializers.SlugRelatedField(
        read_only=True,
        slug_field='username'
    )

    class Meta:
        model = Review
        fields = ('id', 'text', 'author', 'score', 'pub_date')

    def validate(self, data):
        """
        Один пользователь может оставить только один отзыв на произведение.
        """
        request = self.context.get('request')
        title = self.context.get('title')

        if request and request.method == 'POST':
            if Review.objects.filter(
                title=title,
                author=request.user
            ).exists():
                raise serializers.ValidationError(
                    'Вы уже оставили отзыв на это произведение.'
                )
        return data


class CommentSerializer(serializers.ModelSerializer):
    """Сериализатор комментариев."""

    author = serializers.SlugRelatedField(
        read_only=True,
        slug_field='username'
    )

    class Meta:
        model = Comment
        fields = ('id', 'text', 'author', 'pub_date')
