import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hill_des_encryption/widget/AppTextField.dart';

import 'helper/helpers.dart';
import 'helper/shared_component.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> with Helpers {
  String? title, note,imageUrl;

  File? file;
  // Reference? ref;
  GlobalKey<FormState> formState=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Note"),
        elevation: 5,
      ),
      body: Form(
        key: formState,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10),
          children: [
            SizedBox(
              height: 20,
            ),
            AppTextField(
                hintText: "Note Title",
                icon: Icons.title,
                validationFn: (val) {
                  if (val != null && val.length > 100) {
                    return "Title can not to be larger than 100";
                  } else if (val != null && val.length < 3) {
                    return "Title can not to be less than 3";
                  }
                  return null;
                },
                savedFn: (val) {
                  title = val;
                }),
            SizedBox(
              height: 10,
            ),
            AppTextField(
                hintText: "Note Details",
                icon: Icons.description,
                maxLine: 5,
                validationFn: (val) {
                  if (val != null && val.length > 300) {
                    return "Note Details can not to be larger than 300";
                  } else if (val != null && val.length < 3) {
                    return "Note Details can not to be less than 3";
                  }
                  return null;
                },
                savedFn: (val) {
                  note = val;
                }),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: ElevatedButton(
                  child: Text(
                    "Upload Image",
                    style: TextStyle(fontSize: 18,color:Colors.teal.shade300),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    primary: /*Colors.teal.shade300*/Colors.grey.shade200,
                    // shape: RoundedRectangleBorder(
                    //     borderRadius:
                    //     BorderRadiusDirectional.all(Radius.circular(20))),
                  ),
                  onPressed: () /*async*/ {
                    // await signIn();
                    viewImage();
                  }),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                child: Text(
                  "Add Note",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  primary: Colors.teal.shade500,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadiusDirectional.all(Radius.circular(20))),
                ),
                onPressed: () async {
                  // await signIn();
                  await addNote();
                }),
          ],
        ),
      ),
    );
  }

  void viewImage() {
    // showModalBottomSheet<void>(
    //     clipBehavior: Clip.antiAlias,
    //     enableDrag: true,
    //     constraints: BoxConstraints(minHeight: 100),
    //     context: context,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.vertical(
    //         top: Radius.circular(20),
    //       ),
    //     ),
    //     builder: (BuildContext context) {
    //       return Card(
    //           // clipBehavior: Clip.antiAliasWithSaveLayer,
    //           shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.all(Radius.circular(15))),
    //           child: Column(
    //               // mainAxisAlignment: MainAxisAlignment.center,
    //               mainAxisSize: MainAxisSize.min,
    //               children: <Widget>[
    //                 Container(
    //                   clipBehavior: Clip.antiAlias,
    //                   decoration: BoxDecoration(color: Colors.grey.shade200,
    //                       borderRadius: BorderRadius.circular(15)),
    //                   child: Column(children: [
    //                     Container(
    //                       child: Text(
    //                         "Add Image",
    //                         style: TextStyle(
    //                             fontSize: 22,
    //                             fontWeight: FontWeight.bold,
    //                             color: Colors.white),
    //                       ),
    //                       alignment: Alignment.center,
    //                       color: Colors.teal.shade600,
    //                     ),
    //                     SizedBox(
    //                       height: 10,
    //                     ),
    //                     Card(
    //                         margin: EdgeInsets.zero,
    //                         clipBehavior: Clip.antiAlias,
    //                         elevation: 20,
    //                         color: Colors.grey.shade200,
    //                         //getColor(),
    //                         shape: RoundedRectangleBorder(
    //                             borderRadius: BorderRadiusDirectional.vertical(
    //                                 bottom: Radius.circular(15)),
    //                             // borderRadius: BorderRadius.circular(15),
    //                             /*side: BorderSide(width: 2)*/),
    //                         child: Container(
    //                             height: 100,
    //                             child: Column(
    //                                 mainAxisAlignment:
    //                                     MainAxisAlignment.spaceBetween,
    //                                 children: [
    //                                   ElevatedButton(
    //                                     child: Row(
    //                                       children: [
    //                                         IconButton(
    //                                             onPressed: () {},
    //                                             icon: Icon(Icons.image,color: Colors.teal.shade300)),
    //                                         SizedBox(
    //                                           width: 20,
    //                                         ),
    //                                         Text("From Gallery",style: TextStyle(color: Colors.teal.shade300),),
    //                                       ],
    //                                     ),
    //                                     onPressed: ()async{
    //                                       XFile? imagePicker= await ImagePicker().pickImage(source: ImageSource.gallery);
    //                                       if(imagePicker!=null){
    //                                         // SharedComponent.showLoading(context);
    //                                         file=File(imagePicker.path);
    //                                         var imageName="image"+Random().nextInt(1000).toString();
    //                                          ref=FirebaseStorage.instance.ref("images/${imageName}");
    //                                         Navigator. pop(context);
    //                                         // Navigator.of(context).pop();
    //                                       }
    //                                       // print("clicked");
    //                                     },
    //                                     style: ElevatedButton.styleFrom(
    //                                         primary: Colors.grey.shade200,),
    //                                   ),
    //                                   // SizedBox(height: 10,),
    //                                   ElevatedButton(
    //                                     child: Row(
    //                                       children: [
    //                                         IconButton(
    //                                             onPressed: ()async {
    //                                               XFile? imagePicker= await ImagePicker().pickImage(source: ImageSource.camera);
    //                                               if(imagePicker!=null){
    //                                                 file=File(imagePicker.path);
    //                                                 var imageName="image"+Random().nextInt(1000).toString();
    //                                                 ref=FirebaseStorage.instance.ref("images/${imageName}");
    //
    //                                               Navigator.pop(context);
    //                                               }
    //                                             },
    //                                             icon: Icon(Icons.camera_alt,color: Colors.teal.shade300,)),
    //                                         SizedBox(
    //                                           width: 20,
    //                                         ),
    //                                         Text("From Camera",style: TextStyle(color: Colors.teal.shade300,),),
    //                                       ],
    //                                     ),
    //                                     onPressed: ()async {
    //                                       XFile? imagePicker= await ImagePicker().pickImage(source: ImageSource.camera);
    //                                       if(imagePicker!=null){
    //                                         file=File(imagePicker.path);
    //                                         var imageName="image"+Random().nextInt(1000).toString();
    //                                         ref=FirebaseStorage.instance.ref("images/${imageName}");
    //                                         Navigator.pop(context);
    //                                       }
    //                                     },
    //                                     style: ElevatedButton.styleFrom(
    //                                         primary: Colors.grey.shade200),
    //                                   ),
    //                                 ]
    //                                 // child: ListView(
    //                                 // padding: EdgeInsets.symmetric(horizontal: 20),
    //                                 // children: [
    //                                 // Row(
    //                                 // children: [
    //                                 // Icon(Icons.person),
    //                                 // SizedBox(
    //                                 // width: 10,
    //                                 // ),
    //                                 // Text("",
    //                                 // style: TextStyle(
    //                                 // fontSize: 20,
    //                                 // color: Colors.black,
    //                                 // fontWeight: FontWeight.w500,
    //                                 // ),
    //                                 // ),
    //                                 // ]
    //                                 // ),
    //                                 // ]),),
    //                                 ))),
    //                   ]),
    //                 )
    //               ]));
    //     });
  }

  Future<void> addNote()async {
    // if(formState.currentState!.validate()){
    //   formState.currentState!.save();
    //
    //   if(file!=null && ref!=null){
    //     SharedComponent.showLoading(context);
    //     UploadTask uploadTask=ref!.putFile(file!);
    //     imageUrl=await (await uploadTask).ref.getDownloadURL();
    //     int noteRandom=Random().nextInt(1000);
    //     CollectionReference noteRef=FirebaseFirestore.instance.collection("notes");
    //     await noteRef.add({"title":title,"note":note,"imageUrl":imageUrl,
    //       "userId":FirebaseAuth.instance.currentUser!.uid}).then((value){
    //       showSnackBar(context: context, message: "The Note has been added",error: false);
    //       title="";
    //       note="";
    //       file=null;
    //       ref=null;
    //       formState.currentState!.reset();
    //     }).onError((error, stackTrace) {
    //       showSnackBar(context: context, message: "Failed:${error.toString()}",error: true);
    //     });
    //     Navigator.of(context).pop();
    //   }else{
    //     showSnackBar(context: context, message: "You must add an image",error: true);
    //
    //   }
    //
    //
    // }
  }
}
//***************