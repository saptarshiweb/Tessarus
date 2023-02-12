// ignore_for_file: non_constant_identifier_names, unused_local_variable, avoid_print, use_build_context_synchronously, unused_field
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/iconic_icons.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tessarus_volunteer/color_constants.dart';
import 'package:tessarus_volunteer/custom_widget/custom_appbar.dart';
import 'package:http/http.dart' as http;
import 'package:tessarus_volunteer/custom_widget/custom_text.dart';
import 'package:tessarus_volunteer/custom_widget/custom_textfield.dart';
import 'package:tessarus_volunteer/custom_widget/loader_widget.dart';
import 'package:tessarus_volunteer/models/api_url.dart';
import 'package:tessarus_volunteer/models/event_display_model.dart';
import 'package:tessarus_volunteer/screens/event/event_page.dart';
import '../../custom_widget/custom_modal_routes.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
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

  //Date time End---
  String auth_val = '';
  //event add controllers
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
  addNewEvent(BuildContext context) {
    eventAdd();
  }

  Future eventAdd() async {
    //organiser club
    showLoaderDialog(context);

    print(description);

    String h1 = '', m1 = '';
    String s2 = _timeController.text;
    int ind = 0;
    for (int i = 0; i < s2.length; i++) {
      if (s2[i] == ':') {
        ind = i;
        break;
      }
    }

    h1 = s2.substring(0, ind - 1);
    m1 = s2.substring(ind + 1);
    if (h1.length == 1) h1 = '0$h1';
    if (m1.length == 1) m1 = '0$m1';
    startTime = "$h1:$m1:00";

    ind = 0;
    s2 = _timeController2.text;
    h1 = '';
    m1 = '';
    for (int i = 0; i < s2.length; i++) {
      if (s2[i] == ':') {
        ind = i;
        break;
      }
    }

    h1 = s2.substring(0, ind - 1);
    m1 = s2.substring(ind + 1);
    if (h1.length == 1) h1 = '0$h1';
    if (m1.length == 1) m1 = '0$m1';
    endTime = "$h1:$m1:00";

    String startTime2 = '', endTime2 = '';
    for (int i = 0; i < startTime.length; i++) {
      if (startTime[i] != ' ') startTime2 += startTime[i];
    }
    startTime = startTime2;
    for (int i = 0; i < endTime.length; i++) {
      if (endTime[i] != ' ') endTime2 += endTime[i];
    }
    endTime = endTime2;

    String year1 = _dateController.text.substring(6);
    String year2 = _dateController2.text.substring(6);

    String month1 = _dateController.text.substring(3, 5);
    String month2 = _dateController2.text.substring(3, 5);

    String day1 = _dateController.text.substring(0, 2);
    String day2 = _dateController2.text.substring(0, 2);

    startTime = '''$year1-$month1-$day1 $startTime''';
    endTime = '''$year2-$month2-$day2 $endTime''';

//debug Testing

    EventOrganiserClub club =
        EventOrganiserClub(name: organiserClub.text, image: 'http');

    List<EventCoordinatorsAdd> eventCoordinator1 = [];

    if (total_coordinator >= 1) {
      EventCoordinatorsAdd e1 = EventCoordinatorsAdd(
          name: nameCoordinator1.text, phone: phoneCoordinator1.text);
      eventCoordinator1.add(e1);
    }
    if (total_coordinator >= 2) {
      EventCoordinatorsAdd e1 = EventCoordinatorsAdd(
          name: nameCoordinator2.text, phone: phoneCoordinator2.text);
      eventCoordinator1.add(e1);
    }
    if (total_coordinator == 3) {
      EventCoordinatorsAdd e1 = EventCoordinatorsAdd(
          name: nameCoordinator3.text, phone: phoneCoordinator3.text);
      eventCoordinator1.add(e1);
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? auth = prefs.getString("Auth");
    auth_val = auth!;
    var body = {
      'title': title.text,
      'description': description,
      'tagLine': tagLine.text,
      'startTime': startTime,
      'endTime': endTime,
      'eventVenue': eventVenue.text,
      'eventType': eventtype.toLowerCase(),
      'eventMaxParticipants': eventMax.text,
      'eventMinParticipants': eventMin.text,
      'eventPrice': eventPrice.text,
      'eventOrganiserClub': {'name': organiserClub.text, 'image': 'http'},
      'eventCoordinators': eventCoordinator1
    };
    final response = await http.post(Uri.parse(add_event),
        headers: <String, String>{
          'Content-Type': 'application/json',
          // 'Accept': 'application/json',
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Credentials': 'true',
          'Access-Control-Allow-Headers': 'Content-Type',
          'Access-Control-Allow-Methods': 'GET,PUT,POST,DELETE',
          'Authorization': 'Bearer $auth_val'
        },
        // body: jsonEncode(<String, String>),

        body: json.encode(body));

    var responseval = json.decode(response.body);
    Navigator.pop(context);
    if (responseval['message'] != 'Event added successfully') {
      showModalBottomSheet(
          backgroundColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          context: context,
          builder: (context) {
            return errorModal2(responseval['message'], context);
          });
    } else {
      showModalBottomSheet(
          backgroundColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          context: context,
          builder: (context) {
            return successModal2(
                responseval['message'], context, const EventPage());
          });
    }

    print(response.body);
  }

  //coordinator Space
  int total_coordinator = 0;
  int max_coordinator = 3;
  int cooIndex = 0;
  bool showCoordinatorAdd = false;
  TextEditingController phoneCoordinator1 = TextEditingController();
  TextEditingController phoneCoordinator2 = TextEditingController();
  TextEditingController phoneCoordinator3 = TextEditingController();
  TextEditingController nameCoordinator1 = TextEditingController();
  TextEditingController nameCoordinator2 = TextEditingController();
  TextEditingController nameCoordinator3 = TextEditingController();

  List<TextEditingController> coordinatorName = [];
  List<TextEditingController> coordinatorPhone = [];

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    dateTime = DateFormat('dd/MM/yyyy').format(DateTime.now());
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: appbar1('Add Event Details', context),
      backgroundColor: primaryColor,
      body: Padding(
        padding:
            const EdgeInsets.only(left: 12, right: 12, top: 20, bottom: 22),
        child: SingleChildScrollView(
          child: Column(
            children: [
              tfield1(controller: title, label: 'Event Title'),
              const SizedBox(height: 12),
              // descfield1(controller: description, label: 'Event Description'),
              preCustomEditor(context, 'Event Description'),
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
              coordinatorHeader(context),
              const SizedBox(height: 12),
              (total_coordinator > 0)
                  ? coordinatorDisplayContainer(context)
                  : const SizedBox(height: 0, width: 0),
              (showCoordinatorAdd == true)
                  ? addCoordinatorContainer()
                  : const SizedBox(height: 0, width: 0),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: containerColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                          onPressed: () async {
                            eventAdd();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15, bottom: 15),
                            child: ctext1('Confirm', primaryColor, 16),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget preCustomEditor(BuildContext context, String title) {
    HtmlEditorController controller = HtmlEditorController();
    return Container(
        decoration: BoxDecoration(
            color: textcolor2.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ctext1(title, textcolor2.withOpacity(0.6), 14),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.8,
                              child: Column(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(
                                          FontAwesome.cancel_circled),
                                      iconSize: 22,
                                      color: textcolor2),
                                  const SizedBox(height: 6),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            topRight: Radius.circular(12)),
                                        color: textcolor2),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20, bottom: 6),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          ctext1(
                                              'Add $title', primaryColor, 18),
                                          const SizedBox(height: 15),
                                          HtmlEditor(
                                            htmlToolbarOptions:
                                                HtmlToolbarOptions(
                                                    textStyle: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: textcolor1),
                                                    toolbarType: ToolbarType
                                                        .nativeExpandable,
                                                    toolbarPosition:
                                                        ToolbarPosition
                                                            .belowEditor,
                                                    defaultToolbarButtons: [
                                                  const ListButtons(
                                                      listStyles: false),
                                                  const StyleButtons(
                                                      style: true),
                                                  const FontSettingButtons(
                                                      fontSizeUnit: false,
                                                      fontSize: true,
                                                      fontName: true),
                                                  const FontButtons(
                                                      superscript: false,
                                                      subscript: false,
                                                      clearAll: false,
                                                      strikethrough: false),
                                                  const ColorButtons(
                                                      foregroundColor: true,
                                                      highlightColor: true),
                                                  const ParagraphButtons(
                                                      textDirection: false,
                                                      caseConverter: false,
                                                      lineHeight: false,
                                                      increaseIndent: false,
                                                      decreaseIndent: false),
                                                  const InsertButtons(
                                                      link: false,
                                                      picture: false,
                                                      audio: false,
                                                      video: false,
                                                      otherFile: false,
                                                      table: false,
                                                      hr: false)
                                                ]),
                                            otherOptions: const OtherOptions(),
                                            controller: controller,
                                            htmlEditorOptions:
                                                const HtmlEditorOptions(
                                                    hint:
                                                        'Enter your text here...'),
                                          ),
                                          const SizedBox(height: 20),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20, right: 20),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              containerColor,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12))),
                                                      onPressed: () async {
                                                        String v =
                                                            await controller
                                                                .getText();
                                                        print(v);

                                                        setState(() {
                                                          description = v;
                                                        });

                                                        Navigator.pop(context);
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 14,
                                                                bottom: 14),
                                                        child: ctext1('Done',
                                                            primaryColor1, 14),
                                                      )),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                    // normalNavigation(
                    //     CustomTextEditor(title, description,context), context);
                  },
                  icon: const Icon(FontAwesome.right_open),
                  iconSize: 16,
                  color: textcolor2.withOpacity(0.6))
            ],
          ),
        ));
  }

  Widget coordinatorDisplayContainer(BuildContext context) {
    return ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            backgroundColor: textcolor2.withOpacity(0.1),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              (total_coordinator >= 1)
                  ? coordinatorListTile(context, 1)
                  : const SizedBox(height: 0, width: 0),
              (total_coordinator >= 2)
                  ? coordinatorListTile(context, 2)
                  : const SizedBox(height: 0, width: 0),
              (total_coordinator >= 3)
                  ? coordinatorListTile(context, 3)
                  : const SizedBox(height: 0, width: 0),
            ])));
  }

  Widget coordinatorListTile(BuildContext context, int ind) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              smbold('Coordinator $ind added !!'),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget coordinatorHeader(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
          backgroundColor: textcolor2.withOpacity(0.1),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Add Coordinators',
              style: TextStyle(
                  color: textcolor2.withOpacity(0.5),
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            IconButton(
                onPressed: () {
                  if (total_coordinator >= 3) {
                    showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        context: context,
                        builder: (context) {
                          return errorModal2(
                              'Maximum Limit of 3 Coordinators already reached!',
                              context);
                        });
                  } else {
                    setState(() {
                      showCoordinatorAdd = true;
                    });
                  }
                },
                icon: Icon(Iconic.plus_circle, color: textcolor2, size: 22))
          ],
        ),
      ),
    );
  }

  Widget addCoordinatorContainer() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Container(
        decoration: BoxDecoration(
            color: textcolor2.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 5, bottom: 8, left: 10, right: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        ctext1('Add Coordinator ${total_coordinator + 1}',
                            textcolor2.withOpacity(0.5), 16),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                showCoordinatorAdd = false;
                              });
                            },
                            icon: Icon(Iconic.cancel_circle,
                                color: textcolor2, size: 22))
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              (total_coordinator == 0)
                  ? tfield1(controller: nameCoordinator1, label: 'Name')
                  : const SizedBox(height: 0, width: 0),
              (total_coordinator == 1)
                  ? tfield1(controller: nameCoordinator2, label: 'Name')
                  : const SizedBox(height: 0, width: 0),
              (total_coordinator == 2)
                  ? tfield1(controller: nameCoordinator3, label: 'Name')
                  : const SizedBox(height: 0, width: 0),
              const SizedBox(height: 6),
              (total_coordinator == 0)
                  ? numfield1(controller: phoneCoordinator1, label: 'Phone')
                  : const SizedBox(height: 0, width: 0),
              (total_coordinator == 1)
                  ? numfield1(controller: phoneCoordinator2, label: 'Phone')
                  : const SizedBox(height: 0, width: 0),
              (total_coordinator == 2)
                  ? numfield1(controller: phoneCoordinator3, label: 'Phone')
                  : const SizedBox(height: 0, width: 0),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            backgroundColor: primaryColor),
                        onPressed: () {
                          setState(() {
                            total_coordinator++;
                            cooIndex++;
                            showCoordinatorAdd = false;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Text(
                            'Add',
                            style: TextStyle(
                                color: textcolor2,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        )),
                  )
                ],
              )
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
            backgroundColor: textcolor2.withOpacity(0.1),
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
                        color: textcolor2.withOpacity(0.5),
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
                          color: (solo == false)
                              ? primaryColor
                              : textcolor2.withOpacity(0.1),
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
                          color: (solo == true)
                              ? primaryColor
                              : textcolor2.withOpacity(0.1),
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
          backgroundColor: textcolor2.withOpacity(0.1),
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
                        color: textcolor2.withOpacity(0.5),
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const Spacer(),
                Flexible(
                  flex: 1,
                  child: TextFormField(
                    style: TextStyle(
                        color: textcolor2.withOpacity(0.5),
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
                        color: textcolor2.withOpacity(0.5),
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
          backgroundColor: textcolor2.withOpacity(0.1),
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
                        color: textcolor2.withOpacity(0.5),
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const Spacer(),
                Flexible(
                  flex: 1,
                  child: TextFormField(
                    style: TextStyle(
                        color: textcolor2.withOpacity(0.5),
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
                        color: textcolor2.withOpacity(0.5),
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
