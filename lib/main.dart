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

  var total = 3;
  var user = [ ['김영숙', '01011111111'], ['홍길동', '01022222222'], ['피자집', '01033333333'] ];
  var like = [0, 0, 0];

  addOne() {
    setState(() {
      total++;
    });
  }

  addName(a) {
    setState(() {
      if (a != '') {
        user.add([a, '0']);
      }
    });
  }

  @override
  build(context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            showDialog(context: context, builder: (context){
              return DialogUI( addOne : addOne, addName : addName,);
            });
          },
        ),
        appBar: AppBar( title: Text(total.toString(), )),
        body: ListView.builder(
              itemCount: user.length,
              itemBuilder: (c, i){
                return ListTile(
                  leading: Image.asset('BaekJoon.png'),
                  title: Text(user[i][0]),
                  subtitle: Text(user[i][1]),
                  trailing: ElevatedButton(
                    child: Text('삭제'),
                    onPressed: (){
                      setState(() {
                        user.remove(user[i]);
                      });
                    }
                  )
                );
                }
        ),
        bottomNavigationBar: ElevatedButton(
          child: Text('정렬'),
          onPressed: (){
            setState(() {
              user.sort();
            });
          },
        ),
      );

  }
}

class DialogUI extends StatelessWidget {
  DialogUI({super.key, this.addOne, this.addName});
  final addOne, addName;
  var inputData = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: 300,
        height: 300,
        child: Column(
          children: [
            TextField( controller: inputData, ),
            TextButton(
              child: Text('완료'),
              onPressed: (){
                addOne();
                addName(inputData.text);
                Navigator.pop(context);
              }),
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
