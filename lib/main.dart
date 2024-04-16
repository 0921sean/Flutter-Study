import 'package:flutter/material.dart';

void main() {
  runApp(
      MaterialApp(
        home: MyApp()
      )
  );
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var name = ['김영숙', '홍길동', '피자집'];

  @override
  build(context) {

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            showDialog(context: context, builder: (context){
              return DialogUI();
            });
          },
        ),
        appBar: AppBar(),
        body: ListView.builder(
          itemCount: 3,
          itemBuilder: (c, i){
            return ListTile(
              leading: Image.asset('BaekJoon.png'),
              title: Text(name[i]),
            );
          })
      );

  }
}

class DialogUI extends StatelessWidget {
  const DialogUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: 300,
        height: 300,
        child: Column(
          children: [
            TextField(),
            TextButton( child: Text('완료'), onPressed: (){}),
            TextButton(
              child: Text('취소'),
              onPressed: (){ Navigator.pop(context); },
            )
          ],
        )
      )
    );
  }
}
