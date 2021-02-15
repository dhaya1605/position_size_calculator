import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:calculator/styles.dart';
import 'package:flutter/services.dart';
import 'linechart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class allCharts extends StatefulWidget {
  @override
  _allChartsState createState() => _allChartsState();
}

class _allChartsState extends State<allCharts>
    with SingleTickerProviderStateMixin {
  TabController _controller1;
  List<String> options = [];
  String dropdownValue = 'One';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller1 = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var mWidth = MediaQuery.of(context).size.width;
    var mHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: color2,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: color2,
        title: Text(
          "Previous Stats",
          style: TextStyle(
            color: colorp2,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: mHeight * 0.02,
              ),
              Container(
                width: mWidth * 0.5,
                height: mHeight * 0.05,
                child: Material(
                  color: color2,
                  child: TabBar(
                    indicatorWeight: 2.0,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: color2,
                    controller: _controller1,
                    tabs: [
                      Tab(
                        child: Container(
                          width: mWidth * 0.2,
                          height: mHeight * 0.03,
                          decoration: nMbtn,
                          child: Center(child: Text("Overall")),
                        ),
                      ),
                      Tab(
                        child: Container(
                          width: mWidth * 0.2,
                          height: mHeight * 0.03,
                          decoration: nMbtn,
                          child: Center(child: Text("Month")),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: mHeight * 1.5,
                width: mWidth,
                child: TabBarView(
                  controller: _controller1,
                  children: [
                    // Container(
                    //     height: mHeight*0.4,
                    //     width: mWidth*0.8,
                    //     child: lineChartMonth([FlSpot(1, 5)])),
                    // week(),
                    sixMoths(),
                    months(),
                  ],
                ),
              ),
              SizedBox(
                height: mHeight * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class months extends StatefulWidget {
  List options = [];
  @override
  _monthsState createState() => _monthsState();
}

class _monthsState extends State<months> {
  var p1;
  bool refresh = false;
  List<FlSpot> mspots = [];
  List<String> options = [];
  String dropdownValue = 'last 6 months';
  months1() async{
    await FirebaseFirestore.instance
        .collection('users').doc('calculator').collection('months')
        .get()
        .then((QuerySnapshot querySnapshot) => {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          options.add(doc['name']);
        });
      })
    });
    print(options);

    // setState(() {
    //   p1 = daycheck.data()['profit'];
    //   // profitvalue = daycheck.data()['previous'];
    // });
  }
  getProfit() async{
    var docRef =  FirebaseFirestore.instance
        .collection('users')
        .doc('calculator')
        .collection('charts')
        .doc(dropdownValue);
    var daycheck = await docRef.get();
    setState(() {
      p1 = daycheck.data()['profit'];
      // profitvalue = daycheck.data()['previous'];
    });
  }
  Future<Null> _refresh() async{
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      refresh = false;
    });
    return null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    months1();
    getProfit();
  }

  @override
  Widget build(BuildContext context) {
    var mWidth = MediaQuery.of(context).size.width;
    var mHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: mHeight * 0.02,
        ),
        refresh?Container():StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc('calculator')
                .collection('charts')
                .doc(dropdownValue)
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
          height: mHeight * 0.02,
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: mHeight * 0.07,
              width: mWidth * 0.8,
              decoration: nMboxInvert,
              child: Center(
                child: Container(
                  width: mWidth * 0.7,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    value: dropdownValue,
                    onChanged: (String newValue) {
                      setState(() {
                        refresh = true;
                        // mspots = [];
                        dropdownValue = newValue;
                      });
                      _refresh();

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
                    items:
                        options.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: mHeight * 0.03,
        ),
        // LineChartSample2(),
        SizedBox(
          height: mHeight * 0.03,
        ),
        Container(
          height: mHeight * 0.15,
          width: mWidth * 0.8,
          decoration: nMboxInvert,
          child: Column(
            children: [
              Center(
                child: Text(
                  "$p1",
                  style: TextStyle(
                    fontSize: mHeight * 0.1,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                "Overall Profit",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: mHeight * 0.03,
        ),
      ],
    );
  }
}

class sixMoths extends StatefulWidget {
  @override
  _sixMothsState createState() => _sixMothsState();
}

class _sixMothsState extends State<sixMoths> {
  var p1;
  bool refresh = false;
  List<FlSpot> mspots = [];
  List<String> options = [];
  @override
  Widget build(BuildContext context) {
    var mWidth = MediaQuery.of(context).size.width;
    var mHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: mHeight * 0.02,
        ),
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc('calculator')
                .collection('charts')
                .orderBy('date',descending: true).limit(6)
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
                var monthCounter = 1;
                for(var date in dates){
                  // var dayDate = date.data()['date'];
                  var dayValue = date.data()['profit'];
                  mspots.add(FlSpot(monthCounter*1.0,dayValue*1.0));
                  monthCounter+=1;
                  print(monthCounter);
                  print(dayValue);
                }
                // print(Class.data()['money']);
                // String money = Class.data()['money'];
                // List value = Class.data()['dates'];
                // name = Class.data()['month'];
                // print(value);
                //gettingImage(classroom_id);


                final classCardWidget = lineChartMonth1(mspots.toSet().toList().reversed.toList());
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
          height: mHeight * 0.02,
        ),
        Container(
          width: mWidth*0.5,
          height: mHeight*0.05,
          child: Center(child: Text("Last six months",style: TextStyle(color: Colors.white,fontSize: mHeight*0.02,fontWeight: FontWeight.bold),)),
        ),

        SizedBox(
          height: mHeight * 0.02,
        ),
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc('calculator')
                .collection('charts')
                .orderBy('date',descending: true).limit(12)
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
                var monthCounter = 1;
                for(var date in dates){
                  // var dayDate = date.data()['date'];
                  var dayValue = date.data()['profit'];
                  mspots.add(FlSpot(monthCounter*1.0,dayValue*1.0));
                  monthCounter+=1;
                  print(monthCounter);
                  print(dayValue);
                }
                // print(Class.data()['money']);
                // String money = Class.data()['money'];
                // List value = Class.data()['dates'];
                // name = Class.data()['month'];
                // print(value);
                //gettingImage(classroom_id);


                final classCardWidget = lineChartMonth3(mspots.toSet().toList().reversed.toList());
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
          height: mHeight * 0.02,
        ),
        Container(
          width: mWidth*0.5,
          height: mHeight*0.05,
          child: Center(child: Text("Last six months",style: TextStyle(color: Colors.white,fontSize: mHeight*0.02,fontWeight: FontWeight.bold),)),
        ),

      ],
    );
  }
}


// class week extends StatefulWidget {
//   @override
//   _weekState createState() => _weekState();
// }
//
// class _weekState extends State<week> {
//   var startdate = DateTime.now().day.toString()+" "+DateTime.now().month.toString()+" "+DateTime.now().year.toString();
//   var enddate = DateTime.now().add(Duration(days:7)).day.toString()+" "+DateTime.now().month.toString()+" "+DateTime.now().year.toString();
//   DateTime datetime1;
//   DateTime dateTime2;
//   bool avail = false;
//   bool edit_enter = false;
//   var _controller = TextEditingController();
//   var Tdvalue;
//   bool refresh;
//   bool edit = false;
//   var day;
//   var start;
//   var weekday;
//   var profit;
//   var profitValue;
//   var d1 = DateTime.now().day;
//   var d2 = DateTime.now().add(Duration(days: 7)).day;
//
//   @override
//   void initState(){
//     // TODO: implement initState
//     super.initState();
//     checkTodayValue();
//     day = DateTime.now().day;
//   }
//
//   checkTodayValue() async {
//     var docRef = FirebaseFirestore.instance
//         .collection('users')
//         .doc('calculator')
//         .collection('custom chart')
//         .doc('data');
//     var daycheck = await docRef.get();
//     if (daycheck.exists) {
//
//       setState(() {
//         // edit_enter = true;
//         // t1 = daycheck.data()['day']*1.0;
//         // t2 = daycheck.data()['value']*1.0;
//         profit = daycheck.data()['profit'];
//         start = daycheck.data()['start'];
//         avail = true;
//         weekday = (day-start+1).toString();
//       });
//       checkTodayValue1();
//     } else {
//       setState(() {
//         // edit_enter = false;
//         avail = false;
//       });
//     }
//   }
//
//   checkTodayValue1() async{
//     var docRef =  FirebaseFirestore.instance
//         .collection('users')
//         .doc('calculator')
//         .collection('custom chart')
//         .doc('data');
//     var daycheck = await docRef.get();
//     if(daycheck.data()[weekday]!=null){
//
//       setState(() {
//         edit_enter = true;
//         // t1 = daycheck.data()['day']*1.0;
//         // t2 = daycheck.data()['value']*1.0;
//       });
//     }
//     else{
//       setState(() {
//         edit_enter = false;
//       });
//     }
//   }
//   Future<Null> _refresh() async {
//     await Future.delayed(Duration(seconds: 2));
//     setState(() {
//       refresh = false;
//     });
//     return null;
//   }
//   Future<void> _showMyDialog() async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Delete'),
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 Text('Are you sure'),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Cancel'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: Text('Yes'),
//               onPressed: () async{
//                 await FirebaseFirestore.instance
//                     .collection('users')
//                     .doc('calculator')
//                     .collection('custom chart')
//                     .doc('data').delete();
//                 setState(() {
//                   avail = false;
//                 });
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   List<FlSpot> mspots = [];
//
//   @override
//   Widget build(BuildContext context) {
//     var mWidth = MediaQuery.of(context).size.width;
//     var mHeight = MediaQuery.of(context).size.height;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         SizedBox(
//           height: mHeight * 0.02,
//         ),
//         Container(
//             height: mHeight * 0.35,
//             width: mWidth * 0.8,
//             child: avail?
//             StreamBuilder(
//                 stream: FirebaseFirestore.instance
//                     .collection('users')
//                     .doc('calculator')
//                     .collection('custom chart')
//                     .snapshots(),
//                 builder: (context, snapshot) {
//                   if (!snapshot.hasData || snapshot.hasError) {
//                     print("hi");
//                     return Column(
//                       children: [
//                         Container(
//                             height: mHeight*0.4,
//                             width: mWidth*0.8,
//                             child: Text("Enter value to start this month")),
//                       ],
//                     );
//                   }
//                   else {
//                     //listItem = snapshot.data.documents;
//                     List<Widget> graph_widgets = [];
//                     final dates = snapshot.data.docs;
//                     for(var date in dates){
//                       var day1 = date.data()['1'];
//                       var day2 = date.data()['2'];
//                       day1!=null?mspots.add(FlSpot(1.0,day1*1.0)):null;
//                       day2!=null?mspots.add(FlSpot(2.0,day2*1.0)):null;
//                       print(mspots.toSet().toList());
//                     }
//                     // print(Class.data()['money']);
//                     // String money = Class.data()['money'];
//                     // List value = Class.data()['dates'];
//                     // name = Class.data()['month'];
//                     // print(value);
//                     //gettingImage(classroom_id);
//
//
//                     final classCardWidget = lineChartMonth(mspots.toSet().toList());
//                     graph_widgets.add(classCardWidget);
//
//                     if(mspots.length>0) {
//                       return Column(
//                         children: graph_widgets,
//                       );
//                     }
//                     else{
//                       return LineChartSample2([FlSpot(1, 0)]);
//                     }
//                   }
//                 })
//                 :LineChartSample2([FlSpot(0, 0)])),
//         SizedBox(
//           height: mHeight * 0.02,
//         ),
//         avail
//             ? Column(
//                 children: [
//                   Container(
//                     width: mWidth * 0.8,
//                     height: mHeight * 0.07,
//                     decoration: nMboxInvert,
//                     child: Row(
//                       children: [
//                         Container(
//                           height: mHeight * 0.5,
//                           width: mWidth * 0.1,
//                           decoration: nMbtn,
//                           child: Icon(
//                             Icons.attach_money,
//                             color: Colors.white,
//                           ),
//                         ),
//                         SizedBox(
//                           width: mWidth * 0.1,
//                         ),
//                         Container(
//                           width: mWidth * 0.5,
//                           child: Center(
//                             child: TextField(
//                               controller: _controller,
//                               onChanged: (value) {
//                                 setState(() {
//                                   Tdvalue = value;
//                                   profitValue = int.parse(Tdvalue)+profit;
//                                 });
//                               },
//                               keyboardType: TextInputType.number,
//                               // inputFormatters: [
//                               //   FilteringTextInputFormatter.digitsOnly,
//                               // ],
//                               style: TextStyle(color: Colors.white),
//                               decoration: InputDecoration(
//                                 border: InputBorder.none,
//                                 hintText: edit_enter
//                                     ? "Edit today's value"
//                                     : "Enter today's value",
//                                 hintStyle: TextStyle(
//                                   color: color3,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: mHeight * 0.05,
//                   ),
//                   edit_enter
//                       ? GestureDetector(
//                           onTap: () async {
//                             // await mspots.removeRange(0,mspots.length-1);
//                             setState(() {
//                               mspots = [];
//                             });
//                             await FirebaseFirestore.instance
//                                 .collection('users')
//                                 .doc('calculator')
//                                 .collection('custom chart')
//                                 .doc('data').update({
//                               weekday:int.parse(Tdvalue),
//                               'profit':profitValue,
//                             });
//                             _controller.clear();
//
//                             setState(() {
//                               Tdvalue = null;
//                               refresh = true;
//                             });
//
//                             _refresh();
//                             _refresh();
//                             checkTodayValue();
//                           },
//                           child: Container(
//                             width: mWidth * 0.8,
//                             height: mHeight * 0.07,
//                             decoration: nMbox,
//                             child: Center(
//                               child: Text(
//                                 "EDIT",
//                                 style: TextStyle(
//                                   color: colorp2,
//                                   fontSize: mHeight * 0.03,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         )
//                       : GestureDetector(
//                           onTap: () async {
//                             if (edit) {
//                               await mspots.removeLast();
//                             }
//                             // checkTodayValue(1.toString());
//                             await FirebaseFirestore.instance
//                                 .collection('users')
//                                 .doc('calculator')
//                                 .collection('custom chart')
//                                 .doc('data').update({
//                               weekday:int.parse(Tdvalue),
//                               'profit':profitValue,
//                             });
//                             _controller.clear();
//
//                             setState(() {
//                               Tdvalue = null;
//                               refresh = true;
//                             });
//
//                             _refresh();
//                             checkTodayValue();
//                           },
//                           child: Container(
//                             width: mWidth * 0.8,
//                             height: mHeight * 0.07,
//                             decoration: nMbox,
//                             child: Center(
//                               child: Text(
//                                 "ADD",
//                                 style: TextStyle(
//                                   color: colorp2,
//                                   fontSize: mHeight * 0.03,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                   SizedBox(
//                     height: mHeight * 0.02,
//                   ),
//                   Container(
//                     height: mHeight * 0.15,
//                     width: mWidth * 0.8,
//                     decoration: nMboxInvert,
//                     child: Column(
//                       children: [
//                         Center(
//                           child: Text(
//                             profit!=null?"$profit":'0',
//                             style: TextStyle(
//                               fontSize: mHeight * 0.1,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                         Text(
//                           "Overall Profit",
//                           style: TextStyle(
//                             color: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: mHeight * 0.03,
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       _showMyDialog();
//                     },
//                     child: Container(
//                       width: mWidth * 0.8,
//                       height: mHeight * 0.07,
//                       decoration: nMbox,
//                       child: Center(
//                         child: Text(
//                           "Delete this chart",
//                           style: TextStyle(
//                             color: colorp2,
//                             fontSize: mHeight * 0.03,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   // Container(
//                   //   height: mHeight * 0.15,
//                   //   width: mWidth * 0.8,
//                   //   decoration: nMboxInvert,
//                   //   child: Column(
//                   //     children: [
//                   //       Center(
//                   //         child: Text(
//                   //           "-0.00",
//                   //           style: TextStyle(
//                   //             fontSize: mHeight * 0.1,
//                   //             fontWeight: FontWeight.bold,
//                   //             color: Colors.white,
//                   //           ),
//                   //         ),
//                   //       ),
//                   //       Text(
//                   //         "Overall Loss",
//                   //         style: TextStyle(
//                   //           color: Colors.white,
//                   //         ),
//                   //       ),
//                   //     ],
//                   //   ),
//                   // ),
//                 ],
//               )
//             : Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Container(
//                         width: mWidth * 0.35,
//                         height: mHeight * 0.07,
//                         decoration: nMboxInvert,
//                         child: Center(
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               Text(
//                                 "$startdate",
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                               GestureDetector(
//                                 onTap: () {
//                                   showDatePicker(
//                                           context: context,
//                                           initialDate: DateTime.now(),
//                                           firstDate: DateTime.now(),
//                                           lastDate: DateTime.now().add(Duration(days:7)))
//                                       .then((onValue) {
//                                     setState(() {
//                                       // month = onValue.month;
//                                       // year = onValue.year;
//                                       // day = onValue.day;
//                                       // dueDate = "$day-$month-$year";
//                                       // datetime = onValue;
//                                       startdate = onValue.day.toString() +
//                                           '-' +
//                                           onValue.month.toString() +
//                                           '-' +
//                                           onValue.year.toString();
//                                       datetime1 = onValue;
//                                       d1 = datetime1.day;
//                                     });
//                                   });
//                                 },
//                                 child: Icon(
//                                   Icons.calendar_today,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Container(
//                         width: mWidth * 0.35,
//                         height: mHeight * 0.07,
//                         decoration: nMboxInvert,
//                         child: Center(
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               Text(
//                                 "$enddate",
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                               GestureDetector(
//                                 onTap: () {
//                                   showDatePicker(
//                                       context: context,
//                                       initialDate: DateTime.now(),
//                                       firstDate: DateTime.now(),
//                                       lastDate: DateTime.now().add(Duration(days:7)))
//                                       .then((onValue) {
//                                     setState(() {
//                                       // month = onValue.month;
//                                       // year = onValue.year;
//                                       // day = onValue.day;
//                                       // dueDate = "$day-$month-$year";
//                                       // datetime = onValue;
//                                       enddate = onValue.day.toString() +
//                                           '-' +
//                                           onValue.month.toString() +
//                                           '-' +
//                                           onValue.year.toString();
//                                       dateTime2 = onValue;
//                                       d2 = dateTime2.day;
//                                     });
//                                   });
//                                 },
//                                 child: Icon(
//                                   Icons.calendar_today,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//
//                     ],
//                   ),
//                   SizedBox(
//                     height: mHeight * 0.03,
//                   ),
//                   GestureDetector(
//                     onTap: () async{
//                       await FirebaseFirestore.instance
//                           .collection('users')
//                           .doc('calculator')
//                           .collection('custom chart')
//                           .doc('data').set({
//                         'profit':0,
//                         'start':d1,
//                         'end':d2,
//                         '0':0,
//                       });
//                       setState(() {
//                         avail = true;
//                       });
//                     },
//                     child: Container(
//                       width: mWidth * 0.8,
//                       height: mHeight * 0.07,
//                       decoration: nMbox,
//                       child: Center(
//                         child: Text(
//                           "Create Chart",
//                           style: TextStyle(
//                             color: colorp2,
//                             fontSize: mHeight * 0.02,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   // LineChartSample2(),
//                   SizedBox(
//                     height: mHeight * 0.03,
//                   ),
//                 ],
//               ),
//       ],
//     );
//   }
// }
