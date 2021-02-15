import 'package:flutter/material.dart';
import 'dart:ui';

const color1 = Color(0xFF273054);
const color2 = Color(0xff3E4770);
const color3 = Color(0xFF556296);
const color4 = Color(0xFF195AFC);
const color5 = Color(0xffCA1F2E);
const color6 = Color(0xff3e88cf);
const color7 = Color(0xff0f2840);
const color8 = Color(0xff87b7e6);
const colorp = Color(0xff23b6e6);
const colorp2 = Color(0xff02d39a);



Color mC = Colors.grey.shade100;
Color mCL = Colors.white;
Color mCD = Colors.black.withOpacity(0.075);
Color mCC = Colors.green;
Color fCD = Colors.grey.shade700;
Color fCL = Colors.grey;

BoxDecoration nMbox = BoxDecoration(
    borderRadius: BorderRadius.circular(15),
    // gradient: LinearGradient(
    //   begin: Alignment.topLeft,
    //   end:Alignment.bottomRight,
    //   colors:[mC,mCL],
    // ),
    color: color2,
    boxShadow: [
      BoxShadow(
        color: color1,
        offset: Offset(5, 5),
        blurRadius: 10,
      ),
      BoxShadow(
        color: color3,
        offset: Offset(-2, -2),
        blurRadius: 5,
      ),
    ]
);

BoxDecoration nMbox2= BoxDecoration(
    borderRadius: BorderRadius.circular(15),
    // gradient: LinearGradient(
    //   begin: Alignment.topLeft,
    //   end:Alignment.bottomRight,
    //   colors:[mC,mCL],
    // ),
    color: color6,
    boxShadow: [
      BoxShadow(
        color: color7,
        offset: Offset(5, 5),
        blurRadius: 10,
      ),
      BoxShadow(
        color: color8,
        offset: Offset(-2, -2),
        blurRadius: 5,
      ),
    ]
);



BoxDecoration nMboxInvert = BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    color: color1,
    boxShadow: [
      BoxShadow(
          color: color3,
          offset: Offset(3, 3),
          blurRadius: 3,
          spreadRadius: -3
      ),
    ]
);
BoxDecoration nMboxInvert2 = BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    color: color7,
    boxShadow: [
      BoxShadow(
          color: color8,
          offset: Offset(3, 3),
          blurRadius: 3,
          spreadRadius: -3
      ),
    ]
);

BoxDecoration nMboxInvertActive = nMboxInvert.copyWith(color: mCC);

BoxDecoration nMbtn = BoxDecoration(
    borderRadius: BorderRadius.circular(50),
    color: color2,
    boxShadow: [
      BoxShadow(
        color: color1,
        offset: Offset(2, 2),
        blurRadius: 2,
      )
    ]
);
BoxDecoration nMbtn2 = BoxDecoration(
    borderRadius: BorderRadius.circular(50),
    color: color6,
    boxShadow: [
      BoxShadow(
        color: color7,
        offset: Offset(2, 2),
        blurRadius: 2,
      )
    ]
);

final Shader linearGradient = LinearGradient(
  colors: <Color>[colorp, colorp2],
).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

TextStyle t = TextStyle(color: Colors.white);


const primaryColor = Color(0xff3E4770);
const secondaryColor = Color(0xff3E4770);
Alignment downRight = Alignment(0.9, 1.0);



class textBar extends StatelessWidget {
  textBar(this.hint,this.color,this.password);
  String hint;
  Color color;
  bool password;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
        child: TextField(
          onChanged: (value){

          },
          textAlign: TextAlign.center,
          obscureText: password,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            hintStyle: TextStyle(color: color),
          ),
        ),
      ),
    );
  }
}

class label extends StatelessWidget {
  label(this.lName);
  String lName;

  @override
  Widget build(BuildContext context) {
    return Text(
      lName,
      style: kLabelStyle,
    );
  }
}

class SubmitButtons extends StatelessWidget {
  SubmitButtons(this.name,this.style);
  String name;
  final style;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        decoration: style,
        height: 60.0,
        child: Text(
          name,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
          ),
        )
    );
  }
}

final kHintTextStyle = TextStyle(
  color: primaryColor,
  fontFamily: 'OpenSans',
);

final submitHintStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: primaryColor,
  fontWeight: FontWeight.bold,
  fontFamily: 'lemonada',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: primaryColor,
      blurRadius: 10.0,
      offset: Offset(0, 2),
    ),
  ],
);

final loginButtonStyle = BoxDecoration(
  color: primaryColor,
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: primaryColor,
      blurRadius: 10.0,
      offset: Offset(0, 2),
    ),
  ],
);

final signUpButtonStyle = BoxDecoration(
  color: secondaryColor,
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: secondaryColor,
      blurRadius: 10.0,
      offset: Offset(0, 2),
    ),
  ],
);

//Widget buildEmailTF() {
//  return Column(
//    crossAxisAlignment: CrossAxisAlignment.start,
//    children: <Widget>[
//      Text(
//        'Email',
//        style: kLabelStyle,
//      ),
//      SizedBox(height: 10.0),
//      Container(
//        alignment: Alignment.centerLeft,
//        decoration: kBoxDecorationStyle,
//        height: 60.0,
//        child: TextField(
//          keyboardType: TextInputType.emailAddress,
//          style: TextStyle(
//            color: Colors.black,
//            fontFamily: 'OpenSans',
//          ),
//          decoration: InputDecoration(
//            border: InputBorder.none,
//            contentPadding: EdgeInsets.only(top: 14.0),
//            prefixIcon: Icon(
//              Icons.email,
//              color: primaryColor,
//            ),
//            hintText: 'Enter your Email',
//            hintStyle: kHintTextStyle,
//          ),
//        ),
//      ),
//    ],
//  );
//}
//
//Widget buildPasswordTF() {
//  return Column(
//    crossAxisAlignment: CrossAxisAlignment.start,
//    children: <Widget>[
//      Text(
//        'Password',
//        style: kLabelStyle,
//      ),
//      SizedBox(height: 10.0),
//      Container(
//        alignment: Alignment.centerLeft,
//        decoration: kBoxDecorationStyle,
//        height: 60.0,
//        child: TextField(
//          obscureText: true,
//          style: TextStyle(
//            color: Colors.black,
//            fontFamily: 'OpenSans',
//          ),
//          decoration: InputDecoration(
//            border: InputBorder.none,
//            contentPadding: EdgeInsets.only(top: 14.0),
//            prefixIcon: Icon(
//              Icons.lock,
//              color: primaryColor,
//            ),
//            hintText: 'Enter your Password',
//            hintStyle: kHintTextStyle,
//          ),
//        ),
//      ),
//    ],
//  );
//}
//
//Widget Login_Button(){
//  return SubmitButtons("Login",loginButtonStyle);
//}



//Widget SignUp_Button(){
//  return Container(
//      alignment: Alignment.center,
//      decoration: signUpButtonStyle,
//      height: 60.0,
//      child: Text(
//        "Sign Up",
//        textAlign: TextAlign.center,
//        style: TextStyle(
//          color: Colors.white,
//          fontSize: 17.0,
//          fontWeight: FontWeight.bold,
//        ),
//      )
//  );
//}

final textFieldStyle = TextStyle(
  color: Colors.black,
  fontFamily: 'OpenSans',
);

final textFieldInputDecoration_email = InputDecoration(
  border: InputBorder.none,
  contentPadding: EdgeInsets.only(top: 14.0),
  prefixIcon: Icon(
    Icons.email,
    color: primaryColor,
  ),
  hintText: 'Enter your Email',
  hintStyle: kHintTextStyle,
);

final textFieldInputDecoration_password = InputDecoration(
  border: InputBorder.none,
  contentPadding: EdgeInsets.only(top: 14.0),
  prefixIcon: Icon(
    Icons.lock,
    color: primaryColor,
  ),
  hintText: 'Enter your Password',
  hintStyle: kHintTextStyle,
);

final textFieldInputDecoration_username = InputDecoration(
  border: InputBorder.none,
  contentPadding: EdgeInsets.only(top: 14.0),
  prefixIcon: Icon(
    Icons.account_circle,
    color: primaryColor,
  ),
  hintText: 'Enter your Name',
  hintStyle: kHintTextStyle,
);

final textFieldInputDecoration_confirmPassword = InputDecoration(
  border: InputBorder.none,
  contentPadding: EdgeInsets.only(top: 14.0),
  prefixIcon: Icon(
    Icons.lock,
    color: primaryColor,
  ),
  hintText: 'Re-enter the password',
  hintStyle: kHintTextStyle,
);


List<List> gradienColor = [
  [const Color(0xFF000046), const Color(0xFF1CB5E0)],
  [const Color(0xFFf09819), const Color(0xFFedde5d)],
  [const Color(0xFFB2FEFA), const Color(0xFF0ED2F7)],
  [const Color(0xFF1d976c), const Color(0xFF93f9b9)],
  [const Color(0xFFD66D75), const Color(0xFFE29587)],
  [const Color(0xFF20002c), const Color(0xFFcbb4d4)],
  [const Color(0xFF093637), const Color(0xFF44A08D)],
  [const Color(0xFFff5f6d), const Color(0xFFffc371)],
  [const Color(0xFFfbd3e9), const Color(0xFFbb377d)],
  [const Color(0xFF33ccff), const Color(0xFFffccff)],
  [const Color(0xFFb993d6), const Color(0xFF8ca6db)],
  [const Color(0xFF616161), const Color(0xFF9bc5c3)],
  [const Color(0xFF603813), const Color(0xFFb29f94)],
  [const Color(0xFFf12711), const Color(0xFFf5af19)],
];