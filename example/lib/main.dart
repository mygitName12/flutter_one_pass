import 'package:flutter/material.dart';
import 'package:flutter_one_pass/flutter_one_pass.dart' as flutterOnePass;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    /// 添加监听
    flutterOnePass.response.listen((response) {
      print(response);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter One Pass'),
        ),
        body: Column(
          children: [
            ElevatedButton(
              child: Text("初始化"),
              onPressed: () async {
                bool status = await flutterOnePass.init(appId: "appId");
                print(status);
              },
            ),

            ElevatedButton(
              child: Text("获取最近一条缓存的手机号码"),
              onPressed: () async {
                String number = await flutterOnePass.getCachedNumber;
              },
            ),

            ElevatedButton(
              child: Text("获取匹配的手机号码"),
              onPressed: () async {
                List<String> numbers = await flutterOnePass.getCachedNumbers(number: "number");
              },
            ),

            ElevatedButton(
              child: Text("销毁所有引用"),
              onPressed: () async {
                bool status = await flutterOnePass.destroy();
              },
            ),

            ElevatedButton(
              child: Text("验证手机号"),
              onPressed: () async {
                /// 验证手机号之前必须先初始化sdk
                /// flutterOnePass.init()
                flutterOnePass.checkMobile(phone: "phoneNumber", cacheNumber: true);
              },
            ),
          ],
        ),
      ),
    );
  }
}
