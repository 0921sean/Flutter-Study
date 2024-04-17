import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

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

  getPermission() async {
    var status = await Permission.contacts.status;
    if (status.isGranted) {
      print('허락됨');
      var contacts = await ContactsService.getContacts();
      setState(() {
        name = contacts;
      });

    } else if (status.isDenied) {
      print('거절됨');
      Permission.contacts.request();
    }
  }

  var total = 3;
  List<Contact> name = [];
  var like = [0, 0, 0];

  addName(a) async {
    var newPerson = Contact();
    newPerson.givenName = a;
    await ContactsService.addContact(newPerson);

    setState(() {
      name.add(a);
    });
  }

  @override
  build(context) {
    return Scaffold(
        appBar: AppBar( title: Text(total.toString()), actions: [
          IconButton(onPressed: (){ getPermission(); }, icon: Icon(Icons.contacts))
        ],),
        body: ListView.builder(
              itemCount: name.length,
              itemBuilder: (c, i){
                return ListTile(
                  leading: Image.asset('assets/BaekJoon.png'),
                  title: Text(name[i].givenName ?? '이름이없는놈'),
                );
                }
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            showDialog(context: context, builder: (context){
              return DialogUI( addName : addName,);
            });
          },
        ),
      );

  }
}

class DialogUI extends StatelessWidget {
  DialogUI({super.key, this.addName});
  final addName;
  var inputData = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: 300,
        height: 300,
        child: Column(
          children: [
            TextField(
              controller: inputData,
              decoration: InputDecoration(
                hintText: 'hint',
                hintStyle: TextStyle(color: Colors.green),
                helperText: 'helper',
                labelText: 'label',
                counterText: 'counter'
              ),
            ),
            TextButton(
              child: Text('완료'),
              onPressed: (){
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
