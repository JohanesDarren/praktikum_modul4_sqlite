import 'package:flutter/material.dart';

class KeranjangProvider extends ChangeNotifier {
  int _keranjangCount = 0;
  int get keranjangCount => _keranjangCount;

  void increment() {
    _keranjangCount++;
    notifyListeners(); // Notify widgets to rebuild
  }

  void decrement() {
    _keranjangCount--;
    notifyListeners(); // Notify widgets to rebuild
  }
}