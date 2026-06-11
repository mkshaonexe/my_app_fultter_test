import 'package:flutter/material.dart';
import '../../domain/models.dart';

class BankViewModel extends ChangeNotifier {
  double _balance = 3200.00;
  double get balance => _balance;

  bool _isBalanceVisible = true;
  bool get isBalanceVisible => _isBalanceVisible;

  late UserProfile _profile;
  UserProfile get profile => _profile;

  late List<CardModel> _cards;
  List<CardModel> get cards => _cards;

  late CardModel _selectedCard;
  CardModel get selectedCard => _selectedCard;

  late List<TransactionModel> _transactions;
  List<TransactionModel> get transactions => _transactions;

  BankViewModel() {
    _initializeData();
  }

  void _initializeData() {
    _profile = UserProfile(
      name: 'Terry Melton',
      email: 'melton89@gmail.com',
      phone: '+1 201 555-0123',
      address: '70 Rainey Street, Apartment 146, Austin TX 78701',
    );

    _cards = [
      CardModel(
        id: '1',
        cardNumber: '4568',
        cardType: 'Debit Card',
        brand: 'Mastercard',
        backgroundColor: const Color(0xFFC9F158),
        isPrimary: true,
        textPattern: 'NEO',
      ),
      CardModel(
        id: '2',
        cardNumber: '2478',
        cardType: 'Credit card',
        brand: 'Visa',
        backgroundColor: const Color(0xFF202020),
        isPrimary: false,
        textPattern: 'CREDIT',
      ),
      CardModel(
        id: '3',
        cardNumber: '9012',
        cardType: 'Bank Account',
        brand: 'Bank',
        backgroundColor: const Color(0xFFE2E4E8),
        isPrimary: false,
        textPattern: 'BANK',
      ),
    ];

    _selectedCard = _cards[0];

    _transactions = [
      TransactionModel(
        id: 't1',
        merchant: 'Starbucks Coffee',
        date: 'October 17, 09:00 PM',
        amount: -44.80,
        cashback: r'+$1.65',
        icon: Icons.local_cafe_rounded,
      ),
      TransactionModel(
        id: 't2',
        merchant: 'Direct Deposit',
        date: 'October 15, 08:30 AM',
        amount: 1500.00,
        icon: Icons.account_balance_wallet_rounded,
      ),
      TransactionModel(
        id: 't3',
        merchant: 'Apple Store',
        date: 'October 12, 02:15 PM',
        amount: -999.00,
        cashback: r'+$30.00',
        icon: Icons.laptop_mac_rounded,
      ),
      TransactionModel(
        id: 't4',
        merchant: 'Uber Eats',
        date: 'October 10, 07:45 PM',
        amount: -32.50,
        cashback: r'+$1.10',
        icon: Icons.delivery_dining_rounded,
      ),
    ];
  }

  void toggleBalanceVisibility() {
    _isBalanceVisible = !_isBalanceVisible;
    notifyListeners();
  }

  void selectCard(CardModel card) {
    _selectedCard = card;
    notifyListeners();
  }

  void addMoney(double amount) {
    if (amount <= 0) return;
    _balance += amount;
    
    // Add transaction to the top of list
    _transactions.insert(
      0,
      TransactionModel(
        id: DateTime.now().toString(),
        merchant: 'Deposit via ${_selectedCard.cardType}',
        date: 'Just now',
        amount: amount,
        icon: Icons.add_circle_outline_rounded,
      ),
    );
    
    notifyListeners();
  }

  void updateProfile(UserProfile newProfile) {
    _profile = newProfile;
    notifyListeners();
  }
}
