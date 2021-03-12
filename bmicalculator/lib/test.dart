import 'package:flutter/material.dart';
import "ShowAlertDialog.dart";
import "Request.dart";
import 'package:intl/intl.dart';

int submit_slot_num = 0;
int submit_three_digit_num=0;
int submit_single_digit_num=0;
String Single_digit_string="";
String SlotValue = "";
var date=DateTime.now();

String dateToday = DateFormat('d MMMM, yyyy').format(date);
TextStyle datestyle = TextStyle(
    fontWeight: FontWeight.w700,
    color: Colors.black,
    fontSize: 20.0,
    fontFamily: 'Raleway');
TextEditingController threedigit = new TextEditingController();

class SubmitPage extends StatefulWidget {
  @override
  SubmitPageState createState() => new SubmitPageState();
}

class SubmitPageState extends State<SubmitPage> {
  static currentSlot() {
    int currenttime = DateTime.now().hour;

    var currentday= DateFormat('EEEE').format(date);


    Map<int, String> slotdict = {};
    List<double> slotlist = [];
    int opentime = 0;
    int closetime = 0;
    int slotover = 0;
    if (currentday == "Sunday") {
      slotdict = {
        0: "SLOT 1",
        1: "SLOT 2",
        2: "SLOT 3",
        3: "SLOT 4",
        4: "SLOT-OVER"
      };
      slotlist = [11, 12, 14, 16];
      opentime = 7;
      closetime = 16;
      slotover = 4;
    } else {
      slotdict = {
        0: "SLOT 1",
        1: "SLOT 2",
        2: "SLOT 3",
        3: "SLOT 4",
        4: "SLOT 5",
        5: "SLOT 6",
        6: "SLOT 7",
        7: "SLOT 8",
        8: "SLOT-OVER"
      };
      slotlist = [11, 12, 13, 15, 16.5, 18.5, 19.5, 22, 23];
      opentime = 7;
      closetime = 23;
      slotover = 8;
    }
    double lowerbound = 7, upperbound = 11;
    int i = 0;

    while (i < slotlist.length) {
      if (currenttime >= lowerbound && currenttime <= upperbound) {
        SlotValue = slotdict[i];

        submit_slot_num = i;
        break;
      } else if (currenttime > closetime || currenttime < opentime) {
        SlotValue = slotdict[slotover];
        submit_slot_num = 8;
      }
      lowerbound = slotlist[i]; // 11
      upperbound = slotlist[i + 1]; //12
      i += 1;
    }
  }


  void get_single_digit_num() {
    if(threedigit.text.isNotEmpty) {
      setState(() {
        ThreedigitNum();
      });
    }
    else{
      Future.delayed(Duration.zero, () => showAlertDialog(context,"Please Enter 3 digit Number"));
    }
  }

  void ThreedigitNum(){
    bool flag=false;
    int rev=0;
    int dig=0;
    int singleNumber=0;
    List<int> List_input=
    [128, 290, 100, 579, 335, 137, 380, 678, 344, 146, 470, 119, 399, 236, 489, 155, 588, 245,560,
      777, 227, 129, 246, 200, 589, 336, 138, 345, 679, 499, 147, 390, 110, 666, 136, 480, 228, 688,
      237, 570, 444, 255, 120, 247, 300, 670, 355, 139, 256, 689, 445, 148, 346, 166, 599, 157, 490,
      229, 779, 238, 580, 111, 337, 130, 248, 400, 680, 338, 149, 257, 789, 446, 158, 347, 112, 455,
      167, 356, 220, 699, 239, 590, 888, 266, 140, 258, 500, 690, 339, 159, 267, 780, 366, 168, 348,
      113, 447, 230, 357, 122, 799, 249, 456, 555, 177, 123, 259, 600, 457, 448, 150, 268, 790,
      466, 169, 349, 114, 556, 178, 358, 277, 880, 240, 367, 222, 330, 124, 278, 700, 467, 223, 160,
      340, 890, 377, 179,
      359, 115, 449, 250, 368, 133, 557, 269, 458, 999, 188, 125, 279, 800, 468, 288, 134, 350, 567,
      440, 170, 369, 116,
      477, 189, 378, 224, 558, 260, 459, 666, 233, 126, 289, 900, 478, 225, 135, 360, 568, 388, 180,
      379, 117, 559, 270, 450, 144, 577, 234, 469, 333, 199, 127, 235, 550, 569,
      299, 136, 370, 578, 334, 145, 389, 118, 488, 190, 460, 226, 668, 280, 479, 000, 244, 669, 778,
      788, 770, 889, 899, 566, 990, 667, 677];
    int inputNumber= int.parse(threedigit.text);
    submit_three_digit_num=inputNumber;

    for(int i=0;i<=List_input.length-1;i++) {
      if (inputNumber == List_input[i]) {
        flag = true;
        break;
      }
    }
    if(flag) {
      if (inputNumber == 0) {
        Single_digit_string = "0";
      } else {
        while (inputNumber > 0) {
          dig = inputNumber % 10;
          rev = rev + dig;
          inputNumber = inputNumber~/10;
          singleNumber = rev % 10;
          submit_single_digit_num = singleNumber;
          Single_digit_string = singleNumber.toString();
        }
      }
    }else{
      Future.delayed(Duration.zero, () => showAlertDialog(context,"$submit_three_digit_num  , Number is not a Lottery Number ! "));

    }
  }




  @override
  Widget build(BuildContext context) {
    currentSlot();
    final date = Text(
      "Date : $dateToday ",
      textAlign: TextAlign.right,
      overflow: TextOverflow.ellipsis,
      style: datestyle.copyWith(height: 3),
    );


    final threedigitField = TextField(
      controller: threedigit,
      obscureText: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: '3 Digit',
        prefixIcon: Icon(Icons.confirmation_number),
      ),
      keyboardType: TextInputType.number,
      maxLength: 3,

    );
    final get1digitnum = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(20.0),
      color: Colors.yellow,
      child: MaterialButton(
        //minWidth: MediaQuery.of(context).size.width,
        //height: 5.0,
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        onPressed: get_single_digit_num,
        child: Text("Press for single Digit Number!",

            textAlign: TextAlign.left,
            style: datestyle.copyWith(
                color: Colors.black, height: 1)),
      ),
    );
    final singledigitvalue = new Text(Single_digit_string,
        style: datestyle.copyWith(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          // backgroundColor: Colors.lightBlueAccent,
          //height: -5
        ));
    final final_submit = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(20.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        //minWidth: MediaQuery.of(context).size.width,
        height: 20,
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        onPressed: (){
          if(threedigit.text.length ==3 && Single_digit_string.length!=null ){
            FinalSubmit(context,submit_three_digit_num,submit_single_digit_num,submit_slot_num);
            Single_digit_string="";
          }else{
            Future.delayed(Duration.zero, () => showAlertDialog(context," Please Enter 3 digit Number"));
          }

        },
        child: Text("Submit !",
            textAlign: TextAlign.left,
            style: datestyle.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold, height: 1)),
      ),
    );
    return new Scaffold(
        appBar: new AppBar(
            title: new Text("$SlotValue",textAlign: TextAlign.center,),
            backgroundColor: Colors.blue),
        body: new Container(
            child: new Center(
                child: new Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Align(alignment: Alignment.topCenter, child: date),
                      new Padding(padding: new EdgeInsets.all(10.0)),
                      new Text("Please Enter Three Digit Number",
                          textAlign: TextAlign.center,
                          style: datestyle.copyWith(height: 5)),
                      //SizedBox(height: 35.0),
                      new Container(
                          width: 150.0,
                          child:threedigitField
                      ),
                      //Align(alignment: Alignment.center,child: threedigitField,),
                      //new Padding(padding: new EdgeInsets.all(25.0)),
                      Align(alignment: Alignment.center,child: get1digitnum,),
                      new Padding(padding: new EdgeInsets.all(10.0)),
                      Align(alignment: Alignment.center,child: singledigitvalue,),

                      Align(alignment: Alignment.bottomCenter,child: final_submit,)
                      //final_submit
                      //singledigitvalue
                    ]))));
  }
}
