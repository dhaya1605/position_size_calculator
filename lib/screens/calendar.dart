// import 'dart:html';

import 'package:calculator/styles.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as fs;


class calendar extends StatefulWidget {
  @override
  _calendarState createState() => _calendarState();
}

class _calendarState extends State<calendar> {
  CalendarController _controller;
  DateTime dateTime;
  var Year;
  var dateFormat;
  var month;
  var day;
  var date;
  var calendar;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = CalendarController();
    dateTime = DateTime.now();
    dateFormat = DateFormat.MMM().format(dateTime);
    month = dateFormat;
    Year = dateTime.year.toString();
    day = dateTime.day.toString();
    date = day+month+Year;
    calendar = date;
  }
  File _image;
  bool img = true;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    print(pickedFile.path);

    setState(() {
      img = false;
       if (pickedFile != null) {
        _image =  File(pickedFile.path);
        print(_image);
      } else {
        print('No image selected.');
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    var mWidth = MediaQuery.of(context).size.width;
    var mHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          Container(
              width: mWidth,
              height: mHeight*0.55,
              decoration: nMboxInvert,
              child: Column(
                children: [
                  SizedBox(
                    height: mHeight*0.05,
                  ),
                  TableCalendar(
                    calendarController: _controller,
                    initialCalendarFormat: CalendarFormat.month,
                    calendarStyle: CalendarStyle(
                      weekdayStyle: TextStyle(
                        color: Colors.white,
                        fontSize: mHeight*0.02,
                      ),
                        weekendStyle: TextStyle(
                          color: Colors.red,
                          fontSize: mHeight*0.02,
                        ),
                        todayColor: Colors.blue,
                        selectedColor: Theme.of(context).primaryColor,
                        todayStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: mHeight*0.02,
                            color: Colors.white)
                    ),
                    headerStyle: HeaderStyle(
                      leftChevronIcon: Icon(Icons.arrow_left,color: Colors.white,),
                      rightChevronIcon: Icon(Icons.arrow_right,color: Colors.white,),
                      titleTextStyle: TextStyle(
                        color: Colors.white,
                      ),
                      centerHeaderTitle: true,
                      formatButtonDecoration: BoxDecoration(
                        color: Colors.brown,
                        borderRadius: BorderRadius.circular(22.0),
                      ),
                      formatButtonTextStyle: TextStyle(color: Colors.white),
                      formatButtonShowsNext: false,
                    ),
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    // onDaySelected: (date, events) {
                    //   print(date.toUtc());
                    // },
                    builders: CalendarBuilders(
                      selectedDayBuilder: (context, date, events) => GestureDetector(
                        onTap: (){
                          // print(date.day);
                          setState(() {
                            String t = date.day.toString();
                            calendar = t+month+Year;

                          });
                        },
                        child: Container(
                            margin: const EdgeInsets.all(5.0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Text(
                              date.day.toString(),
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                      todayDayBuilder: (context, date, events) => GestureDetector(
                        onTap: (){
                          // print(date.day);
                          setState(() {
                            String t = date.day.toString();
                            calendar = t+month+Year;

                          });
                        },
                        child: Container(
                            margin: const EdgeInsets.all(5.0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Text(
                              date.day.toString(),
                              style: TextStyle(color: Colors.white),
                            )),
                      ),)
                    ),

                ],
              ),
            ),
          SizedBox(height: mHeight*0.02,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: mWidth*0.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: mWidth*0.6,
                        height: mHeight*0.05,
                        child: Center(child: Text("January 6",
                        style: TextStyle(
                          fontSize: mHeight*0.03,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),))),
                    GestureDetector(
                      onTap: (){
                        showDialog(context: context, builder: (BuildContext context) => Scaffold(

                          backgroundColor: Colors.white.withOpacity(0),
                          body: dialog(date),
                        ));

                      },
                      child: Container(
                        width: mWidth*0.1,
                        height: mHeight*0.05,
                        decoration: nMbtn2,
                        child: Icon(Icons.add,color: Colors.white,),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: mHeight*0.02,
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc('calculator')
                      .collection('notes')
                      .doc(calendar)
                      .collection('notes')
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
                        var desc = date.data()['desc'];
                        var image = date.data()['img'];
                        var time = date.data()['time'];
                        // mspots.add(FlSpot(dayDate*1.0,dayValue*1.0));
                        // print(mspots.toSet().toList());
                      // print(Class.data()['money']);
                      // String money = Class.data()['money'];
                      // List value = Class.data()['dates'];
                      // name = Class.data()['month'];
                      // print(value);
                      //gettingImage(classroom_id);


                      final classCardWidget = list1(image,time,desc);
                      graph_widgets.add(classCardWidget);
                      }

                      if(graph_widgets.length>0) {
                        return Column(
                          children: graph_widgets,
                        );
                      }
                      else{
                        return Text("no");
                      }
                    }
                  }),
            ],
          ),

        ],
      ),
    );
  }
}



class list1 extends StatelessWidget {
  list1(this.image,this.time,this.title);
  String title;
  String image;
  String time;
  @override
  Widget build(BuildContext context) {
    var mWidth = MediaQuery.of(context).size.width;
    var mHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: (){
          showDialog(context: context, builder: (BuildContext context) => Scaffold(

            backgroundColor: Colors.white.withOpacity(0),
            body: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.5,
                child: Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.5,
                      decoration: nMbox2,
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              child: Text("Note",style: TextStyle(
                                fontSize: mHeight*0.02,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),),
                            ),
                            Container(
                              width: mWidth * 0.7,
                              height: mHeight * 0.1,
                              decoration: nMboxInvert2,
                              child: Row(
                                children: [
                                  Container(
                                    height: mHeight * 0.5,
                                    width: mWidth * 0.1,
                                    decoration: nMbtn2,
                                    child: Icon(
                                      Icons.note_add_sharp,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: mWidth * 0.1,
                                  ),

                                  Container(
                                    height: mHeight*0.1,
                                    width: mWidth*0.5,
                                    child: Scrollbar(
                                      child: new SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        reverse: false,
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.only(left: 5.0, right: 3.0,top: 5.0),
                                          child: Text(title,style: TextStyle(color: Colors.white),),
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                            Container(
                              width: mWidth*0.7,
                              height: mHeight*0.2,
                              decoration: nMboxInvert2,
                              child: Image.network(image),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: -10,
                      left: -10,
                      child: GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: CircleAvatar(
                              radius: 15.0,
                              child: Icon(Icons.clear))),
                    ),
                  ],
                ),
              ),
            ),
          ));

        },
        child: Container(
          width: mWidth*0.8,
          height: mHeight*0.1,
          decoration: nMbox,
          child: Center(
            child: ListTile(
              leading: FlutterLogo(size: 56.0),
              title: Text('$title',style: t,),
              subtitle: Text('$time',style: TextStyle(
                color: Colors.white54,
              ),),
              trailing: Container(
                width: mWidth*0.1,
                height: mHeight*0.05,
                decoration: nMbtn,
                child: Icon(Icons.arrow_forward_ios,color: Colors.white,),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
class dialog extends StatefulWidget {
  dialog(this.date);
  var date;
  @override
  _dialogState createState() => _dialogState(date);
}

class _dialogState extends State<dialog> {
  _dialogState(this.date);
  File _image;
  bool img = true;
  final picker = ImagePicker();
  bool spinner = false;
  var date;
  var time;
  var desc;

  fs.FirebaseStorage _storage = fs.FirebaseStorage.instanceFor(bucket: 'gs://calculator-db85e.appspot.com/');

  fs.UploadTask _uploadTask;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    print(pickedFile.path);

    setState(() {
      img = false;
      if (pickedFile != null) {
        _image =  File(pickedFile.path);
        print(_image);
      } else {
        print('No image selected.');
      }
    });
  }
  void _startUpload() async{

    /// Unique file name for the file
    String filePath = 'calculator/${DateTime.now()}.png';
    //
    //  await fs.FirebaseStorage.instance.ref().child(filePath).putFile(_image);
    //
    //  var ref = fs.FirebaseStorage.instance.ref().child(filePath).putFile(_image);
    // //
    // setState((){
    //   _uploadTask = ref.putFile(_image);
    // });
    fs.UploadTask uptask = fs.FirebaseStorage.instance.ref().child(filePath).putFile(_image);
    var imageUrl = await (await uptask).ref.getDownloadURL();
    print(imageUrl);

    if(imageUrl!=null){
      finalStep(imageUrl);
    }


  }

  finalStep(url) async{
    await FirebaseFirestore.instance.collection('users').doc('calculator')
        .collection('notes').doc(date).collection('notes').doc().set({
      'desc':desc,
      'img':url,
      'time':time,
    });
    Navigator.pop(context);
    setState(() {
      spinner = false;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    time = DateTime.now().hour.toString()+":"+DateTime.now().minute.toString();
  }

  @override
  Widget build(BuildContext context) {
    var mWidth = MediaQuery.of(context).size.width;
    var mHeight = MediaQuery.of(context).size.height;
    return Center(
      child: ModalProgressHUD(
        inAsyncCall: spinner,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.6,
          child: spinner?Container():Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: nMbox2,
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        child: Text("New Note",style: TextStyle(
                          fontSize: mHeight*0.02,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),),
                      ),
                      Container(
                        width: mWidth * 0.7,
                        height: mHeight * 0.1,
                        decoration: nMboxInvert2,
                        child: Row(
                          children: [
                            Container(
                              height: mHeight * 0.5,
                              width: mWidth * 0.1,
                              decoration: nMbtn2,
                              child: Icon(
                                Icons.note_add_sharp,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: mWidth * 0.1,
                            ),

                            Container(
                              height: mHeight*0.1,
                              width: mWidth*0.5,
                              child: Scrollbar(
                                child: new SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  reverse: false,
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.only(left: 5.0, right: 3.0),
                                    child: new TextField(
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          //ADesc = value;
                                          desc = value;
                                        });
                                      },
                                      maxLines: null,
                                      decoration: InputDecoration(
                                        hintText: "Description",
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                          color: color3,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                      img?Container(
                        width: mWidth*0.7,
                        height: mHeight*0.2,
                        decoration: nMboxInvert2,
                        child: Center(
                          child: GestureDetector(
                            onTap: getImage,
                            child: img?Container(
                              width: mWidth*0.4,
                              height: mHeight*0.05,
                              decoration: nMbox2,
                              child: Center(child: Text("Add Image",style: t,)),
                            ):Image.file(_image),
                          ),
                        ),
                      ):Container(
                        width: mWidth*0.7,
                        height: mHeight*0.2,
                        decoration: nMboxInvert2,
                        child: Center(
                          child: GestureDetector(
                            onTap: getImage,
                            child: img?Container(
                              width: mWidth*0.4,
                              height: mHeight*0.05,
                              decoration: nMbox2,
                              child: Center(child: Text("Add Image",style: t,)),
                            ):Image.file(_image),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async{
                          // Navigator.pop(context);
                          setState(() {
                            spinner = true;
                          });
                          _startUpload();
                          // Navigator.pop(context);
                        },
                        child: Container(
                          width: mWidth*0.7,
                          height: mHeight*0.05,
                          decoration: nMbox2,
                          child: Center(child: Text("Add Note",style: t,)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: -10,
                left: -10,
                child: GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: CircleAvatar(
                        radius: 15.0,
                        child: Icon(Icons.clear))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}