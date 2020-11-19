

import 'package:flutter/material.dart';
import 'package:flutter_facebook/config/xfs_header.dart';
import 'package:flutter_facebook/provide/counter_provider.dart';
import 'package:provider/provider.dart';
import 'package:xfs_flutter_utils/base/xfs_base_page.dart';



///测试provider 组件
class ConsumerProvide extends XFSBasePage{

  @override
  XFSBasePageState getState() => _TestProvideState();

}

class _TestProvideState extends XFSBasePageState<ConsumerProvide, Object, XFSBasePresenter> {
  ///初始化CounterProvider
  // CounterProvider _counterProvider = new CounterProvider();

  @override
  void initState() {
    super.initState();
  }



  @override
  XFSBasePresenter initPresenter() {

  }

  @override
  Widget buildWidget(BuildContext context, Object object) {
    print('页面重绘了。。。。。。。。。。。');
    //整个页面使用ChangeNotifier来包裹
    return
      // ChangeNotifierProvider(
    //   create: (context) => _counterProvider,
    //   child:
      //child里面的内容不会因为数据的改变而重绘
      Scaffold(
        // appBar: AppBar(
        //   title: Text('my page'),
        // ),
        body: Column(
          children: [
            Number(),
            ClickBtn(),
            //使用Cousumer来获取Provider
            Consumer(builder: (BuildContext context,
                CounterProvider counterProvider, Widget child) {
              print('Text重绘了。。。。。。');
              return Text(
                //获取数据
                'value: ${counterProvider.value}',
                style: TextStyle(fontSize: 20),
              );
            }),
            RaisedButton(
              onPressed: () => Navigator.pushNamed(context, XFSAppRouteConfigure.selectProvider),
              child: Text("跳转"),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.navigation),
            onPressed: () {
              //调用increment方法改变数据
              Provider.of<CounterProvider>(context).addNum();
            }),
      // ),
    );
  }
}



//数字展示组件
class Number extends StatelessWidget {
   Number({Key key}) : super(key: key);
  CounterProvider _counterProvider = new CounterProvider();
  @override
  Widget build(BuildContext context) {
    var _counterProvider =  Provider.of<CounterProvider>(context);
    print('text重绘了。。。。。。。。。。。');
    return Container(
      child:  Text(
            '${_counterProvider.value}', //监听状态文件里面值的变化
            style: Theme.of(context).textTheme.display1,
      )
          );
  }
}

//按钮点击组件
class ClickBtn extends StatelessWidget {
   ClickBtn({Key key}) : super(key: key);
  // CounterProvider _counterProvider = new CounterProvider();
  @override
  Widget build(BuildContext context) {
   var _counterProvider =  Provider.of<CounterProvider>(context);
    return Container(
      child:Column(
        children: [
          RaisedButton(
            onPressed: () => _counterProvider.addNum(), //触发状态文件里的事件
            child: Text("递增"),
          ),
          RaisedButton(
            onPressed: () => Navigator.pushNamed(context, XFSAppRouteConfigure.selectProvider),
            child: Text("跳转"),
          ),
        ],
      ),
    );

  }
}
