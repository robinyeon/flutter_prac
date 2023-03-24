import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

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
  DialogUI({Key? key, this.addOne}) : super(key: key);
  final addOne;
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
                    if (inputData.text == "") {
                      // 빈칸으로 완료버튼 누르면 추가 안되는게끔.
                    }
                    addOne(inputData.text);
                    Navigator.pop(context);
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
  int likeCnt = 0;
  List<String> name = ['연다은봄', '연라푸', '연똥개'];

  addOne(newName) {
    setState(() {
      name.add(newName);
    });
  }

  getPermission() async {
    var contactStatus = await Permission.contacts.status;
    if (contactStatus.isGranted) {
      print('드디어 권한 설정 허락됨 으이구');
    } else if (contactStatus.isDenied) {
      print('연락처를 들여다보지 않았으면 좋겠다네요');
    } else if (contactStatus.isPermanentlyDenied) {
      openAppSettings();
    }
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
                  return DialogUI(
                    addOne: addOne,
                  );
                });
          },
        ),
        appBar: AppBar(
          title: Text('귀여운 연락처 '),
          actions: [
            IconButton(
                onPressed: () {
                  getPermission();
                },
                icon: Icon(Icons.contacts))
          ],
        ),
        body: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              SizedBox(height: 40),
              Text('가나다순'),
              TextButton(
                  onPressed: () {
                    // 이름 가나다순 정렬
                  },
                  child: Icon(Icons.arrow_drop_down))
            ]),
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: name.length,
              itemBuilder: (context, idx) {
                return ListTile(
                  leading: Text(likeCnt.toString()),
                  title: Text(name[idx]),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        child: Text('좋아요'),
                        onPressed: () {
                          setState(() {
                            likeCnt++;
                          });
                        },
                      ),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              name.removeAt(idx);
                            });
                          },
                          child:
                              Text('삭제', style: TextStyle(color: Colors.grey)))
                    ],
                  ),
                );
              },
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: Footer(),
        ));
  }
}
