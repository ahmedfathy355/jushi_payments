import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter_svg/flutter_svg.dart';
//import 'package:date_picker_timeline/date_picker_timeline.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: financeList4(),
    );
  }

}

class financeList4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: const Color(0xfff2f4f7),
//      appBar: AppBar(
//        title: Text("Choco Factory"),
//      ),
      body: financeList4UI(),
    );
  }
}

class financeList4UI extends StatefulWidget {
  @override
  _financeList4State createState() => _financeList4State();
}

class _financeList4State extends State<financeList4UI> {

  final List<String> dt_listoflog = ["Payments       17.00 LE \nArea                 Super Market","Payments       8.00 LE \n Area                Resturant"
//    ,"Charges          50.00 LE \nArea                 Super Market","Payments       25.00 LE \n Area                Resturant"
//    ,"Charges          50.00 LE \nArea                 Super Market","Payments       25.00 LE \n Area                Resturant"
//    ,"Charges          50.00 LE \nArea                 Super Market","Payments       25.00 LE \n Area                Resturant"
    ,"Charges          50.00 LE \nArea                 Super Market","Payments       25.00 LE \n Area                Resturant"];

  //DatePickerController _controller = DatePickerController();
  DateTime _selectedValue = DateTime.now();
  @override
  void initState() {
    super.initState();
  }
  final titles = ['bike', 'boat', 'bus', 'car',
    'railway', 'run', 'subway', 'transit', 'walk'];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0,50,0,0),
      child:
      Stack(

        children: <Widget>[
//          Text("You Selected:"),
//          Padding(
//            padding: EdgeInsets.all(10),
//          ),
//          Transform.translate(offset: Offset(110,0),child: Text(_selectedValue.toString())),
//          Padding(
//            padding: EdgeInsets.all(20),
//          ),
          Transform.translate(offset: Offset(0,10),child:  Container(
            //DatePicker

//            child: DatePicker(
//              DateTime.now().add(Duration(days: -30)),
//              width: 60,
//              height: 80,
//              controller: _controller,
//              initialSelectedDate: DateTime.now(),
//              selectionColor: Colors.black,
//              selectedTextColor: Colors.white,
//              onDateChange: (date) {
//                // New date selected
//                setState(() {
//                  _selectedValue = date;
//                });
//              },
//            ),
          ),),


          new Container(
            padding: EdgeInsets.fromLTRB(0,70,0,0),
            child:
            new ListView.builder(itemBuilder: (_,int index) => list_log(context,this.dt_listoflog[index]),
              itemCount: this.dt_listoflog.length,
            ),
          ),


        ],
      ),


    );







//    lIST<eMPaCCOUNT>.isEmpty
//    // BIG ZZZ PICTURE
//        ? LayoutBuilder(builder: (ctx, constraints) {
//      // constraints from Container height MediaQuery
//      return Column(
//        children: <Widget>[
//          Text(
//            'No transactions added yet!',
//            style: Theme.of(context).textTheme.title,
//          ),
//          const SizedBox(height: 20,),  //SizedBox = separator
//          Container(
//              height: constraints.maxHeight * 0.7,
//              child: Image.asset('assets/images/waiting.png', fit: BoxFit.cover,))  // BoxFit reflect to height:200
//        ],
//      );
//    },)
//
//    // If there is transaction(s)
//        : ListView(
//      children: transactions.map( (tx) => TransactionItem( key: ValueKey(tx.id), transaction: tx, deleteTransaction: deleteTransaction,) ).toList(),
//    );






  }
}



Widget list_log (BuildContext context , String log_title)
{
    return Stack(
      children: <Widget>[
//            Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
//                child: Container(width: MediaQuery.of(context).size.width - 30,
//                    height: 14,
//                    decoration: BoxDecoration(
//                    borderRadius: BorderRadius.circular(8.0),
//                    color: const Color(0xffdee2eb),
//                ),
//                )
//        ),
        Transform.translate(
          offset: Offset(20, 10.0),
          child: Container(
            width: MediaQuery.of(context).size.width - 30,
            height: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: const Color(0xffffffff),
              boxShadow: [
                BoxShadow(
                    color: const Color(0x08000000),
                    offset: Offset(0, 20),
                    blurRadius: 40)
              ],
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(0.0, 10.0),
          child: Stack(
            children: <Widget>[
              Transform.translate(
                offset: Offset(60, 5.0),
                child: Stack(
                  children: <Widget>[
                    Container(
                      child: Text.rich(
                        TextSpan(
                          style: TextStyle(
                            fontFamily: 'Circular Std Book',
                            fontSize: 15,
                            color: const Color(0xff3a4759),
                            height: 1.1,
                          ),
                          children: [
                            TextSpan(
                              text: log_title,
                            ),


                            TextSpan(
                              text: '\n19-5-2020\n',
                              style: TextStyle(
                                fontFamily: 'Circular Std Bold',
                                color:const Color(0xffa6b1c0),

                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(95, 0, 0, 0),
                      child: Text(
                        '\n\n08:39 AM',
                        style: TextStyle(
                          fontFamily: 'Circular Std Book',
                          fontSize: 15,
                          color: const Color(0xffa6b1c0),
                          height: 1.1,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
              Transform.translate(
                offset: Offset(5, 3.0),
                child: Stack(
                  children: <Widget>[
                    Container(

                      child: Container(
                        width: 52,
                        height: 52.0,
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.all(Radius.elliptical(91.0, 91.0)),
                          color: const Color(0xffffffff),
                          boxShadow: [
                            BoxShadow(
                                color: const Color(0x1a000000),
                                offset: Offset(0, 20),
                                blurRadius: 30)
                          ],
                        ),
                      ),
                    ),
//                      Transform.translate(
//                        offset: Offset(126.0, 562.53),
//                        child: SvgPicture.string(
//                          _shapeSVG_cb53df06832f43dbb29094989b08df8b,
//                          allowDrawingOutsideViewBox: true,
//                        ),
//                      ),
                    Stack(
                      children: <Widget>[
                        Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(67.0),
                            gradient: LinearGradient(
                              begin: Alignment(-1.0, -1.0),
                              end: Alignment(-1.0, 1.0),
                              colors: [
                                const Color(0xfff12711),
                                const Color(0xfff5af19)
                              ],
                              stops: [0.0, 1.0],
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: const Color(0x33ff8f91),
                                  offset: Offset(0, 5),
                                  blurRadius: 20)
                            ],
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(12,10),
                          child: SvgPicture.asset(
                            "assets/images/choices.svg",height: 32,width: 32,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),



      ],
    );
}



