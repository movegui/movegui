
import 'package:flutter/widgets.dart';

class ShoppingProvider with ChangeNotifier{
int _itemCount = 0;

int get itemCount => _itemCount; 

void addItem(){
  _itemCount++;
  notifyListeners();
}

  void removeItem() {
    if (_itemCount > 0) {
      _itemCount--;
      notifyListeners();
    }
  }

  void clearCart() {
    _itemCount = 0;
    notifyListeners();
  }

}
