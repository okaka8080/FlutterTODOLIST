// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';

const MaterialColor customSwatch = const MaterialColor(
  (0xFFFE7C64),
  const <int, Color>{
    50: const Color(0xFFFD9766),
    100: const Color(0xFFFE7C64),
    200: const Color(0xFFFE7C64),
    300: const Color(0xFFFE7C64),
    400: const Color(0xFFFE7C64),
    500: const Color(0xFFFE7C64),
    600: const Color(0xFFFE7C64),
    700: const Color(0xFFFE7C64),
    800: const Color(0xFFFE7C64),
    900: const Color(0xFFFE7C64),
  },
);

const Color kAccentColor = Color(0xFFFE7C64);
const Color kBackgroundColor = Color(0xFF19283D);

class MyTodoApp extends StatelessWidget {
  const MyTodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // アプリ名
      title: 'My Todo App',
      theme: ThemeData(
        // テーマカラー
        primarySwatch: customSwatch,
      ),
      // リスト一覧画面を表示
      home: const TodoListPage(),
    );
  }
}

// リスト一覧画面用Widget
class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  // Todoリストのデータ
  List<String> todoList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      // AppBarを表示し、タイトルも設定
      appBar: AppBar(
        title: const Text('リスト一覧', style: TextStyle(color: Colors.white)),
      ),
      // データを元にListViewを作成
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(todoList[index]),
            onDismissed: (direction) {
              setState(() {
                todoList.removeAt(index);
              });
            },
            child: Card(
              child: ListTile(
                title: Text(todoList[index]),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(height: 50.0),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // "push"で新規画面に遷移
          // リスト追加画面から渡される値を受け取る
          final newListText = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              // 遷移先の画面としてリスト追加画面を指定
              return const TodoAddPage();
            }),
          );
          if (newListText != null) {
            // キャンセルした場合は newListText が null となるので注意
            setState(() {
              // リスト追加
              todoList.add(newListText);
            });
          }
        },
        tooltip: 'リスト追加ボタン',
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

// リスト追加画面用Widget
class TodoAddPage extends StatefulWidget {
  const TodoAddPage({Key? key}) : super(key: key);

  @override
  _TodoAddPageState createState() => _TodoAddPageState();
}

class _TodoAddPageState extends State<TodoAddPage> {
  // 入力されたテキストをデータとして持つ
  String _text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: const Text('リスト追加', style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        //余白を付ける
        padding: const EdgeInsets.all(64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //入力されたテキストを表示
            Text(_text, style: const TextStyle(color: Color(0xFFFD9766))),
            const SizedBox(height: 8),
            //テキスト入力
            TextField(
              style: const TextStyle(color: Colors.white),
              onChanged: (String value) {
                setState(() {
                  _text = value;
                });
              },
            ),
            const SizedBox(height: 8),
            SizedBox(
              //横幅いっぱいに広げる
              width: double.infinity,
              //リスト追加ボタン
              child: ElevatedButton(
                onPressed: () {
                  // "pop"で前の画面に戻る
                  // "pop"の引数から前の画面にデータを渡す
                  if (_text.isEmpty) {
                    Navigator.of(context).pop();
                  } else {
                    Navigator.of(context).pop(_text);
                  }
                },
                child:
                    const Text('リスト追加', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFFFD9766),
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              // 横幅いっぱいに広げる
              width: double.infinity,
              // キャンセルボタン
              child: TextButton(
                // ボタンをクリックした時の処理
                onPressed: () {
                  // "pop"で前の画面に戻る
                  Navigator.of(context).pop();
                },
                child: const Text('キャンセル'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
