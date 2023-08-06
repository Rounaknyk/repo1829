import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pinput/pinput.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  return runApp( MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Test(),
    );
  }
}

class Test extends StatefulWidget {

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {

  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  String? verId;
  TextEditingController controller = TextEditingController();

  postToken(token, url) async {
    try {
      Map data = {'token': token};
      String encodedData = json.encode(data);
      http.Response response = await http.post(
          Uri.parse(url), body: encodedData,
          headers: {"Content-Type": "application/json"});
      print(response);
    }
    catch(e){
      print(e);
    }
  }

  Future<User?> signInWithGoogle({required BuildContext context}) async {
    // setState(() {
    //   isLoading = true;
    // });
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
    await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        await auth.signInWithCredential(credential);

        String? token = await auth.currentUser?.getIdToken();
        postToken(token, '');

      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          print(e);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              '$e',
              style: TextStyle(fontFamily: 'Gilroy',fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),);
          // handle the error here
        } else if (e.code == 'invalid-credential') {
          // handle the error here
          print(e);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              '$e',
              style: TextStyle(fontFamily: 'Gilroy',fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),);
        }
        else{
          print(e);
        }
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            '$e',
            style: TextStyle(fontFamily: 'Gilroy',fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),);
        // handle the error here
      }
    }


    return user;
  }

  Future<void> verifyCode() async {
    try{
      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verId!, smsCode: controller.text);
      await auth.signInWithCredential(credential);
      String? token = await auth.currentUser?.getIdToken().toString();
      postToken(token, '');
    }
    catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          '$e',
          style: TextStyle(fontFamily: 'Gilroy',fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),);
    }
  }

  Future<void> sendCode(BuildContext context, number, {countryCode = '+91'}) async {

    await auth.verifyPhoneNumber(
      phoneNumber: '${countryCode+number}',
      verificationCompleted: (PhoneAuthCredential credential) async {
      },
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            '$e',
            style: TextStyle(fontFamily: 'Gilroy',fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),);
      },
      codeSent: (String verificationId, int? resendToken) {
        setState((){
          // codeSent = true;
          verId = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () async {
              user = await signInWithGoogle(context: context);
            }, child: Text('Google Sign In')),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: (){
              sendCode(context, '9322942635');
            }, child: Text('Send Otp on 9322942635')),
            SizedBox(height: 10,),
            Pinput(length: 6, controller: controller,),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}


