import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class Footer extends StatelessWidget {
  Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.phone),
          Icon(Icons.chat_bubble),
          Icon(Icons.person)
        ],
      ),
    );
  }
}

class DialogUI extends StatelessWidget {
  DialogUI({Key? key, this.myvar, this.increment, this.nameList}) : super(key: key);
  final myvar;
  final increment;
  final nameList;
  var inputData = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Container(
      padding: EdgeInsets.all(20),
      width: 400,
      height: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: TextField(
              controller: inputData,
              decoration: InputDecoration(
                hintText: 'Enter your name :)',
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red, fixedSize: Size(80, 40)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('취소')),
              ElevatedButton(
                  onPressed: () {
                    increment();
                    nameList.add(inputData.text);
                  },
                  style: ElevatedButton.styleFrom(fixedSize: Size(80, 40)),
                  child: Text('완료'))
            ],
          )
        ],
      ),
    ));
  }
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var likeCnts = [0, 0, 0];
  var name = ['연다은봄', '연라푸', '연똥개'];
  var somethingcool = 0;
  increment() {
    setState(() {
      somethingcool++;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Text('Pop-up'),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return DialogUI(myvar: somethingcool, increment: increment, nameList: name);
                });
          },
        ),
        appBar: AppBar(),
        body: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, idx) {
            return ListTile(
              leading: Text(likeCnts[idx].toString()),
              title: Text(name[idx]),
              trailing: ElevatedButton(
                child: Text('좋아요'),
                onPressed: () {
                  setState(() {
                    likeCnts[idx]++;
                  });
                },
              ),
            );
          },
        ),
        bottomNavigationBar: BottomAppBar(
          child: Footer(),
        ));
  }
}
