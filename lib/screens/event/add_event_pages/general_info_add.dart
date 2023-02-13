import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:intl/intl.dart';
import 'package:tessarus_volunteer/color_constants.dart';
import 'package:tessarus_volunteer/custom_widget/custom_appbar.dart';

import '../../../custom_widget/custom_text.dart';
import '../../../custom_widget/custom_textfield.dart';

class AddGeneralInfoEvent extends StatefulWidget {
  const AddGeneralInfoEvent({super.key});

  @override
  State<AddGeneralInfoEvent> createState() => _AddGeneralInfoEventState();
}

class _AddGeneralInfoEventState extends State<AddGeneralInfoEvent> {
  Color choiceChipColor = primaryColor;
  bool solo = false;
  //Date Time Configure
  late double _height;
  late double _width;

  late String _setTime, _setDate;

  late String _hour, _minute, _time;

  late String dateTime;

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = const TimeOfDay(hour: 00, minute: 00);

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _dateController2 = TextEditingController();
  final TextEditingController _timeController2 = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
      });
    }
  }

  Future<void> _selectDate2(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        _dateController2.text = DateFormat('dd/MM/yyyy').format(selectedDate);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        if (_hour.length == 1) _hour = '0$_hour';
        _minute = selectedTime.minute.toString();
        if (_minute.length == 1) _minute = '0$_minute';
        _time = '$_hour : $_minute';
        _timeController.text = _time;
      });
    }
  }

  Future<void> _selectTime2(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        if (_hour.length == 1) _hour = '0$_hour';
        _minute = selectedTime.minute.toString();
        if (_minute.length == 1) _minute = '0$_minute';
        _time = '$_hour : $_minute';
        _timeController2.text = _time;
      });
    }
  }

  @override
  void initState() {
    _dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());

    String h = DateTime.now().hour.toString();
    String m = DateTime.now().minute.toString();
    if (h.length == 1) h = '0$h';
    if (m.length == 1) m = '0$m';
    _timeController.text = '$h:$m';

    _dateController2.text = DateFormat('dd/MM/yyyy').format(DateTime.now());

    _timeController2.text = '$h:$m';

    super.initState();
  }

  TextEditingController title = TextEditingController();
  String description = 'Event Description';
  TextEditingController tagLine = TextEditingController();
  // TextEditingController startTime = TextEditingController();
  // TextEditingController endTime = TextEditingController();
  TextEditingController eventVenue = TextEditingController();
  // TextEditingController eventType = TextEditingController();
  TextEditingController eventMax = TextEditingController();
  TextEditingController eventMin = TextEditingController();
  TextEditingController eventPrice = TextEditingController();
  TextEditingController organiserClub = TextEditingController();
  String eventtype = 'Group';
  var items = ['Group', 'Solo'];

  String startDate = '';
  String startTime = '';
  String endDate = '';
  String endTime = '';
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    dateTime = DateFormat('dd/MM/yyyy').format(DateTime.now());
    return Scaffold(
      backgroundColor: primaryColor,
      resizeToAvoidBottomInset: true,
      appBar: appbar1('Add General Info', context),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 12, right: 12, top: 20, bottom: 22),
        child: SingleChildScrollView(
          child: Column(
            children: [
              tfield1(controller: title, label: 'Event Title'),
              const SizedBox(height: 12),

              const SizedBox(height: 12),
              tfield1(controller: tagLine, label: 'Event Tagline'),
              const SizedBox(height: 12),
              tfield1(controller: eventVenue, label: 'Event Venue'),

              const SizedBox(height: 12),
              //Date Time-----------------------
              startTimeWidget(context),
              const SizedBox(height: 12),
              endTimeWidget(context),
              const SizedBox(height: 12),
              eventTypeWidget(context),
              const SizedBox(height: 12),
              numfield1(controller: eventMin, label: 'Min Participants'),
              const SizedBox(height: 12),
              numfield1(controller: eventMax, label: 'Max Participants'),
              const SizedBox(height: 12),
              numfield1(controller: eventPrice, label: 'Event Price'),
              const SizedBox(height: 12),
              tfield1(controller: organiserClub, label: 'Organiser Club'),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget eventTypeWidget(BuildContext context) {
    return ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            backgroundColor: textfieldColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        child: Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 12),
            child: Column(children: [
              Row(
                children: [
                  Text(
                    'Event Type',
                    style: TextStyle(
                        color: textcolor5,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        eventtype = 'Group';
                        solo = false;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color:
                              (solo == false) ? primaryColor : textfieldColor,
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, left: 18, right: 18),
                          child: ctext1('Group', textcolor2, 12)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        eventtype = 'Solo';
                        solo = true;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: (solo == true) ? primaryColor : textfieldColor,
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, left: 18, right: 18),
                          child: ctext1('Solo', textcolor2, 12)),
                    ),
                  ),
                ],
              )
            ])));
  }

  Widget startTimeWidget(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
          backgroundColor: textfieldColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      child: Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 8),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  flex: 3,
                  child: Text(
                    'Event Start Time',
                    style: TextStyle(
                        color: textcolor5,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const Spacer(),
                Flexible(
                  flex: 1,
                  child: TextFormField(
                    style: TextStyle(
                        color: textcolor5,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                    enabled: false,
                    keyboardType: TextInputType.number,
                    controller: _timeController,
                    onChanged: (value) {
                      _setTime = value;
                    },
                    // onSaved: (String val) {
                    //   _setDate = val;
                    // },
                    decoration: const InputDecoration(
                        disabledBorder:
                            UnderlineInputBorder(borderSide: BorderSide.none),
                        // labelText: 'Time',
                        contentPadding: EdgeInsets.only(top: 0.0)),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: TextFormField(
                    style: TextStyle(
                        color: textcolor5,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                    enabled: false,
                    keyboardType: TextInputType.number,
                    controller: _dateController,
                    onChanged: (value) {
                      _setDate = value;
                    },
                    decoration: const InputDecoration(
                        disabledBorder:
                            UnderlineInputBorder(borderSide: BorderSide.none),
                        // labelText: 'Time',
                        contentPadding: EdgeInsets.only(top: 0.0)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14))),
                    onPressed: () {
                      _selectDate(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Choose Date',
                            style: TextStyle(
                                color: textcolor2,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5),
                          ),
                          const SizedBox(width: 12),
                          Icon(FontAwesome.calendar,
                              color: textcolor2, size: 22)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14))),
                    onPressed: () {
                      _selectTime(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Choose Time',
                            style: TextStyle(
                                color: textcolor2,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5),
                          ),
                          const SizedBox(width: 12),
                          Icon(FontAwesome.clock, color: textcolor2, size: 22)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget endTimeWidget(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
          backgroundColor: textfieldColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      child: Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 8),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  flex: 3,
                  child: Text(
                    'Event End Time',
                    style: TextStyle(
                        color: textcolor5,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const Spacer(),
                Flexible(
                  flex: 1,
                  child: TextFormField(
                    style: TextStyle(
                        color: textcolor5,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                    enabled: false,
                    keyboardType: TextInputType.number,
                    controller: _timeController2,
                    onChanged: (value) {
                      _setTime = value;
                    },
                    // onSaved: (String val) {
                    //   _setDate = val;
                    // },
                    decoration: const InputDecoration(
                        disabledBorder:
                            UnderlineInputBorder(borderSide: BorderSide.none),
                        // labelText: 'Time',
                        contentPadding: EdgeInsets.only(top: 0.0)),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: TextFormField(
                    style: TextStyle(
                        color: textcolor5,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                    enabled: false,
                    keyboardType: TextInputType.number,
                    controller: _dateController2,
                    onChanged: (value) {
                      _setDate = value;
                    },
                    // onSaved: (String val) {
                    //   _setDate = val;
                    // },
                    decoration: const InputDecoration(
                        disabledBorder:
                            UnderlineInputBorder(borderSide: BorderSide.none),
                        // labelText: 'Time',
                        contentPadding: EdgeInsets.only(top: 0.0)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14))),
                    onPressed: () {
                      _selectDate2(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Choose Date',
                            style: TextStyle(
                                color: textcolor2,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5),
                          ),
                          const SizedBox(width: 12),
                          Icon(FontAwesome.calendar,
                              color: textcolor2, size: 22)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14))),
                    onPressed: () {
                      _selectTime2(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Choose Time',
                            style: TextStyle(
                                color: textcolor2,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5),
                          ),
                          const SizedBox(width: 12),
                          Icon(FontAwesome.clock, color: textcolor2, size: 22)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
