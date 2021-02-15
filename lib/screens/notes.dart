import 'package:flutter/material.dart';
import 'package:calculator/styles.dart';
import 'package:flutter/services.dart';

class notes extends StatefulWidget {
  @override
  _notesState createState() => _notesState();
}

class _notesState extends State<notes> {
  List<String> options = <String>['One', 'Two', 'Free', 'Four'];
  String dropdownValue = 'One';

  @override
  Widget build(BuildContext context) {
    var mWidth = MediaQuery.of(context).size.width;
    var mHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(
          height: mHeight * 0.07,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: mWidth * 0.8,
                child: Center(
                  child: Text(
                    "Position Size Calculator",
                    style: TextStyle(
                      fontSize: mWidth * 0.05,
                      fontWeight: FontWeight.bold,
                      color: colorp2,
                    ),
                  ),
                )),
          ],
        ),
        SizedBox(
          height: mHeight * 0.05,
        ),
        Container(
          height: mHeight * 0.15,
          width: mWidth * 0.8,
          decoration: nMboxInvert,
          child: Column(
            children: [
              Center(
                child: Text(
                  "0.00",
                  style: TextStyle(
                    fontSize: mHeight * 0.1,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                "USD",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: mHeight * 0.05,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: mHeight * 0.15,
              width: mWidth * 0.35,
              decoration: nMboxInvert,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: Text(
                      "0.00",
                      style: TextStyle(
                        fontSize: mHeight * 0.05,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    "Units",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: mHeight * 0.15,
              width: mWidth * 0.35,
              decoration: nMboxInvert,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: Text(
                      "0.00",
                      style: TextStyle(
                        fontSize: mHeight * 0.05,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    "Lots",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        SizedBox(
          height: mHeight * 0.05,
        ),
        Container(
          height: mHeight * 0.07,
          width: mWidth * 0.8,
          decoration: nMboxInvert,
          child: Center(
            child: Container(
              width: mWidth*0.7,
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                value: dropdownValue,
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                  });
                },
                style: TextStyle(color: Colors.blue),
                selectedItemBuilder: (BuildContext context) {
                  return options.map((String value) {
                    return Text(
                      dropdownValue,
                      style: TextStyle(color: Colors.white),
                    );
                  }).toList();
                },
                items: options.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
        ),

        SizedBox(
          height: mHeight * 0.05,
        ),
        Container(
          width: mWidth * 0.8,
          height: mHeight * 0.07,
          decoration: nMboxInvert,
          child: Row(
            children: [
              Container(
                height: mHeight * 0.5,
                width: mWidth * 0.1,
                decoration: nMbtn,
                child: Icon(
                  Icons.attach_money,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: mWidth * 0.1,
              ),
              Container(
                width: mWidth * 0.5,
                child: Center(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter today's value",
                      hintStyle: TextStyle(
                        color: color3,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(
          height: mHeight * 0.05,
        ),
        Container(
          width: mWidth * 0.8,
          height: mHeight * 0.07,
          decoration: nMboxInvert,
          child: Row(
            children: [
              Container(
                height: mHeight * 0.5,
                width: mWidth * 0.1,
                decoration: nMbtn,
                child: Icon(
                  Icons.attach_money,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: mWidth * 0.1,
              ),
              Container(
                width: mWidth * 0.5,
                child: Center(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter today's value",
                      hintStyle: TextStyle(
                        color: color3,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(
          height: mHeight * 0.05,
        ),
        Container(
          width: mWidth * 0.8,
          height: mHeight * 0.07,
          decoration: nMboxInvert,
          child: Row(
            children: [
              Container(
                height: mHeight * 0.5,
                width: mWidth * 0.1,
                decoration: nMbtn,
                child: Icon(
                  Icons.attach_money,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: mWidth * 0.1,
              ),
              Container(
                width: mWidth * 0.5,
                child: Center(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter today's value",
                      hintStyle: TextStyle(
                        color: color3,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(
          height: mHeight * 0.05,
        ),
        Container(
          height: mHeight * 0.07,
          width: mWidth * 0.8,
          decoration: nMboxInvert,
          child: Center(
            child: Container(
              width: mWidth*0.7,
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                value: dropdownValue,
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                  });
                },
                style: TextStyle(color: Colors.blue),
                selectedItemBuilder: (BuildContext context) {
                  return options.map((String value) {
                    return Text(
                      dropdownValue,
                      style: TextStyle(color: Colors.white),
                    );
                  }).toList();
                },
                items: options.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
        ),

        SizedBox(
          height: mHeight * 0.05,
        ),
        Container(
          width: mWidth * 0.8,
          height: mHeight * 0.07,
          decoration: nMboxInvert,
          child: Row(
            children: [
              Container(
                height: mHeight * 0.5,
                width: mWidth * 0.1,
                decoration: nMbtn,
                child: Icon(
                  Icons.attach_money,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: mWidth * 0.1,
              ),
              Container(
                width: mWidth * 0.5,
                child: Center(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter today's value",
                      hintStyle: TextStyle(
                        color: color3,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(
          height: mHeight * 0.05,
        ),
        Container(
          width: mWidth*0.8,
          height: mHeight*0.07,
          decoration: nMbox,
          child: Center(
            child: Text("CALCULATE",
              style: TextStyle(
                color: colorp2,
                fontSize: mWidth*0.05,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        SizedBox(
          height: mHeight*0.1,
        ),
      ],
    );
  }
}
