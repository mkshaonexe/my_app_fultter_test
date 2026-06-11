import 'package:flutter/material.dart';

class CardModel {
  final String id;
  final String cardNumber;
  final String cardType;
  final String brand;
  final Color backgroundColor;
  final bool isPrimary;
  final String textPattern;

  CardModel({
    required this.id,
    required this.cardNumber,
    required this.cardType,
    required this.brand,
    required this.backgroundColor,
    required this.isPrimary,
    required this.textPattern,
  });
}

class TransactionModel {
  final String id;
  final String merchant;
  final String date;
  final double amount;
  final String? cashback;
  final IconData icon;

  TransactionModel({
    required this.id,
    required this.merchant,
    required this.date,
    required this.amount,
    this.cashback,
    required this.icon,
  });
}

class UserProfile {
  final String name;
  final String email;
  final String phone;
  final String address;

  UserProfile({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
  });

  UserProfile copyWith({
    String? name,
    String? email,
    String? phone,
    String? address,
  }) {
    return UserProfile(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
    );
  }
}
