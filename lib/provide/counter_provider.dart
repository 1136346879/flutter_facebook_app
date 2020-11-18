import 'package:flutter_facebook/config/xfs_header.dart';

class CounterProvider with ChangeNotifier {//父类的方法 不限制听众

  int _count = 0;
  int _count2 = 0;

  int get value => _count;
  int get value2 => _count2;
  void addNum(){
    _count ++;
    notifyListeners(); //父类的方法,发出通知
  }
  void addNum2(){
    _count2 ++;
    notifyListeners(); //父类的方法,发出通知
  }




}