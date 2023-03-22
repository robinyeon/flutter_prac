import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [Icon(Icons.phone), Icon(Icons.chat_bubble), Icon(Icons.person_2_rounded)],
      )
    );
  }
}


class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  var cnt = 0;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
     home: Scaffold(
       floatingActionButton: FloatingActionButton(
         child: Text('뽀짝'),
         onPressed: () { cnt++; print(cnt);},
       ),
       appBar: AppBar(),
       body: ListView.builder(
           itemCount: 3,
           itemBuilder: (context, index){
             return ListTile(
               leading: Icon(Icons.pets),
               title: Text('연라푸')
             );
           }
       ),
       bottomNavigationBar:BottomAppBar( child: Footer()),
     )
    );
  }
}
