import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:flutter_learn/utils/http.dart';
import 'package:flutter_learn/utils/swift_toast.dart';

/// List Page 页
/// [Flutter & ListView (Liusilong)](https://www.jianshu.com/p/2ab1f6086024)
class ListPage extends StatefulWidget {
  @override
  _ListState createState() => _ListState();
}

class _ListState extends State<ListPage> {
  ///  数据
  List _subjects = [];

  /// 标题
  String _title = 'List';

  /// Dio 取消请求
  CancelToken _token = new CancelToken();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
     var result = await requestData();
     if (result == null) {
       return ;
     }
     updateData(result);
  }

  /// 异步加载网络数据
  Future requestData() async {
    var url = "https://api.douban.com/v2/movie/in_theaters";
    try {
      Response<String> response = await dio.get(url, cancelToken: _token);
      var strJson = response?.data ?? '{}';
      return json.decode(strJson);
    } catch (e) {
      if (CancelToken.isCancel(e)) {
        Swift.toast('请求取消');
      }
    }
  }

  /// 更新数据
  void updateData(result) {
    setState(() {
      _title = result['title'];
      _subjects.clear();
      _subjects.addAll(result['subjects']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        title: Text(_title),
        centerTitle: true,
        leading: new Icon(Icons.backup),
      ),
      body: Container(
        color: Colors.grey[100],
        child: Center(
          child: _getBody(),
        ),
      ),
    );
  }

  /// 取消网络请求
  @override
  void dispose() {
    super.dispose();
    _token.cancel('cancelled');
  }

  /// ListView 内容
  Widget _getBody() {
    // 进度提示
    if (_subjects.length == 0) {
      return CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.redAccent));
    }
    // ListView
    return ListView.builder(
        itemCount: _subjects.length,
        itemBuilder: (BuildContext context, int position) {
          return getItem(_subjects[position]);
        });
  }

  /// 构建 item
  GestureDetector getItem(var subject) {
    return GestureDetector(
      // item 点击
      onTap: () {
        Swift.toast(subject['title']);
      },
      // item 内容
      child: Card(
        elevation: 2.0,
        child: createItemContent(subject),
      ),
    );
  }

  /// 创建 item content
  Container createItemContent(subject) {
    var content = Container(
      margin: EdgeInsets.all(4.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: Image.network(
              subject['images']['large'],
              width: 100.0,
              height: 150.0,
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 8.0),
              height: 150.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // 电影名称
                  Text(
                    subject['title'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                    maxLines: 1,
                  ),
                  // 评分
                  Text(
                    '豆瓣评分：${subject['rating']['average']}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  // 类型
                  Text("类型：${subject['genres'].join("、")}"),
                  // 导演
                  Text('导演：${subject['directors'][0]['name']}'),
                  // 演员
                  Container(
                    margin: EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: <Widget>[
                        Text('主演：'),
                        Row(children: getAvatars(subject)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    return content;
  }

  /// 获取演员列表
  List<Container> getAvatars(subject) {
    // 演员
    var avatars = List.generate(
      subject['casts'].length,
      (int index) => Container(
            margin: EdgeInsets.only(left: index.toDouble() == 0.0 ? 0.0 : 16.0),
            child: CircleAvatar(
              backgroundColor: Colors.white10,
              backgroundImage:
                  NetworkImage(subject['casts'][index]['avatars']['small']),
            ),
          ),
    );
    return avatars;
  }
}
