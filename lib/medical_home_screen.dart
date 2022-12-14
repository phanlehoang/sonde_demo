import 'dart:ffi';
import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medical_demo/controller_time.dart';
import 'package:medical_demo/history_screen.dart';
import 'package:medical_demo/medical_class.dart';
import 'package:medical_demo/sizeDevide.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:toast/toast.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import "dart:async";

class MedicalHomeScreen extends StatefulWidget {
  const MedicalHomeScreen({Key? key}) : super(key: key);

  @override
  State<MedicalHomeScreen> createState() => _MedicalHomeScreenState();
}

class _MedicalHomeScreenState extends State<MedicalHomeScreen>
    with WidgetsBindingObserver {
  Medical medicalObject = Medical();
  // late AppLifecycleState _lastLifecycleState;
  final TextEditingController _editingController = TextEditingController();
  final TextEditingController _enterWeightController = TextEditingController();
  // get instancr firebase database
  final reference = FirebaseDatabase.instance.ref("Medicals/medical");
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    medicalObject.timeNextCurrentValid();
  }

  // sava data when close app
  @override
  void dispose() {
    print("app was closed");
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.paused &&
        medicalObject.flagRestart == false) {
      await reference.set({
        "namePD": medicalObject.getNamePD,
        "initialStateBool": medicalObject.getInitialStateBool,
        "lastStateBool": medicalObject.getLastStateBool,
        "listResultInjection": medicalObject.getListResultInjection,
        "listTimeResultInjection": medicalObject.getListTimeResultInjection,
        "listHistoryInjection": medicalObject.listHistoryInjection,
        "listHistoryTimeInjection": medicalObject.listHistoryTimeInjection,
        "isVisibleGlucose": medicalObject.isVisibleGlucose,
        "isVisibleYesNoo": medicalObject.isVisibleYesNoo,
        "timeStart": medicalObject.getTimeStart.toString(),
        "sloveFailedContext": medicalObject.getSloveFailedContext,
        "yInsu22H": medicalObject.getYInsu22H,
        "flagRestart": medicalObject.flagRestart,
        "isVisibleButtonNext": medicalObject.isVisibleButtonNext,
        "checkCurrentGlucose": medicalObject.checkCurrentGlucose,
        "checkCurrentGlucose": medicalObject.checkCurrentGlucose,
        "checkDoneTask": medicalObject.checkDoneTask,
        "timeNext": medicalObject.timeNext,
        "isVisibleWeight": medicalObject.isVisibleWeight,
        "timeNextDay": medicalObject.timeNextDay,
        "listOldSolveHistory": medicalObject.listOldSolveHistory,
        "blockStateIitial": medicalObject.blockStateIitial,
        "checkBreak": medicalObject.checkBreak,
        //  "address": {"line1": "100 Mountain View"}
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const BackButtonIcon(),
          ),
        ),
        body: FutureBuilder(
            future: medicalObject.readDataRealTimeDB("Medicals/medical"),
            builder: (context, snapshot) {
              List<Widget> children;
              if (snapshot.hasData) {
                children = <Widget>[
                  SingleChildScrollView(
                    child: Container(
                      alignment: Alignment.topLeft,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color(0xfff5f6f6),
                          Colors.white,
                        ],
                      )),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // profile th??ng tin b???nh nh??n
                          Row(
                            children: [
                              SizedBox(
                                height: 90,
                                width: 90,
                                child: CircleAvatar(
                                  radius: 48, // Image radius
                                  backgroundImage: NetworkImage(
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTqkKsJE9otzQr3RAnkLRCThzaxfoJ0_6W2sg&usqp=CAU'),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10, top: 5),
                                height: 100,
                                width: widthDevideMethod(0.6),
                                alignment: Alignment.topLeft,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text('Nguy???n Ki???u Anh'),
                                    Text(
                                      ' Ti???u ???????ng , 27 tu???i , N??? gi???i',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    SizedBox(
                                      height: heightDevideMethod(0.012),
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: widthDevideMethod(0.03),
                                        ),
                                        // xem chi ti???t th??ng tin b???nh nh??n
                                        SizedBox(
                                          height: 30,
                                          child: ElevatedButton(
                                              onPressed: () {},
                                              child: Text('Xem chi ti???t'),
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.blue[400],
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                              )),
                                        ),
                                        SizedBox(
                                          width: widthDevideMethod(0.05),
                                        ),
                                        //  Nh???n tin v???i b???nh nh??n
                                        SizedBox(
                                          height: 30,
                                          child: ElevatedButton(
                                              onPressed: () {},
                                              child: Text('Nh???n tin'),
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.blue[400],
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          // Logic b??c s??
                          Container(
                            padding: const EdgeInsets.only(bottom: 20, top: 20),
                            child: Text(
                              '${medicalObject.getNamePD}',
                              style: const TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                  height: 1.5),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            height: heightDevideMethod(0.42),
                            child: Stack(
                              children: [
                                SizedBox(
                                  height: heightDevideMethod(0.4),
                                  child: Row(
                                    children: [
                                      Container(
                                        color: Colors.white,
                                        width: widthDevideMethod(0.1),
                                        height: heightDevideMethod(0.37),
                                      ),
                                      SizedBox(
                                          width: widthDevideMethod(0.7),
                                          child: Image.asset(
                                              "assets/doctor.jpg",
                                              fit: BoxFit.fitHeight)),
                                      Expanded(
                                          child: Container(
                                              color: const Color(0xfff5f6f6))),
                                    ],
                                  ),
                                ),
                                Positioned(
                                    right: 30,
                                    top: 20,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.info,
                                        color: Colors.grey[800],
                                        size: 40,
                                      ),
                                      tooltip: "history",
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HistoryScreen(
                                                        medical:
                                                            medicalObject)));
                                      },
                                    )),
                                Positioned(
                                  top: 120,
                                  left: 10,
                                  child: Container(
                                    alignment: Alignment.topCenter,
                                    width: widthDevideMethod(0.91),
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage("assets/bbchat1.png"),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                            height: heightDevideMethod(0.03)),

                                        //  B???n c?? ??ang ti??m Insulin kh??ng ?
                                        Row(
                                          children: [
                                            Container(
                                              width: widthDevideMethod(0.04),
                                            ),
                                            Flexible(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 5),
                                                child: Text(
                                                  '${medicalObject.getContentdisplay}  ',
                                                  style: const TextStyle(
                                                      fontSize: 16),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8),
                                              alignment: Alignment.center,
                                              child: Visibility(
                                                visible: medicalObject
                                                    .isVisibleYesNoo,
                                                child: ToggleSwitch(
                                                  customWidths: const [
                                                    40.0,
                                                    50.0
                                                  ],
                                                  customHeights: const [20, 20],
                                                  initialLabelIndex: 2,
                                                  cornerRadius: 20.0,
                                                  activeFgColor: Colors.white,
                                                  inactiveBgColor: Colors.grey,
                                                  inactiveFgColor: Colors.white,
                                                  totalSwitches: 2,
                                                  fontSize: 14,
                                                  labels: const ['No', 'Yes'],
                                                  activeBgColors: const [
                                                    [Colors.pink],
                                                    [Colors.green]
                                                  ],
                                                  onToggle: (index) {
                                                    medicalObject.flagRestart =
                                                        false;
                                                    medicalObject.setTimeStart =
                                                        DateTime.now()
                                                            .toString()
                                                            .substring(0, 16);
                                                    print(medicalObject
                                                        .getTimeStart);
                                                    Future.delayed(
                                                        const Duration(
                                                            milliseconds: 500),
                                                        () {
                                                      setState(() {
                                                        medicalObject
                                                                .isVisibleYesNoo =
                                                            false;
                                                        medicalObject
                                                                .setInitialStateBool =
                                                            index == 0
                                                                ? true
                                                                : false;
                                                        if (medicalObject
                                                            .checkValidMeasuringTimeFocus()) {
                                                          medicalObject
                                                              .setChangeVisibleGlucose(); // true
                                                          medicalObject
                                                              .setChangeCheckCurrentGlucose(); // true
                                                        } else {
                                                          // print("here jump!");
                                                          medicalObject
                                                              .setChangeVisibleButtonNext(); // true
                                                        }
                                                        print(
                                                            "check currrnt ${medicalObject.checkCurrentGlucose}");
                                                        medicalObject
                                                            .setChangeStatus();
                                                      });
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 20,
                                  left: 10,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.restart_alt_rounded,
                                      size: 35,
                                    ),
                                    tooltip: 'restart',
                                    onPressed: () => _showMyDialog(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // N??t chuy???n ti???p ph????ng ??n
                          Visibility(
                            visible: medicalObject.isVisibleButtonNext,
                            child: ElevatedButton(
                                onPressed: () {
                                  //  update time TimeNextDay  tr?????c khi ti???n h??nh
                                  if (medicalObject.checkSmallerTimeNextDay()) {
                                    medicalObject.timeNextDay =
                                        DateFormat('dd-MM-yyyy').format(
                                            DateTime.now()); // update time day
                                  }
                                  if (medicalObject.checkTimeNextDay()) {
                                    if (medicalObject
                                        .checkValidMeasuringTimeFocus()) {
                                      if (!medicalObject.checkCurrentGlucose) {
                                        print(
                                            "check done = ${medicalObject.checkDoneTask}");
                                        if (!medicalObject.checkDoneTask) {
                                          // ch??a nh???p glucose xong
                                          setState(() {
                                            medicalObject
                                                .setChangeVisibleButtonNext(); // ???n n??t
                                            medicalObject
                                                .setChangeVisibleGlucose(); // hi???n nh???p glucose
                                            medicalObject
                                                .setChangeCheckCurrentGlucose(); // ???? t???i b?????c nh???p glucose
                                            print("Time tiep theo:" +
                                                medicalObject.timeNext);
                                          });
                                        } else {
                                          // ki???m tra time next h???p l??? kh??ng
                                          if (medicalObject.checkTimeNext()) {
                                            medicalObject.checkDoneTask = false;
                                            medicalObject
                                                .setChangeVisibleButtonNext(); // ???n n??t // = false
                                            medicalObject
                                                .setChangeVisibleGlucose(); // hi???n nh???p glucose // = true
                                            medicalObject
                                                .setChangeCheckCurrentGlucose(); // ???? t???i b?????c nh???p glucose // = true
                                          }
                                          if (medicalObject.checkDoneTask) {
                                            showToast("Ch??a ?????n gi??? ??o ",
                                                duration: 3,
                                                gravity: Toast.bottom);
                                          }
                                        }
                                      } else {
                                        showToast("Ch??a ?????n gi??? ??o hihi",
                                            duration: 3, gravity: Toast.bottom);
                                      }
                                    } else {
                                      medicalObject.checkDoneTask = false;
                                      showToast("Ch??a ?????n gi??? ??o",
                                          duration: 3, gravity: Toast.bottom);
                                    }
                                    if (medicalObject.getContentdisplay !=
                                        medicalObject.delaySolution1DayAt22h) {
                                      setState(() {
                                        medicalObject.setChangeStatus();
                                      });
                                    } else {
                                      if (medicalObject.checkTimeNext()) {
                                        setState(() {
                                          medicalObject.setChangeStatus();
                                        });
                                      }
                                    }
                                  } else {
                                    showToast("Ch??a ?????n gi??? ??o ",
                                        duration: 3, gravity: Toast.bottom);
                                  }
                                },
                                child: const Text('Chuy???n ti???p >>>')),
                          ),

                          // Hi???n nh???p glucose
                          Visibility(
                            visible: medicalObject.isVisibleGlucose,
                            child: Column(
                              children: [
                                SizedBox(width: widthDevideMethod(0.05)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      ' Nh???p gi?? tr??? (mol/l) : ',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(
                                      width: 80,
                                      height: 40,
                                      child: TextField(
                                        controller: _editingController,
                                        maxLength: 5,
                                        enableSuggestions: false,
                                        autocorrect: false,
                                        keyboardType: const TextInputType
                                            .numberWithOptions(decimal: true),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp('[0-9.]')),
                                        ],
                                        decoration: const InputDecoration(
                                          counter: Offstage(),
                                        ),
                                        style: const TextStyle(fontSize: 20),
                                        onSubmitted: (value) {
                                          _editingController.text = '';
                                          _showDialogInputGlucose(value);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Hi???n nh???p C??n n???ng hi???n t???i
                          Visibility(
                            visible: medicalObject.isVisibleWeight &&
                                !medicalObject.getInitialStateBool,
                            child: Column(
                              children: [
                                SizedBox(width: widthDevideMethod(0.05)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      ' Nh???p c??n n???ng(Kg) : ',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(
                                      width: 80,
                                      height: 40,
                                      child: TextField(
                                        controller: _enterWeightController,
                                        maxLength: 5,
                                        enableSuggestions: false,
                                        autocorrect: false,
                                        keyboardType: const TextInputType
                                            .numberWithOptions(decimal: true),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp('[0-9.]')),
                                        ],
                                        decoration: const InputDecoration(
                                          counter: Offstage(),
                                        ),
                                        style: const TextStyle(fontSize: 20),
                                        onSubmitted: (value) {
                                          _editingController.text = '';
                                          _showDialogInputWeight(value);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          //Hi???n th??? s??? CHO
                          Visibility(
                            visible: medicalObject.isVisibleCarbon &&
                                medicalObject.getInitialStateBool,
                            child: Column(
                              children: [
                                SizedBox(width: widthDevideMethod(0.05)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      ' Nh???p l?????ng CarbonHydrat(CHO) : ',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(
                                      width: 80,
                                      height: 40,
                                      child: TextField(
                                        controller: _enterWeightController,
                                        maxLength: 5,
                                        enableSuggestions: false,
                                        autocorrect: false,
                                        keyboardType: const TextInputType
                                            .numberWithOptions(decimal: true),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp('[0-9.]')),
                                        ],
                                        decoration: const InputDecoration(
                                          counter: Offstage(),
                                        ),
                                        style: const TextStyle(fontSize: 20),
                                        onSubmitted: (value) {
                                          _editingController.text = '';
                                          _showDialogInputWeight(value);
                                        },
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
                  )
                ];
              } else if (snapshot.hasError) {
                children = <Widget>[
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'),
                  )
                ];
              } else {
                children = const <Widget>[
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Awaiting result...'),
                  )
                ];
              }
              return snapshot.hasData
                  ? SingleChildScrollView(
                      child: SafeArea(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: children,
                        ),
                      ),
                    )
                  : Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: children,
                        ),
                      ),
                    );
            }));
  }

  // show toast infomation
  void showToast(String msg, {int? duration, int? gravity}) {
    Toast.show(msg, duration: duration, gravity: gravity);
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Kh??i ph???c m???c ?????nh'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('D??? li???u s??? b??? x??a to??n b??? v??? tr???ng th??i ban ?????u '),
                Text('B???n c?? ch???c ch???n kh??ng ?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                setState(() {
                  medicalObject.flagRestart = true;
                  medicalObject.removeDataBase("Medicals/medical");
                  medicalObject.resetAllvalueIinitialStatedefaut();
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //  verifyle k???t qu???  ??o GLucose
  Future<void> _showDialogInputGlucose(String value) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('???????ng m??u mao m???ch'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Gi?? tr??? b???n nh???p v??o l?? ${value}'),
                Text('nh???n "Yes" ????? x??c nh???n ch??nh x??c ho???c "No" ????? nh???p l???i'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                setState(() {
                  this._logicStateInfomation(value);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //  verifyle k???t qu???  ??o C??n N???ng
  Future<void> _showDialogInputWeight(String value) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('C??n n???ng hi???n t???i'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Gi?? tr??? b???n nh???p v??o l?? ${value}'),
                Text('nh???n "Yes" ????? x??c nh???n ch??nh x??c ho???c "No" ????? nh???p l???i'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                setState(() {
                  medicalObject
                      .setChangeVisibleWeight(); // ???n thanh nh???p c??n n???ng = false
                  medicalObject
                      .setYInsu22H(double.parse(value)); // thay ?????i li???u UI
                  medicalObject
                      .setChangeVisibleButtonNext(); // hi???n n??t chuy???n ti???p = true
                  medicalObject.setChangeStatus(); // thay ?????i tr???ng th??i
                  medicalObject.setChangeCheckDoneTask(); // done task = true
                  medicalObject.timeNextValid(); // d???ne
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //  verifyle k???t qu???  ??o CHO
  Future<void> _showDialogInputCHO(String value) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('CHO hi???n t???i'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Gi?? tr??? b???n nh???p v??o l?? ${value}'),
                Text('nh???n "Yes" ????? x??c nh???n ch??nh x??c ho???c "No" ????? nh???p l???i'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                setState(() {
                  medicalObject
                      .setChangeVisibleCarbon(); // ???n thanh nh???p c??n n???ng = false
                  medicalObject
                      .setYInsu22H(double.parse(value)); // thay ?????i li???u UI
                  medicalObject
                      .setChangeVisibleButtonNext(); // hi???n n??t chuy???n ti???p = true
                  medicalObject.setChangeStatus(); // thay ?????i tr???ng th??i
                  medicalObject.setChangeCheckDoneTask(); // done task = true
                  medicalObject.timeNextValid(); // done
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // x??? l?? logic
  Future<void> _logicStateInfomation(String value) async {
    medicalObject
        .addItemListResultInjectionItem(value); // add data  list  k???t qu??? ??o
    if (medicalObject.getCountInject() >= 4) {
      if (medicalObject.getCheckPassInjection() == 0) {
        // chuy???n ?????i ph????ng ??n
        if (medicalObject.getInitialStateBool) {
          medicalObject.setInitialStateBool =
              false; // chuy???n t??? ko ti??m Insulin sang ti??m Insulin
        } else if (!medicalObject.getLastStateBool) {
          medicalObject.setLastStateBool = true; //  chuy???n ph????ng ??n cu???i
        } else {
          // k???t th??c ph??c ?????
          setState(() {
            medicalObject.checkBreak = true;
            medicalObject.setContentdisplay =
                "Ph??c ????? n??y kh??ng kh??? d???ng n???a, h??y s??? d???ng m???t ph??c ???? kh??c hi???u qu??? h??n";
            medicalObject.setChangeVisibleGlucose(); // ??n nha???p glucose
          });
        }
        if (!medicalObject.checkBreak) {
          //  x??a l???ch s??? ??o
          medicalObject.resetInjectionValueDefault();
          // add label v??o list history
          medicalObject.addLabelDatatoListHistoryFailed();
          // ki???m tra xem c?? th???t b???i l??c 22h kh??ng ????? ch??? 1 ng??y
          // if (getCheckOpenCloseTimeStatus('21:00', '21:30')) {
          //   medicalObject.updateTimeNextDay();
          //   medicalObject.setDelaySolution1DayAt22h();
          //   medicalObject
          //       .setChangeVisibleButtonNext(); // hi???n l???i n??t next // = flase
          //   medicalObject
          //       .setChangeVisibleGlucose(); // ???n thanh nh???p glucose // = false
          //   medicalObject.setChangeCheckCurrentGlucose(); // qua b?????c nh???p =true
          //   medicalObject
          //       .setChangeCheckDoneTask(); // ???? hi???n th??? ph????ng ??n // true
          //   medicalObject.timeNext = '21:00_21:30';
          // } else {
          //   medicalObject.addItemListHistory(value);
          // }
        }
      } else if (medicalObject.getCheckPassInjection() == 1) {
        medicalObject.resetInjectionValueDefault();
      } else {
        medicalObject.addItemListHistory(value); // add data to history
      }
    } else {
      medicalObject.addItemListHistory(value); // add data to history
    }

    // check d???ng ph??c ????
    if (!medicalObject.checkBreak) {
      print("co nhay hihi ${medicalObject.timeNext}");
      // ki???m tra xem ????ng  ng??y kh??ng
      if (medicalObject.checkTimeNextDay() && medicalObject.checkTimeNext()) {
        // Hi???n th??? ph??c ????? theo gi???
        if (!getCheckOpenCloseTimeStatus('21:00', '21:30') ||
            medicalObject.getInitialStateBool) {
          print("co nhay vo day !");
          setState(() {
            // double.parse(value.toString())

            medicalObject
                .setChangeCheckCurrentGlucose(); // nh???p xong hi???n ph??c ????? // = flase
            if (!medicalObject.isVisibleButtonNext)
              medicalObject
                  .setChangeVisibleButtonNext(); // hi???n l???i n??t next // flase
            medicalObject
                .setChangeVisibleGlucose(); //  ???n thanh nh???p Glucose // flase
            medicalObject.setChangeStatus(); // thay ?????i tr???ng th??i
            medicalObject.setChangeCheckDoneTask(); // ???? hi???n ph??c ????? // true
            medicalObject.timeNextValid();
            print("timeNext = ${medicalObject.timeNext}");
          });
        } else {
          setState(() {
            medicalObject.timeNextValid();
            medicalObject
                .setChangeVisibleGlucose(); // ???n thanh nh???p Glucose = false
            medicalObject
                .setChangeVisibleWeight(); // hi???n thanh nh???p C??n n???ng = True
            medicalObject
                .setChangeCheckCurrentGlucose(); // qua b?????c nh???p = false

            medicalObject.setChangeStatus(); // thay ?????i tr???ng th??i
          });
        }
      }
      Future.delayed(
          const Duration(seconds: 1),
          (() => showToast(
              "L?????ng Glucose $value ${medicalObject.getCheckGlucozo(double.parse(value.toString())) == 0 ? "?????t m???c ti??u" : "KH??NG ?????t m???c ti??u"} ",
              duration: 3,
              gravity: Toast.bottom)));
    }
  }

  // callback when change infomation
//   Future<void> _navigateAndDisplaySelection(BuildContext context) async {
//     // Navigator.push returns a Future that completes after calling
//     // Navigator.pop on the Selection Screen.
//     final result = await Navigator.push(
//       context,
//       // Create the SelectionScreen in the next step.
//       MaterialPageRoute(
//           builder: (context) => ProfileInfo(patienTemp: widget.patienTemp)),
//     );
//     try {
//       if (result) {
//         setState(() {});
//       }
//     } catch (e) {
//       print("null pop error");
//     }
//   }
}
