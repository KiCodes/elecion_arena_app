import 'package:election_arena_app/constants/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';

import '../main.dart';

class VoteDetails extends StatefulWidget {
  const VoteDetails({Key? key}) : super(key: key);

  @override
  State<VoteDetails> createState() => _VoteDetailsState();
}

class _VoteDetailsState extends State<VoteDetails> {
  bool _isLogin = true;
  bool _isExpanded = false;
  bool _isManStartCheck = false;
  bool _isSchStartCheck = false;
  bool _isTestCheck = false;
  bool _isRunCheck = false;
  bool _isHiSecurityCheck = false;
  bool _isNmSecurityCheck = false;
  bool _isSecretBCheck = false;
  bool _isPublicBCheck = false;
  bool _isAlwaysCheck = false;
  bool _isOnlyCheck = false;
  bool _isVoterDenyCheck = false;
  bool _isVoterOnlyAfterCheck = false;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _orgNameController = TextEditingController();
  final TextEditingController _minController = TextEditingController(text: '');
  final TextEditingController _secController = TextEditingController(text: '');

  //datetime variable
  late DateTime _dateTime;
  late String _monthStart;
  late String _dayStart;
  late String _monthEnd;
  late String _dayEnd;
  late int _daysInMonth;

  //time variables
  late TimeOfDay _timeOfDayStart;
  late TimeOfDay _timeOfDayEnd;
  bool _isClearStart = false;
  bool _isClearEnd = false;

  @override
  void initState() {
    super.initState();
    DateTime dateTime = DateTime.now();
    DateTime dateTimeEnd = DateTime.now().add(const Duration(days: 2));
    String month = DateFormat('MMMM').format(dateTime);
    String day = DateFormat('dd').format(dateTime);
    String monthEnd = DateFormat('MMMM').format(dateTimeEnd);
    String dayEnd = DateFormat('dd').format(dateTimeEnd);
    TimeOfDay timeOfDay = TimeOfDay.now();
    int daysInMonth = DateTime(dateTime.year, dateTime.month + 1, 0).day;
    setState(() {
      _dateTime = dateTime;
      _monthStart = month;
      _monthEnd = monthEnd;
      _dayEnd = dayEnd;
      _dayStart = day;
      _timeOfDayStart = timeOfDay;
      _timeOfDayEnd = timeOfDay;
      _isClearStart = false;
      _isClearEnd = false;
      _daysInMonth = daysInMonth;
    });
  }

  void _showDatePickerStart() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2023),
            lastDate: DateTime(2103))
        .then((value) {
      setState(() {
        _dateTime = value!;
        _monthStart = DateFormat('MMMM').format(value);
        _dayStart = DateFormat('dd').format(value);
      });
    });
  }

  void _showDatePickerEnd() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2023),
            lastDate: DateTime(2103))
        .then((value) {
      setState(() {
        _dateTime = value!;
        _monthEnd = DateFormat('MMMM').format(value);
        _dayEnd = DateFormat('dd').format(value);
      });
    });
  }

  Future<void> _showTimePickerStart() async {
    TimeOfDay? _picked = await showTimePicker(
      context: context,
      initialTime: _timeOfDayStart!,
    );
    if (_picked != null) {
      setState(() {
        _timeOfDayStart = _picked;
        _isClearStart = false;
      });
    }
  }

  Future<void> _showTimePickerStartEnd() async {
    TimeOfDay? _picked = await showTimePicker(
      context: context,
      initialTime: _timeOfDayEnd!,
    );
    if (_picked != null) {
      setState(() {
        _timeOfDayEnd = _picked;
        _isClearEnd = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: AppBarPanel(theme: theme, isLogin: _isLogin),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              icon: Icon(
                _isExpanded ? Icons.close : Icons.menu,
                color: theme.onBackground,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                          width: 4,
                          color: theme.secondary,
                        ),
                        bottom: BorderSide(width: 4, color: theme.secondary))),
                padding: const EdgeInsets.fromLTRB(20, 3, 2, 3),
                child: Row(
                  children: [
                    Text(
                      'Vote details',
                      style: TextStyle(
                          fontSize: 19,
                          color: theme.onBackground,
                          fontWeight: FontWeight.bold),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.white,
                      size: 28,
                    )
                  ],
                ),
              ),
              //watch vidoe subtext
              Padding(
                padding: const EdgeInsets.fromLTRB(25.0, 5, 25.0, 5),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Watch our ',
                          style: TextStyle(color: theme.onBackground)),
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async =>
                                await launchUrlString('https://google.com'),
                          text: 'video',
                          style: TextStyle(
                              color: theme.secondary,
                              decoration: TextDecoration.underline)),
                      TextSpan(
                          text:
                              ' for guidance on how to complete election details on mobile',
                          style: TextStyle(color: theme.onBackground))
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              //vote title
              const Padding(
                padding: EdgeInsets.fromLTRB(14.0, 5, 14.0, 5),
                child: Text(
                  'Vote title:',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ),
              ),
              //vote text input
              Padding(
                padding: const EdgeInsets.fromLTRB(14.0, 5, 14.0, 5),
                child: Neumorphic(
                  padding: const EdgeInsets.fromLTRB(20.0, 2, 10.0, 2),
                  style: NeumorphicStyle(
                    depth: 23,
                    color: theme.primary,
                    shadowLightColor: Colors.white.withOpacity(0.3),
                    shadowDarkColor: Colors.white.withOpacity(0.3),
                    intensity: 22,
                    lightSource: LightSource.bottom,
                    boxShape: const NeumorphicBoxShape.rect(),
                  ),
                  child: TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                        fillColor: theme.primary,
                        hintText: 'Title of vote',
                        hintStyle: const TextStyle(color: Colors.white)),
                  ),
                ),
              ),
              //manual vote checkbox
              Row(
                children: [
                  Checkbox(
                    value: _isManStartCheck,
                    shape: const CircleBorder(),
                    onChanged: (value) {
                      setState(() {
                        if (!_isManStartCheck) {
                          _isManStartCheck = value!;
                          _isSchStartCheck = false;
                        }else{
                          _isManStartCheck = true;
                          _isSchStartCheck = false;
                        }
                      });
                    },
                  ),
                  Flexible(
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          if (_isManStartCheck == false) {
                            _isManStartCheck = true;
                            _isSchStartCheck = false;
                          }
                          else{
                            _isManStartCheck = true;
                            _isSchStartCheck = false;
                          }
                        });
                      },
                      child: const Text(
                        'Manually start the vote and automatically end after :',
                        maxLines: null, // enables text wrapping

                        style: TextStyle(fontSize: 19),
                      ),
                    ),
                  )
                ],
              ),
              //to be checked
              _isManStartCheck
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(14.0, 5, 14.0, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 13,
                          ),
                          Container(
                            width: 50,
                            child: TextFormField(
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                filled: true,
                                fillColor: Colors.grey[200],
                                hintText: '59',
                                hintStyle:
                                    const TextStyle(color: Colors.blueGrey),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              controller: _minController,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                                _TimeFormatter(),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 13,
                          ),
                          const Text(
                            ':',
                            style: TextStyle(fontSize: 19),
                          ),
                          const SizedBox(
                            width: 13,
                          ),
                          Container(
                            width: 50,
                            child: TextFormField(
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                filled: true,
                                fillColor: Colors.grey[200],
                                hintText: '00',
                                hintStyle:
                                    const TextStyle(color: Colors.blueGrey),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              controller: _secController,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                                _TimeFormatter(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
              //to be checked
              _isManStartCheck
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          '   Minutes : Seconds',
                          style: TextStyle(fontSize: 19),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
              // hint texts
              Padding(
                padding: const EdgeInsets.fromLTRB(46.0, 5, 46.0, 5),
                child: Text(
                  'Use for meetings agendas and motions',
                  style: TextStyle(fontSize: 16, color: theme.inverseSurface),
                ),
              ),
              //schedule check
              Row(
                children: [
                  Checkbox(
                    value: _isSchStartCheck,
                    shape: const CircleBorder(),
                    onChanged: (value) {
                      setState(() {
                        if (!_isSchStartCheck) {
                          _isSchStartCheck = value!;
                          _isManStartCheck = false;
                        }else{
                          _isSchStartCheck = true;
                          _isManStartCheck = false;
                        }
                      });
                    },
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          if (_isSchStartCheck == false) {
                            _isSchStartCheck = true;
                            _isManStartCheck = false;
                          }else{
                            _isSchStartCheck = true;
                            _isManStartCheck = false;
                          }
                        });
                      },
                      child: const Text(
                        'Schedule a Start and End time',
                        maxLines: null, // enables text wrapping

                        style: TextStyle(fontSize: 19),
                      ),
                    ),
                  )
                ],
              ),
              //Start date time
              _isSchStartCheck
                  ? const Padding(
                padding: EdgeInsets.fromLTRB(46.0, 5, 46.0, 5),
                child: Text(
                  'Start date and Time',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ),
              )
                  : const SizedBox.shrink(),
              //date time buttons
              _isSchStartCheck
              ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(46.0, 5, 0, 5),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.fromBorderSide(
                              BorderSide(width: 3, color: theme.secondary))),
                      child: MaterialButton(
                        onPressed: _showDatePickerStart,
                        color: theme.primary,
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Text(
                            '$_monthStart $_dayStart',
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.fromBorderSide(
                              BorderSide(width: 3, color: theme.secondary))),
                      child: MaterialButton(
                        onPressed: _showTimePickerStart,
                        visualDensity: VisualDensity.comfortable,
                        color: theme.primary,
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Text(
                            !_isClearStart
                                ? _timeOfDayStart.hour
                                        .toString()
                                        .padLeft(2, '0') +
                                    ':' +
                                    _timeOfDayStart.minute
                                        .toString()
                                        .padLeft(2, '0')
                                : '',
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Container(
                      child: MaterialButton(
                        onPressed: () {
                          setState(() {
                            _monthStart = '';
                            _dayStart = '';
                            _isClearStart = true;
                          });
                        },
                        visualDensity: VisualDensity.comfortable,
                        color: theme.primary,
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: NeumorphicIcon(
                            Icons.cancel_presentation,
                            style: NeumorphicStyle(
                              color: theme.onBackground,
                              depth: 34,
                              shape: NeumorphicShape.concave,
                              intensity: 33,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
              : const SizedBox.shrink(),
              // hint texts
              _isSchStartCheck
              ? Flexible(
                fit: FlexFit.loose,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(46.0, 5, 46.0, 5),
                  child: RichText(
                    text: TextSpan(
                        style: TextStyle(
                            fontSize: 16, color: theme.inverseSurface),
                        children: [
                          const TextSpan(
                            text:
                                'Voting starts at this date. For example You can choose start voting ',
                          ),
                          TextSpan(
                              text: 'Now ',
                              style: TextStyle(
                                  fontSize: 16, color: theme.secondary),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  setState(() {
                                    _monthStart = DateFormat('MMMM')
                                        .format(DateTime.now());
                                    _dayStart =
                                        DateFormat('dd').format(DateTime.now());
                                    _timeOfDayStart = TimeOfDay.now();
                                  });
                                }),
                          const TextSpan(
                            text: 'or ',
                          ),
                          TextSpan(
                              text: ' Tomorrow',
                              style: TextStyle(
                                  fontSize: 16, color: theme.secondary),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  setState(() {
                                    _monthStart = DateFormat('MMMM')
                                        .format(DateTime.now());
                                    _dayStart = DateFormat('dd').format(
                                        DateTime.now().add(const Duration(days: 1)));
                                    _timeOfDayStart = TimeOfDay.now();

                                    if (DateTime.now().day + 1 > _daysInMonth) {
                                      // Next day is in the next month
                                      _monthStart = DateFormat('MMMM').format(
                                        DateTime.now().add(const Duration(days: 1)),
                                      );
                                    }
                                  });
                                })
                        ]),
                  ),
                ),
              )
              : const SizedBox.shrink(),
              //end date time
              _isSchStartCheck
              ? const Padding(
                padding: EdgeInsets.fromLTRB(46.0, 5, 46.0, 5),
                child: Text(
                  'End date and Time',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ),
              )
              : const SizedBox.shrink(),
              //date time buttons end
              _isSchStartCheck
              ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(46.0, 5, 0, 5),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.fromBorderSide(
                              BorderSide(width: 3, color: theme.secondary))),
                      child: MaterialButton(
                        onPressed: _showDatePickerEnd,
                        color: theme.primary,
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Text(
                            '$_monthEnd $_dayEnd',
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.fromBorderSide(
                              BorderSide(width: 3, color: theme.secondary))),
                      child: MaterialButton(
                        onPressed: _showTimePickerStartEnd,
                        visualDensity: VisualDensity.comfortable,
                        color: theme.primary,
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Text(
                            !_isClearEnd
                                ? _timeOfDayEnd.hour
                                        .toString()
                                        .padLeft(2, '0') +
                                    ':' +
                                    _timeOfDayEnd.minute
                                        .toString()
                                        .padLeft(2, '0')
                                : '',
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Container(
                      child: MaterialButton(
                        onPressed: () {
                          setState(() {
                            _monthEnd = '';
                            _dayEnd = '';
                            _isClearEnd = true;
                          });
                        },
                        visualDensity: VisualDensity.comfortable,
                        color: theme.primary,
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: NeumorphicIcon(
                            Icons.cancel_presentation,
                            style: NeumorphicStyle(
                              color: theme.onBackground,
                              depth: 34,
                              shape: NeumorphicShape.concave,
                              intensity: 33,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
              : const SizedBox.shrink(),
              // hint texts
              _isSchStartCheck
              ? Flexible(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(46.0, 5, 46.0, 5),
                  child: RichText(
                    text: TextSpan(
                        style: TextStyle(
                            fontSize: 16, color: theme.inverseSurface),
                        children: [
                          const TextSpan(
                            text:
                                'Voting ends automatically at this date. Choose date and time to end voting'
                                'such as ',
                          ),
                          TextSpan(
                              text: 'in 12 hours ',
                              style: TextStyle(
                                  fontSize: 16, color: theme.secondary),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  setState(() {
                                    _dayEnd = DateFormat('dd').format(
                                        DateTime.now()
                                            .add(const Duration(hours: 12)));
                                    _timeOfDayEnd = TimeOfDay.fromDateTime(
                                        DateTime.now()
                                            .add(const Duration(hours: 12)));
                                  });
                                }),
                          const TextSpan(
                            text: 'or ',
                          ),
                          TextSpan(
                              text: ' in a week',
                              style: TextStyle(
                                  fontSize: 16, color: theme.secondary),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  setState(() {
                                    _monthEnd = DateFormat('MMMM').format(
                                        DateTime.now().add(const Duration(days: 7)));
                                    _dayEnd = DateFormat('dd').format(
                                        DateTime.now().add(const Duration(days: 7)));
                                    _timeOfDayEnd = TimeOfDay.now();
                                  });
                                })
                        ]),
                  ),
                ),
              )
              : const SizedBox.shrink(),
              const Padding(
                padding: EdgeInsets.fromLTRB(14.0, 5, 14.0, 5),
                child: Text('Organization Details', style: TextStyle(
                  fontSize: 34
                ),),
              ),
              const SizedBox(height: 35,),
              const Padding(
                padding: EdgeInsets.fromLTRB(14.0, 5, 14.0, 5),
                child: Text(
                  'Organization name:',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14.0, 5, 14.0, 5),
                child: Neumorphic(
                  padding: const EdgeInsets.fromLTRB(20.0, 2, 10.0, 2),
                  style: NeumorphicStyle(
                    depth: 23,
                    color: theme.primary,
                    shadowLightColor: Colors.white.withOpacity(0.3),
                    shadowDarkColor: Colors.white.withOpacity(0.3),
                    intensity: 22,
                    lightSource: LightSource.bottom,
                    boxShape: const NeumorphicBoxShape.rect(),
                  ),
                  child: TextField(
                    controller: _orgNameController,
                    decoration: InputDecoration(
                        fillColor: theme.primary,
                        hintText: 'Name of your organization',
                        hintStyle: const TextStyle(color: Colors.white)),
                  ),
                ),
              ),
              // vote options text
              const Padding(
                padding: EdgeInsets.fromLTRB(14.0, 5, 14.0, 5),
                child: Text('Vote Options ', style: TextStyle(
                    fontSize: 34
                ),),
              ),
              const SizedBox(height: 35),
              // test or run
              const Padding(
                padding: EdgeInsets.fromLTRB(14.0, 5, 14.0, 5),
                child: Text(
                  'Test or Run',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ),
              ),
              //checkbox
              Row(
                children: [
                  Checkbox(
                    value: _isTestCheck,
                    shape: const CircleBorder(),
                    onChanged: (value) {
                      setState(() {
                        if (!_isTestCheck) {
                          _isTestCheck = value!;
                          _isRunCheck = false;
                        }else{
                          _isTestCheck = true;
                          _isRunCheck = false;
                        }
                      });
                    },
                  ),
                  Flexible(
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          if (_isTestCheck == false) {
                            _isTestCheck = true;
                            _isRunCheck = false;
                          }else{
                            _isTestCheck = true;
                            _isRunCheck = false;
                          }
                        });
                      },
                      child: const Text(
                        'Test',
                        maxLines: null, // enables text wrapping

                        style: TextStyle(fontSize: 19),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(46.0, 5, 46.0, 5),
                child: Text(
                  'Up to 5 voters, all available features. Free.',
                  style: TextStyle(fontSize: 16, color: theme.inverseSurface),
                ),
              ),
              //checkbox
              Row(
                children: [
                  Checkbox(
                    value: _isRunCheck,
                    shape: const CircleBorder(),
                    onChanged: (value) {
                      setState(() {
                        if (!_isRunCheck) {
                          _isRunCheck = value!;
                          _isTestCheck = false;
                        }else{
                          _isRunCheck = true;
                          _isTestCheck = false;
                        }
                      });
                    },
                  ),
                  Flexible(
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          if (!_isRunCheck) {
                            _isRunCheck = true;
                            _isTestCheck = false;
                          }else{
                            _isRunCheck = true;
                            _isTestCheck = false;
                          }
                        });
                      },
                      child: const Text(
                        'Live',
                        maxLines: null, // enables text wrapping

                        style: TextStyle(fontSize: 19),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(46.0, 5, 46.0, 5),
                child: Text(
                  'Unlimited voters, all available features, Free for simple votes with less than 6',
                  style: TextStyle(fontSize: 16, color: theme.inverseSurface),
                ),
              ),
              //vote security
              const Padding(
                padding: EdgeInsets.fromLTRB(14.0, 5, 14.0, 5),
                child: Text('Vote Security ', style: TextStyle(
                    fontSize: 34
                ),),
              ),
              const SizedBox(height: 35),
              //checkbox high security
              Row(
                children: [
                  Checkbox(
                    value: _isHiSecurityCheck,
                    shape: const CircleBorder(),
                    onChanged: (value) {
                      setState(() {
                        if (!_isHiSecurityCheck) {
                          _isHiSecurityCheck = value!;
                          _isNmSecurityCheck = false;
                        }else{
                          _isNmSecurityCheck = false;
                          _isHiSecurityCheck = true;
                        }
                      });
                    },
                  ),
                  Flexible(
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          if (!_isHiSecurityCheck) {
                            _isHiSecurityCheck = true;
                            _isNmSecurityCheck = false;
                          }
                          else{
                            _isNmSecurityCheck = false;
                            _isHiSecurityCheck = true;
                          }
                        });
                      },
                      child: const Text(
                        'High Security',
                        maxLines: null, // enables text wrapping

                        style: TextStyle(fontSize: 19),
                      ),
                    ),
                  ),
                ],
              ),
              //hint text
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(46.0, 5, 46.0, 5),
                  child: RichText(
                    text: TextSpan(
                        style: TextStyle(
                            fontSize: 16, color: theme.inverseSurface),
                        children: [
                          TextSpan(
                              text: 'Election',
                              style: TextStyle(
                                  fontSize: 16, color: theme.secondary),
                              recognizer: TapGestureRecognizer()
                              ..onTap = () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                  );
                  },
                          ),
                          TextSpan(
                            text: 'Arena',
                            style: TextStyle(
                                fontSize: 16, color: theme.primary),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => MyHomePage()),
                                );
                              },),
                          const TextSpan(
                              text: ' helps user creates a unique link per voter, with a random and secret access key for each voter.',
                          ),
                        ]),
                  ),
                ),
              ),
              //checkbox normal security
              Row(
                children: [
                  Checkbox(
                    value: _isNmSecurityCheck,
                    shape: const CircleBorder(),
                    onChanged: (value) {
                      setState(() {
                        if (_isNmSecurityCheck == false) {
                          _isNmSecurityCheck = value!;
                          _isHiSecurityCheck = false;
                        }
                        else{
                          _isNmSecurityCheck = true;
                          _isHiSecurityCheck = false;
                        }
                      });
                    },
                  ),
                  Flexible(
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          if (_isNmSecurityCheck == false) {
                            _isNmSecurityCheck = true;
                            _isHiSecurityCheck = false;
                          }
                          else{
                            _isNmSecurityCheck = true;
                            _isHiSecurityCheck = false;
                          }
                        });
                      },
                      child: const Text(
                        'Normal Security',
                        maxLines: null, // enables text wrapping

                        style: TextStyle(fontSize: 19),
                      ),
                    ),
                  ),
                ],
              ),
              //hint text
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(46.0, 5, 46.0, 5),
                  child: RichText(
                    text: TextSpan(
                        style: TextStyle(
                            fontSize: 16, color: theme.inverseSurface),
                        children: const [
                          TextSpan(
                              text: 'The administrator creates a shared link for all voters, and creates a unique access key for each voter',
                              ),
                        ]),
                  ),
                ),
              ),
              //voter anonymity
              const Padding(
                padding: EdgeInsets.fromLTRB(14.0, 5, 14.0, 5),
                child: Text('Vote Anonymity ', style: TextStyle(
                    fontSize: 34
                ),),
              ),
              const SizedBox(height: 35),
              //checkbox secret ballot
              Row(
                children: [
                  Checkbox(
                    value: _isSecretBCheck,
                    shape: const CircleBorder(),
                    onChanged: (value) {
                      setState(() {
                        if (!_isSecretBCheck) {
                          _isSecretBCheck = value!;
                          _isPublicBCheck = false;
                        }else{
                          _isPublicBCheck = false;
                          _isSecretBCheck = true;
                        }
                      });
                    },
                  ),
                  Flexible(
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          if (!_isSecretBCheck) {
                            _isSecretBCheck = true;
                            _isPublicBCheck = false;
                          }
                          else{
                            _isPublicBCheck = false;
                            _isSecretBCheck = true;
                          }
                        });
                      },
                      child: const Text(
                        'Secret Ballot',
                        maxLines: null, // enables text wrapping

                        style: TextStyle(fontSize: 19),
                      ),
                    ),
                  ),
                ],
              ),
              //hint text
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(46.0, 5, 46.0, 5),
                  child: RichText(
                    text: TextSpan(
                        style: TextStyle(
                            fontSize: 16, color: theme.inverseSurface),
                        children: [
                          const TextSpan(
                            text: 'Voters\' choices cannot be viewed by voters',
                          ),
                        ]),
                  ),
                ),
              ),
              //checkbox public ballot
              Row(
                children: [
                  Checkbox(
                    value: _isPublicBCheck,
                    shape: const CircleBorder(),
                    onChanged: (value) {
                      setState(() {
                        if (_isPublicBCheck == false) {
                          _isPublicBCheck = value!;
                          _isSecretBCheck = false;
                        }
                        else{
                          _isPublicBCheck = true;
                          _isSecretBCheck = false;
                        }
                      });
                    },
                  ),
                  Flexible(
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          if (_isPublicBCheck == false) {
                            _isPublicBCheck = true;
                            _isSecretBCheck = false;
                          }
                          else{
                            _isPublicBCheck = true;
                            _isSecretBCheck = false;
                          }
                        });
                      },
                      child: const Text(
                        'Public Ballot',
                        maxLines: null, // enables text wrapping

                        style: TextStyle(fontSize: 19),
                      ),
                    ),
                  ),
                ],
              ),
              //hint text
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(46.0, 5, 46.0, 5),
                  child: RichText(
                    text: TextSpan(
                        style: TextStyle(
                            fontSize: 16, color: theme.inverseSurface),
                        children: const [
                          TextSpan(
                            text: 'Voters\' choices can be made available to administrators and voters.',
                          ),
                        ]),
                  ),
                ),
              ),
              //Admin access
              const Padding(
                padding: EdgeInsets.fromLTRB(14.0, 5, 14.0, 5),
                child: Text('Admin Access To Vote Results', style: TextStyle(
                    fontSize: 34
                ),),
              ),
              const SizedBox(height: 35),
              //checkbox always access
              Row(
                children: [
                  Checkbox(
                    value: _isAlwaysCheck,
                    shape: const CircleBorder(),
                    onChanged: (value) {
                      setState(() {
                        if (!_isAlwaysCheck) {
                          _isAlwaysCheck = value!;
                          _isOnlyCheck = false;
                        }else{
                          _isOnlyCheck = false;
                          _isAlwaysCheck = true;
                        }
                      });
                    },
                  ),
                  Flexible(
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          if (!_isAlwaysCheck) {
                            _isAlwaysCheck = true;
                            _isOnlyCheck = false;
                          }
                          else{
                            _isOnlyCheck = false;
                            _isAlwaysCheck = true;
                          }
                        });
                      },
                      child: const Text(
                        'Always have access',
                        maxLines: null, // enables text wrapping
                        style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              //checkbox only after
              Row(
                children: [
                  Checkbox(
                    value: _isOnlyCheck,
                    shape: const CircleBorder(),
                    onChanged: (value) {
                      setState(() {
                        if (_isOnlyCheck == false) {
                          _isOnlyCheck = value!;
                          _isAlwaysCheck = false;
                        }
                        else{
                          _isOnlyCheck = true;
                          _isAlwaysCheck = false;
                        }
                      });
                    },
                  ),
                  Flexible(
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          if (_isOnlyCheck == false) {
                            _isOnlyCheck = true;
                            _isAlwaysCheck = false;
                          }
                          else{
                            _isOnlyCheck = true;
                            _isAlwaysCheck = false;
                          }
                        });
                      },
                      child: const Text(
                        'Only after vote ends',
                        maxLines: null, // enables text wrapping

                        style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              //Voter access
              const Padding(
                padding: EdgeInsets.fromLTRB(14.0, 5, 14.0, 5),
                child: Text('Voter Access To Results', style: TextStyle(
                    fontSize: 34
                ),),
              ),
              const SizedBox(height: 35),
              //checkbox always access
              Row(
                children: [
                  Checkbox(
                    value: _isVoterDenyCheck,
                    shape: const CircleBorder(),
                    onChanged: (value) {
                      setState(() {
                        if (!_isVoterDenyCheck) {
                          _isVoterDenyCheck = value!;
                          _isVoterOnlyAfterCheck = false;
                        }else{
                          _isVoterOnlyAfterCheck = false;
                          _isVoterDenyCheck = true;
                        }
                      });
                    },
                  ),
                  Flexible(
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          if (!_isVoterDenyCheck) {
                            _isVoterDenyCheck = true;
                            _isVoterOnlyAfterCheck = false;
                          }
                          else{
                            _isVoterOnlyAfterCheck = false;
                            _isVoterDenyCheck = true;
                          }
                        });
                      },
                      child: const Text(
                        'Deny access',
                        maxLines: null, // enables text wrapping
                        style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              //checkbox only after
              Row(
                children: [
                  Checkbox(
                    value: _isVoterOnlyAfterCheck,
                    shape: const CircleBorder(),
                    onChanged: (value) {
                      setState(() {
                        if (_isVoterOnlyAfterCheck == false) {
                          _isVoterOnlyAfterCheck = value!;
                          _isVoterDenyCheck = false;
                        }
                        else{
                          _isVoterOnlyAfterCheck = true;
                          _isVoterDenyCheck = false;
                        }
                      });
                    },
                  ),
                  Flexible(
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          if (_isVoterOnlyAfterCheck == false) {
                            _isVoterOnlyAfterCheck = true;
                            _isVoterDenyCheck = false;
                          }
                          else{
                            _isVoterOnlyAfterCheck = true;
                            _isVoterDenyCheck = false;
                          }
                        });
                      },
                      child: const Text(
                        'Only after vote ends',
                        maxLines: null, // enables text wrapping

                        style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 34,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NeumorphicButton(
                    onPressed: () {
                    },
                    style: NeumorphicStyle(
                      depth: 2,
                      intensity: 2,
                      color: theme.secondary,
                      lightSource: LightSource(1.4, 1.4),
                      shadowLightColor: theme.primary,
                      shadowDarkColorEmboss: theme.primary,
                      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.all(Radius.elliptical(36, 36)))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(1, 13, 1, 13),
                      child: Text(
                        'Save and Proceed',
                        style: TextStyle(
                            color: theme.tertiary,
                            fontSize: 26,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 34,)
            ],
          ),
        ),
      ),
    );
  }
}

class _TimeFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final int newSeconds = int.tryParse(newValue.text) ?? 0;

    // Restrict input to 59 seconds
    if (newSeconds > 59) {
      return oldValue;
    }

    return newValue;
  }
}
