import 'package:flutter/material.dart';
import 'package:calculator/screens/linechart.dart';
import 'package:calculator/styles.dart';
import 'package:flutter/services.dart';
import 'package:calculator/screens/notes.dart';
import 'package:calculator/screens/calendar.dart';
import 'allCharts.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:async';


class chart extends StatefulWidget {
  chart(this.email);
  String email;
  @override
  _chartState createState() => _chartState(email);
}

class _chartState extends State<chart> with SingleTickerProviderStateMixin{
  _chartState(this.email);
  int _selectedIndex = 0;
  DateTime dateTime;
  int Year;
  var dateFormat;
  var month;
  List t;
  String email;




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Firebase.initializeApp();
    dateTime = DateTime.now();
    dateFormat = DateFormat.MMM().format(dateTime);
    month = dateFormat;
    Year = dateTime.year;
    // print(month+Year.toString());
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
   List<Widget> _widgetOptions = <Widget>[
    home(),
     calendar(),
    notes(),

  ];


  @override
  Widget build(BuildContext context) {
    var mWidth = MediaQuery.of(context).size.width;
    var mHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: color2,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white,
        backgroundColor: color2,
        elevation: 0,
        items:[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Calculator',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: colorp,
        onTap: _onItemTapped,
      ),
    );
  }
}









class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> with SingleTickerProviderStateMixin{
  TabController _controller1;
  int _selectedIndex = 0;
  DateTime dateTime;
  var Year;
  var dateFormat;
  var month;
  var monthname;
  var day;
  bool edit_enter;
  var Tdvalue;
  bool refresh = false;
  bool edit = false;
  var tdychartvalue;
  double t1,t2;
  var profitvalue = 0;
  var p1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller1 = TabController(length: 2, vsync: this);
    dateTime = DateTime.now();
    dateFormat = DateFormat.MMM().format(dateTime);
    month = dateFormat;
    Year = dateTime.year.toString();
    monthname = month+Year;
    day =dateTime.day.toString();
    edit_enter = false;
    checkTodayValue();
    getPrev();
    if(day == '1'){
      newmonth(monthname);
    }
  }
  var _controller = TextEditingController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  getProfit() async{
    var docRef =  FirebaseFirestore.instance
        .collection('users')
        .doc('calculator')
        .collection('charts')
        .doc(monthname);
    var daycheck = await docRef.get();
    setState(() {
      p1 = daycheck.data()['profit'];
      // profitvalue = daycheck.data()['previous'];
    });
  }
  getPrev() async{
    var docRef =  FirebaseFirestore.instance
        .collection('users')
        .doc('calculator')
        .collection('charts')
        .doc(monthname);
    var daycheck = await docRef.get();
    setState(() {
      // p1 = daycheck.data()['profit'];
      profitvalue = daycheck.data()['previous'];
    });
  }
  checkTodayValue() async{
    var docRef =  FirebaseFirestore.instance
        .collection('users')
        .doc('calculator')
        .collection('charts')
        .doc(monthname)
        .collection('data')
        .doc(day);
    var daycheck = await docRef.get();
    if(daycheck.exists){

      setState(() {
        // profitvalue = FirebaseFirestore.instance.collection('users').doc('calculator').collection('charts').doc(monthname).get();
        edit_enter = true;
        // t1 = daycheck.data()['day']*1.0;
        // t2 = daycheck.data()['value']*1.0;
      });
    }
    else{
      // _refresh();
      await getProfit();
      await FirebaseFirestore.instance
          .collection('users')
          .doc('calculator')
          .collection('charts')
          .doc(monthname).update({
        'previous' : p1,
      });
      setState(() {
        // profitvalue = daycheck.data()['previous'];
        edit_enter = false;
      });
    }
  }
  Future<Null> _refresh() async{
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      refresh = false;
    });
    return null;
  }
  newmonth(String month) async{
    await FirebaseFirestore.instance
        .collection('users')
        .doc('calculator')
        .collection('charts')
        .doc(month)
        .collection('data')
        .doc('0').set({
      'date':0,
      'value':0,
    });
    await FirebaseFirestore.instance
        .collection('users')
        .doc('calculator')
        .collection('charts')
        .doc(month)
        .update({
      'profit':0,
    });
    await FirebaseFirestore.instance
    .collection('users')
    .doc('calculator')
    .collection('months')
    .doc().set(
      {
        'name':monthname,
      }
    );
  }
  List<FlSpot> monthspots = [
    FlSpot(1, 3),
    FlSpot(2, 2),
    FlSpot(3, 5),
    FlSpot(4, 3.1),
    FlSpot(5, 4),
    FlSpot(6, 3),
    FlSpot(7, -2),
    FlSpot(20, 2),
    FlSpot(25, 8),
    FlSpot(30, 8),
  ];

  List<FlSpot> weekspots = [
    FlSpot(1, 3),
    FlSpot(2, 2),
    FlSpot(3, 5),
    FlSpot(4, 3.1),
    FlSpot(5, 4),
    FlSpot(6, 3),
    FlSpot(7, -2),
  ];

  List<FlSpot> mspots = [];
  List<FlSpot> empty1 = [FlSpot(1, 5)];
  @override
  Widget build(BuildContext context) {
    var mWidth = MediaQuery.of(context).size.width;
    var mHeight = MediaQuery.of(context).size.height;
    return Container(
      color: color2,
      child: Column(
        children: [
          SizedBox(
            height: mHeight*0.05,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: Container(
                    width: mWidth * 0.1,
                    height: mHeight * 0.05,
                    decoration: nMbtn,
                    child: Icon(
                      Icons.person_rounded,
                      size: mWidth * 0.05,
                      color: colorp2,
                    ),
                  ),
                ),
                Material(
                  color: color2,
                  child: Text(
                    "stock",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: mWidth * 0.05,
                        color: colorp2
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>allCharts()));
                  },
                  child: Container(
                    width: mWidth * 0.1,
                    height: mHeight * 0.05,
                    decoration: nMbtn,
                    child: Icon(
                      Icons.show_chart,
                      size: mWidth * 0.05,
                      color: colorp2,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: mHeight*0.05,
          ),
          refresh?Container():StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc('calculator')
                  .collection('charts')
                  .doc(monthname)
                  .collection('data').orderBy('date')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.hasError) {
                  print("hi");
                  return Column(
                    children: [
                      Container(
                          height: mHeight*0.4,
                          width: mWidth*0.8,
                          child: Text("Enter value to start this month")),
                    ],
                  );
                }
                else {
                  //listItem = snapshot.data.documents;
                  List<Widget> graph_widgets = [];
                  final dates = snapshot.data.docs;
                  for(var date in dates){
                    var dayDate = date.data()['date'];
                    var dayValue = date.data()['value'];
                    mspots.add(FlSpot(dayDate*1.0,dayValue*1.0));
                    print(mspots.toSet().toList());
                  }
                  // print(Class.data()['money']);
                  // String money = Class.data()['money'];
                  // List value = Class.data()['dates'];
                  // name = Class.data()['month'];
                  // print(value);
                  //gettingImage(classroom_id);


                  final classCardWidget = lineChartMonth(mspots.toSet().toList());
                  graph_widgets.add(classCardWidget);

                  if(mspots.length>0) {
                    return Column(
                      children: graph_widgets,
                    );
                  }
                  else{
                    return LineChartSample2([FlSpot(1, 0)]);
                  }
                }
              }),
          SizedBox(
            height: mHeight*0.02,
          ),
          Text("$month"+" "+"$Year",
          style: TextStyle(
            color: Colors.white,
            fontSize: mHeight*0.02,
          ),),
          SizedBox(
            height: mHeight*0.05,
          ),
          Container(
            width: mWidth*0.8,
            height: mHeight*0.07,
            decoration: nMboxInvert,
            child: Row(
              children: [
                Container(
                  height: mHeight*0.5,
                  width: mWidth*0.1,
                  decoration: nMbtn,
                  child: Icon(Icons.attach_money,color: Colors.white,),
                ),
                SizedBox(width: mWidth*0.1,),
                Container(
                  width: mWidth*0.5,
                  child: Center(
                    child: TextField(
                      controller: _controller,
                      onChanged: (value){
                        print('hi');
                        setState(() {
                          Tdvalue = value;
                        });

                      },
                      keyboardType: TextInputType.number,
                      // inputFormatters: [
                      //   FilteringTextInputFormatter.digitsOnly,
                      // ],
                      style: TextStyle(
                          color: Colors.white
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: edit_enter?"Edit today's value":"Enter today's value",
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
            height: mHeight*0.05,
          ),
          edit_enter?
          GestureDetector(
            onTap: () async{
              await getPrev();
              // await mspots.removeRange(0,mspots.length-1);
              setState(() {
                mspots = [];
              });
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc('calculator')
                  .collection('charts')
                  .doc(monthname)
                  .collection('data')
                  .doc(day).delete();
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc('calculator')
                  .collection('charts')
                  .doc(monthname)
                  .collection('data')
                  .doc(day).set({
                'date':dateTime.day,
                'value':profitvalue+int.parse(Tdvalue),
              });
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc('calculator')
                  .collection('charts')
                  .doc(monthname)
                  .update({
                'profit':profitvalue+int.parse(Tdvalue),
              });
              _controller.clear();

              setState(() {
                // Tdvalue = null;
                refresh = true;
              });

              _refresh();
              _refresh();
              checkTodayValue();
            },
            child: Container(
              width: mWidth*0.8,
              height: mHeight*0.07,
              decoration: nMbox,
              child: Center(
                child: Text("EDIT",style: TextStyle(
                  color: colorp2,
                  fontSize: mHeight*0.03,
                  fontWeight: FontWeight.bold,
                ),),
              ),
            ),
          ):
          GestureDetector(
            onTap: () async{
              await getPrev();
              setState(() {
                mspots = [];
              });
              // checkTodayValue(1.toString());
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc('calculator')
                  .collection('charts')
                  .doc(monthname)
                  .collection('data')
                  .doc(day).set({
                'date':dateTime.day,
                'value':profitvalue+int.parse(Tdvalue),
              });
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc('calculator')
                  .collection('charts')
                  .doc(monthname)
                  .update({
                'profit':profitvalue+int.parse(Tdvalue),
              });
              _controller.clear();

              setState(() {
                // Tdvalue = null;
                refresh = true;
                profitvalue = profitvalue+int.parse(Tdvalue);
              });

              _refresh();
              checkTodayValue();
            },
            child: Container(
              width: mWidth*0.8,
              height: mHeight*0.07,
              decoration: nMbox,
              child: Center(
                child: Text("ADD",style: TextStyle(
                  color: colorp2,
                  fontSize: mHeight*0.03,
                  fontWeight: FontWeight.bold,
                ),),
              ),
            ),
          ),
          SizedBox(
            height: mHeight*0.05,
          ),

          refresh?Container():Container(
            height: mHeight * 0.15,
            width: mWidth * 0.8,
            decoration: nMboxInvert,
            child: Column(
              children: [
                Center(
                  child: Text(
                    "$profitvalue",
                    style: TextStyle(
                      fontSize: mHeight * 0.1,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  "Current Value",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),





        ],
      ),
    );
  }
}

