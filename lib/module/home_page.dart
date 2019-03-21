import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_learn/utils/swift_toast.dart';
import 'package:intl/intl.dart';


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String _url =
      "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1553085925672&di=2786f9c5007295c71209fd5c1942ecec&imgtype=0&src=http%3A%2F%2Fi2.hdslb.com%2Fbfs%2Farchive%2F275711de0c966ab52459768ffeb4d092fa0075b1.jpg";
  int _counter = 0;
  String _content = 'Java';
  bool _checkboxSelected = false;

  /// 手势
  final TapGestureRecognizer _recognizer = TapGestureRecognizer();

  /// 初始化，Weidget 第一次插入 Weidget 会调用
  /// 只一次，做一些状态初始化、消息订阅
  /// BuildContext.inheritFromWidgetOfExactType
  @override
  void initState() {
    super.initState();
    print('initState() 0000000');
    // 初始化 _recognizer 点击事件
    _recognizer.onTap = () {
      Swift.toast('_recognizer: ' + _content);
    };
  }

  /// 当 State 依赖对象发生改变，回调
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies() 55555555555');
  }

  /// 构建，多次调用
  /// 1. 在调用initState()之后
  /// 2. 在调用didUpdateWidget()之后
  /// 3. 在调用setState()之后
  /// 4. 在调用didChangeDependencies()之后
  /// 5. 在State对象从树中一个位置移除后（会调用deactivate）又重新插入到树的其它位置之后
  @override
  Widget build(BuildContext context) {
    print('build() 111111111');
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
        leading: new Icon(Icons.home),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        margin: EdgeInsets.symmetric(vertical: 20.0),
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text('Pushed me:'),
                Text.rich(
                  TextSpan(children: [
                    TextSpan(
                      text: '$_content',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 36.0,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: _recognizer,
                    )
                  ]),
                ),
                Container(child: _MyButton()),
                Image.network(
                  _url,
                  width: 150.0,
                  fit: BoxFit.contain,
                ),
                Checkbox(
                  value: _checkboxSelected,
                  activeColor: Colors.red, //选中时的颜色
                  onChanged: (value) {
                    setState(() {
                      _checkboxSelected = value;
                    });
                  },
                ),
                TextField(
                  style: TextStyle(color: Colors.blue),
                  decoration: InputDecoration(
                    fillColor: Colors.amber,
                    labelText: "用户",
                    hintText: "用户名或邮箱",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.red, Colors.orange[700]],
                      ),
                      //背景渐变
                      borderRadius: BorderRadius.circular(3.0), // 3像素圆角
                      boxShadow: [
                        //阴影
                        BoxShadow(
                            color: Colors.black54,
                            offset: Offset(2.0, 2.0),
                            blurRadius: 4.0)
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 80.0, vertical: 18.0),
                      child:
                          Text("Login", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  /// 加一 ，通过 setState() 通知
  void _incrementCounter() {
    setState(() {
      _counter++;
      _content = 'Hello World_' + _counter.toString();
    });
    Swift.toast(_content);
  }

  /// 在widget重新构建时，Flutter framework会
  /// 调用 Widget.canUpdate() 来检测Widget树
  /// 中同一位置的新旧节点，然后决定是否需要更新
  /// 如果 Widget.canUpdate () 返回true则会
  /// 调用此回调。正如之前所述，Widget.canUpdate()
  /// 会在新旧widget的key和runtimeType同时相等时
  /// 会返回true，也就是说在在新旧widget的key和
  /// runtimeType同时相等时 didUpdateWidget()就会被调用
  @override
  void didUpdateWidget(MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget() 2222222');
  }

  /// 当State对象从树中被移除时，会调用此回调
  /// 如果移除后没有重新插入到树中则紧接着会调用 dispose() 方法
  @override
  void deactivate() {
    super.deactivate();
    print('deactivate() 3333333');
  }

  /// State对象从树中被永久移除时调用；通常在此回调中释放资源
  @override
  void dispose() {
    super.dispose();
    print('dispose() 4444444444');
  }

  /// debug 下，热重载(hot reload)时会被调用，release 不会走
  @override
  void reassemble() {
    super.reassemble();
    print('reassemble() 6666666');
  }
}

/// 创建一个 Button
class _MyButton extends StatelessWidget {
  void _showTime() {
    var now = new DateTime.now();
    var format = new DateFormat('yyyy-MM-dd HH:mm:ss');
    String time = format.format(now);
    Swift.toast(time);
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        _showTime();
      },
      child: new Container(
        height: 46.0,
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 36.0),
        decoration: new BoxDecoration(
            borderRadius: new BorderRadius.circular(5.0),
            color: Colors.lightGreen[500]),
        child: new Center(
          child: new Text(
            'Engage',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
