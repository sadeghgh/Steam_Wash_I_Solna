import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:steam_wash_i_solna/drawer.dart';
import 'package:steam_wash_i_solna/map_page.dart';

class DateTimePicker extends StatefulWidget {
  var name, desc, prices;
  DateTimePicker(this.name, this.desc, this.prices);
  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  late double _height;
  late double _width;
  bool seven = false;
  bool nine = false;
  bool eleven = false;
  bool thirteen = false;
  bool fifteen = false;
  bool seventeen = false;
  bool seven2 = false;
  bool nine2 = false;
  bool eleven2 = false;
  bool thirteen2 = false;
  bool fifteen2 = false;
  bool seventeen2 = false;
  String time = '';
  String id = '';
  late String _setDate;
  String dateAndTime = '';

  //late String _hour, _minute, _time;

  late String dateTime;

  DateTime selectedDate = DateTime.now();

  TextEditingController _dateController = TextEditingController();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2021),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
        getDate();
      });
  }

  @override
  void initState() {
    _dateController.text = DateFormat.yMd().format(DateTime.now());

    super.initState();
    getDate();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    dateTime = DateFormat.yMd().format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueGrey[300],
        shadowColor: Colors.grey,
      ),
      drawer: SizedBox(
        child: Drawer(
          child: SafeArea(child: CustomDrawer()),
        ),
        width: _width * 0.8,
      ),
      body: Container(
        width: _width,
        height: _height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  'Välj Datum',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5),
                ),
                InkWell(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: Container(
                    width: _width / 1.7,
                    height: _height / 9,
                    margin: EdgeInsets.only(top: 30),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.grey[200]),
                    child: TextFormField(
                      style: TextStyle(fontSize: 40),
                      textAlign: TextAlign.center,
                      enabled: false,
                      keyboardType: TextInputType.text,
                      controller: _dateController,
                      onSaved: (String? val) {
                        _setDate = val!;
                      },
                      decoration: InputDecoration(
                          disabledBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          // labelText: 'Time',
                          contentPadding: EdgeInsets.only(top: 0.0)),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Text(
                  'Välj Tid',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          seven2 == false
                              ? InkWell(
                                  child: Container(
                                    width: _width / 4,
                                    height: _height / 14,
                                    color: seven == false
                                        ? Colors.blueGrey
                                        : Colors.green,
                                    child: Center(
                                        child: Text(
                                      '07:00',
                                      style: TextStyle(fontSize: 30),
                                    )),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      if (seven == false) {
                                        seven = true;
                                        nine = false;
                                        eleven = false;
                                        thirteen = false;
                                        fifteen = false;
                                        seventeen = false;
                                        time = 'seven';
                                        dateAndTime =
                                            _dateController.text + ' 07:00';
                                      } else {
                                        seven = false;
                                      }
                                    });
                                  },
                                )
                              : Container(
                                  width: _width / 4,
                                  height: _height / 14,
                                ),
                          nine2 == false
                              ? InkWell(
                                  child: Container(
                                    width: _width / 4,
                                    height: _height / 14,
                                    color: nine == false
                                        ? Colors.blueGrey
                                        : Colors.green,
                                    child: Center(
                                        child: Text(
                                      '09:00',
                                      style: TextStyle(fontSize: 30),
                                    )),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      if (nine == false) {
                                        nine = true;
                                        seven = false;
                                        eleven = false;
                                        thirteen = false;
                                        fifteen = false;
                                        seventeen = false;
                                        time = 'nine';
                                        dateAndTime =
                                            _dateController.text + ' 09:00';
                                      } else {
                                        nine = false;
                                      }
                                    });
                                  },
                                )
                              : Container(
                                  width: _width / 4,
                                  height: _height / 14,
                                ),
                          eleven2 == false
                              ? InkWell(
                                  child: Container(
                                    width: _width / 4,
                                    height: _height / 14,
                                    color: eleven == false
                                        ? Colors.blueGrey
                                        : Colors.green,
                                    child: Center(
                                        child: Text(
                                      '11:00',
                                      style: TextStyle(fontSize: 30),
                                    )),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      if (eleven == false) {
                                        eleven = true;
                                        seven = false;
                                        nine = false;
                                        thirteen = false;
                                        fifteen = false;
                                        seventeen = false;
                                        time = 'eleven';
                                        dateAndTime =
                                            _dateController.text + ' 11:00';
                                      } else {
                                        eleven = false;
                                      }
                                    });
                                  },
                                )
                              : Container(
                                  width: _width / 4,
                                  height: _height / 14,
                                ),
                        ],
                      ),
                      SizedBox(
                        height: _height / 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          thirteen2 == false
                              ? InkWell(
                                  child: Container(
                                    width: _width / 4,
                                    height: _height / 14,
                                    color: thirteen == false
                                        ? Colors.blueGrey
                                        : Colors.green,
                                    child: Center(
                                        child: Text(
                                      '13:00',
                                      style: TextStyle(fontSize: 30),
                                    )),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      if (thirteen == false) {
                                        thirteen = true;
                                        seven = false;
                                        nine = false;
                                        eleven = false;
                                        fifteen = false;
                                        seventeen = false;
                                        time = 'thirteen';
                                        dateAndTime =
                                            _dateController.text + ' 13:00';
                                      } else {
                                        thirteen = false;
                                      }
                                    });
                                  },
                                )
                              : Container(
                                  width: _width / 4,
                                  height: _height / 14,
                                ),
                          fifteen2 == false
                              ? InkWell(
                                  child: Container(
                                    width: _width / 4,
                                    height: _height / 14,
                                    color: fifteen == false
                                        ? Colors.blueGrey
                                        : Colors.green,
                                    child: Center(
                                        child: Text(
                                      '15:00',
                                      style: TextStyle(fontSize: 30),
                                    )),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      if (fifteen == false) {
                                        fifteen = true;
                                        seven = false;
                                        nine = false;
                                        eleven = false;
                                        thirteen = false;
                                        seventeen = false;
                                        time = 'fifteen';
                                        dateAndTime =
                                            _dateController.text + ' 15:00';
                                      } else {
                                        fifteen = false;
                                      }
                                    });
                                  },
                                )
                              : Container(
                                  width: _width / 4,
                                  height: _height / 14,
                                ),
                          seventeen2 == false
                              ? InkWell(
                                  child: Container(
                                    width: _width / 4,
                                    height: _height / 14,
                                    color: seventeen == false
                                        ? Colors.blueGrey
                                        : Colors.green,
                                    child: Center(
                                        child: Text(
                                      '17:00',
                                      style: TextStyle(fontSize: 30),
                                    )),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      if (seventeen == false) {
                                        seventeen = true;
                                        seven = false;
                                        nine = false;
                                        eleven = false;
                                        thirteen = false;
                                        fifteen = false;
                                        time = 'seventeen';
                                        dateAndTime =
                                            _dateController.text + ' 17:00';
                                      } else {
                                        seventeen = false;
                                      }
                                    });
                                  },
                                )
                              : Container(
                                  width: _width / 4,
                                  height: _height / 14,
                                ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: _height / 20,
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Material(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      elevation: 5,
                      child: MaterialButton(
                        onPressed: () {
                          setDateTime();
                        },
                        minWidth: 250,
                        height: 45,
                        child: Text(
                          'Nästa',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  setDateTime() {
    if (id != '') {
      FirebaseFirestore.instance
          .collection('date_time')
          .doc(id)
          .update({time: true}).then((value) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                MapPage(widget.name, widget.desc, widget.prices, dateAndTime)));
      });
    } else {
      FirebaseFirestore.instance
          .collection('date_time')
          .add({'date': _dateController.text, time: true}).then((value) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                MapPage(widget.name, widget.desc, widget.prices, dateAndTime)));
      });
    }
  }

  getDate() {
    FirebaseFirestore.instance
        .collection('date_time')
        //.where('date', isEqualTo: _dateController.text)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc['date'] == _dateController.text) {
          setState(() {
            id = doc.id;
          });
          print('ssssssssssssssssssssssssssssss');
          print(id);
          print(_dateController.text);
          if (doc['seven'] != null) {
            setState(() {
              seven2 = doc['seven'];
            });
          }
          if (doc['nine'] != null) {
            setState(() {
              nine2 = doc['nine'];
            });
          }
          if (doc['eleven'] != null) {
            setState(() {
              eleven2 = doc['eleven'];
            });
          }
          if (doc['thirteen'] != null) {
            setState(() {
              thirteen2 = doc['thirteen'];
            });
          }
          if (doc['fifteen'] != null) {
            setState(() {
              fifteen2 = doc['fifteen'];
            });
          }
          if (doc['seventeen'] != null) {
            setState(() {
              seventeen2 = doc['seventeen'];
            });
          }
        } else {
          setState(() {
            seven2 = false;
            nine2 = false;
            eleven2 = false;
            thirteen2 = false;
            fifteen2 = false;
            seventeen2 = false;
          });
        }
      });
    });
  }
}
