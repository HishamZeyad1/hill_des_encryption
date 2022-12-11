import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_des/flutter_des.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CollectionReference noteref = FirebaseFirestore.instance.collection("message");
  var pressedNote;
  String? _decrypt;
  static const _key = "u1BvOHzUOcklgNpn1MaWvdn9DT4LyzSX";
  static const _iv = "12345678";
  Uint8List? _encrypt;
  String? _decryptHex;
  @override
  void initState() {
    print("=========initState=========");
    // TODO: implement initState
    super.initState();
    // crypt([122,34,5]);
  }
  Future<String?> crypt(String? encrypt) async {

    try {
      // _decrypt = (await FlutterDes.decrypt(encrypt!, _key, iv: _iv))!;
      _decryptHex = (await FlutterDes.decryptFromHex(encrypt, _key, iv: _iv))!;

      print("**********************************");
      print(_decryptHex);

      // setState(() {});
      return _decryptHex;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context){
    print("UID: "+FirebaseAuth.instance.currentUser!.uid);
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        leading: Icon(Icons.home),
        title: Text("Home"),
        actions: [
          IconButton(
              onPressed: () async {
                print("Before logout:");
                bool logged = FirebaseAuth.instance.currentUser != null;
                print("is logged:$logged");
                await FirebaseAuth.instance.signOut();

                print("After logout:");
                logged = FirebaseAuth.instance.currentUser != null;
                print("is logged:$logged");
                Navigator.pushNamed(context, "/login_screen");
              },
              icon: Icon(Icons.logout))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/des_cipher");
        },
        child: Icon(
          Icons.add,
        ),
      ),
      body: Container(
        color: Colors.grey.shade300,
        child: StreamBuilder(
            stream: noteref.orderBy('created_at',descending: false).snapshots(),
            builder: (context, snapshot){
              if (snapshot.connectionState == ConnectionState.waiting) {
                print("1");
                // return Center(child: CircularProgressIndicator(value: 20,color: Colors.blue,strokeWidth: 2.2,));
                return Container(alignment: Alignment.center,child: CircularProgressIndicator());
              }
              else if(snapshot.hasData&&snapshot.data!=null){
                print("2");
                print(snapshot.hasData);
                QuerySnapshot querySnapshot=snapshot.data as QuerySnapshot;
              List<QueryDocumentSnapshot> docs=querySnapshot.docs;
                print(docs.length);
                return docs.length!=0?
                 ListView.builder(itemBuilder: (context, index){
                   String text=docs[index]['text'].toString();
                   String senderId=docs[index]['senderId'].toString();
                   String textencrption=docs[index]['textencrption'].toString();
                   String _encryptHex=docs[index]['encryptHex'].toString();

                   // const _key = "u1BvOHzUOcklgNpn1MaWvdn9DT4LyzSX";
                   // const _iv = "12345678";
                   final List<int> codeUnits = textencrption.codeUnits;
                   final Uint8List unit8List = Uint8List.fromList(codeUnits);
                   Future<String?> _decrypt;
                   try{
                    _decrypt =crypt(_encryptHex);
                   }catch(e){print(e.toString());}

                   // String documentId=docs[index].id;

                   // QuerySnapshot querySnapshot=FirebaseFirestore.instance.collection("users").where("userId",isEqualTo:senderId).snapshots() as QuerySnapshot<Map<String, dynamic>>;
                   // QueryDocumentSnapshot docs1=querySnapshot.docs[0];
                   // String username=docs1[0]['username'].toString();
                   bool isSender=FirebaseAuth.instance.currentUser!.uid==senderId;

                return GestureDetector(
                  child: Column(
                    children: [
                    SizedBox(
                    height: 5,
                    ),
                    Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                    15), /*side: BorderSide(color: Colors.teal)*/
                    ),
                    child:ListTile(
                    horizontalTitleGap: 15,
                    minVerticalPadding: 0,
                    contentPadding: EdgeInsets.all(10),
                    /*minLeadingWidth: 0,*/
                    leading: Container(
                    // color: Colors.green,
                    // width: 77,
                    // height: 77,
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    // constraints: BoxConstraints(minWidth: 120,minHeight: 120,maxHeight: 200,maxWidth: 200,),
                      child:Icon(Icons.person,color:isSender?Colors.green:Colors.blue ,),

                      // Image.network(//imageUrl,"https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg" /*"images/3.png"*/,
                      // fit: BoxFit.cover, /*width: 200,height: 200,*/
                      // ),
                    ),
                    title: StreamBuilder(
                      stream:FirebaseFirestore.instance.collection("users").where("userId",isEqualTo:senderId).snapshots() ,
                        builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Container(alignment: Alignment.center,child: CircularProgressIndicator());
                                }
                                else if(snapshot.hasData&&snapshot.data!=null){
                                  QuerySnapshot querySnapshot=snapshot.data as QuerySnapshot;
                                  List<QueryDocumentSnapshot> docs=querySnapshot.docs;
                                  String username=docs[0]['username'].toString();

                                  // QuerySnapshot querySnapshot=FirebaseFirestore.instance.collection("users").where("userId",isEqualTo:senderId).snapshots() as QuerySnapshot<Map<String, dynamic>>;
                                  // QueryDocumentSnapshot docs1=querySnapshot.docs[0];
                                  // String username=docs1[0]['username'].toString();
                                  // bool isSender=FirebaseAuth.instance.currentUser!.uid==senderId;

                                  return docs.length!=0?Text(username,style: TextStyle(color: isSender?Colors.green:Colors.blue),):
                                  Container(
                                    // width: 200,
                                    // height: 200,
                                    // color: Colors.black,
                                    alignment: Alignment.center,
                                    child: Text("No Data"),
                                  );
                                }
                                else if(snapshot.hasError){
                                  print("3");
                                  return Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    alignment: Alignment.center,
                                    child: Text("Something Error has occurred "),
                                  );
                                }
                                else{
                                  print("4");
                                  return Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    color: Colors.black,
                                    alignment: Alignment.center,
                                    child: Text("No Data"),
                                  );
                                }
                        },
                        // child: Text(username,style: TextStyle(color: isSender?Colors.green:Colors.blue),/*"Title"*/),
                    ),
                    subtitle: FutureBuilder<String?>(
                      future:FlutterDes.decryptFromHex(_encryptHex, _key, iv: _iv)/*FlutterDes.decrypt(unit8List!, _key, iv: _iv)*/,
                      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                        print("1");
                        // return Center(child: CircularProgressIndicator(value: 20,color: Colors.blue,strokeWidth: 2.2,));
                        return Container(alignment: Alignment.center,child: CircularProgressIndicator());
                        }
                        else if(snapshot.hasData&&snapshot.data!=null){
                          String? data=snapshot.data;
                          print(data);
                          return data!=""?Text(
                            /*textencrption*/snapshot.data!,style: TextStyle(color: isSender?Colors.green.shade300:Colors.blue.shade300),
                            // "consistent pageview and exposes a pageToken that allows control over when to fetch additional results",
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis):Text("empty");
                        }
                        else if(snapshot.hasError){
                          print("3");
                          return Container(
                            width: double.infinity,
                            height: double.infinity,
                            alignment: Alignment.center,
                            child: Text("Something Error has occurred "),
                          );
                        }
                        else{
                          print("4");
                          return Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: Colors.black,
                            alignment: Alignment.center,
                            child: Text("No Data"),
                          );
                        }
                      },
                      // child: Text(
                      //     textencrption,style: TextStyle(color: isSender?Colors.green.shade300:Colors.blue.shade300),
                      // // "consistent pageview and exposes a pageToken that allows control over when to fetch additional results",
                      // maxLines: 3,
                      // overflow: TextOverflow.ellipsis),
                    ),
                    ),
                    ),
                    ]
                  ),
                  onTap: (){
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => ViewNoteDetails(title: title, note: note, imageUrl: imageUrl),));
                  },
                );
              },itemCount:docs.length ,):
              Container(
                // width: 200,
                // height: 200,
                // color: Colors.black,
                alignment: Alignment.center,
                child: Text("No Data"),
              );
              }
              else if(snapshot.hasError){
                print("3");
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  alignment: Alignment.center,
                  child: Text("Something Error has occurred "),
                );
              }
              else{
                print("4");
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black,
                  alignment: Alignment.center,
                  child: Text("No Data"),
                );
              }
            },
        ),
      ),
    );
  }
}
