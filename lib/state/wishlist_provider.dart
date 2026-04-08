import 'package:flutter/material.dart';

class WishlistProvider extends ChangeNotifier {
  int _wishlistCount = 0;
  int get wishlistCount => _wishlistCount;

  void increment() {
    _wishlistCount++;
    notifyListeners(); // Notify widgets to rebuild
  }
}