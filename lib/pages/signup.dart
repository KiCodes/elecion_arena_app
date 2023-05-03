import 'package:election_arena_app/pages/login.dart';
import 'package:election_arena_app/pages/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:election_arena_app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:election_arena_app/constants/texts.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {


  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _orgNameController = TextEditingController();
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _orgLocController = TextEditingController();
  final TextEditingController _memSizeController = TextEditingController();

  bool _isExpanded = false;
  bool _isSignup = true;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: AppBarPanel(theme: theme, isLogin: _isSignup),
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
        body: Column(
          children: [
            Expanded(
                child: Stack(
                  children: [
                    _buildBottomHalf(theme),
                    Positioned(
                      top: -20,
                      right: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: SizedBox(
                            width: 120,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: _isExpanded
                                          ? Container(
                                        decoration:
                                        BoxDecoration(color: theme.primary),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            TextButton(
                                              onPressed: () {},
                                              child: Text(
                                                'Home',
                                                style: TextStyle(
                                                  color: theme.onBackground,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {},
                                              child: Text(
                                                'Elections',
                                                style: TextStyle(
                                                  color: theme.onBackground,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {},
                                              child: Text(
                                                'Services',
                                                style: TextStyle(
                                                  color: theme.onBackground,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {},
                                              child: Text(
                                                'Pricing',
                                                style: TextStyle(
                                                  color: theme.onBackground,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                          : SizedBox.shrink(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ) )],
        ),
      ),);
  }
  Widget _buildBottomHalf(theme) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(21.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(Texts.signup,
              style: TextStyle(
                fontSize: 60, color: theme.onBackground,),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            textMethods(theme, Texts.first, Icons.perm_device_info),
            SizedBox(height: 16),
            textMethods(theme, Texts.last, Icons.perm_device_info),
            SizedBox(height: 16),
            textMethods(theme, Texts.email, Icons.email),
            SizedBox(height: 16),
            textMethods(theme, Texts.password, Icons.password),
            SizedBox(height: 16),
            textMethods(theme, Texts.orgName, Icons.maps_home_work_outlined),
            SizedBox(height: 16),
            textMethods(theme, Texts.jobTitle, Icons.account_circle_outlined),
            SizedBox(height: 16),
            textMethods(theme, Texts.orgLoc, Icons.map_outlined),
            SizedBox(height: 16),
            textMethods(theme, Texts.memSize, Icons.people_outline),
            SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                    value: isChecked,
                    activeColor: const Color(0xFF1aff06),
                    overlayColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState>states) {
                      return Colors.white;
                    } ),
                    onChanged: (newBool){
                      setState(() {
                        isChecked = newBool!;
                      });
                    }),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text:
                          'I agree to ',
                          style: TextStyle(color: theme.onBackground),
                        ),
                        TextSpan(
                          text: 'Election',
                          style: TextStyle(color: theme.secondary),
                        ),
                        TextSpan(
                          text: 'Arena\'s',
                          style: TextStyle(color: theme.primary),
                        ),
                        TextSpan(
                          text: 'Terms of service',
                          style: TextStyle(color: theme.onBackground),
                        ),
                      ]),
                ),
              ],
            ),
            SizedBox(
              width: 100,
              child: Neumorphic(
                style: NeumorphicStyle(
                    depth: 20,
                    color: theme.background,
                    shadowLightColor: Colors.white.withOpacity(0.3),
                    shadowDarkColor: Colors.white.withOpacity(0.3),
                    intensity: 22,
                    lightSource: LightSource.bottom,
                    boxShape: NeumorphicBoxShape.roundRect(
                      BorderRadius.circular(12),
                    ),),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(theme.secondary),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    minimumSize: MaterialStateProperty.all(Size(310, 55)),
                  ),
                  onPressed: () {},
                  child: Text(
                    Texts.signup,
                    style: TextStyle(
                        color: theme.tertiary,
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(Texts.login, style: TextStyle(color: theme.onBackground, fontSize: 20), ))
              ],
            ),

          ],
        ),
      ),
    );
  }

  Neumorphic textMethods(theme, text, icons) {
    return Neumorphic(
            style: NeumorphicStyle(
              depth: 10,
              color: theme.background,
              shadowLightColor: Colors.white.withOpacity(0.3),
              shadowDarkColor: Colors.white.withOpacity(0.3),
              intensity: 22,
              lightSource: LightSource.bottom,
              boxShape: NeumorphicBoxShape.roundRect(
                BorderRadius.circular(12),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15,1,15,1),
              child: TextField(
                controller: _firstnameController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(icons, color: theme.secondary,),
                  fillColor: Colors.black,
                  hintText: text,
                ),
              ),
            ),
          );
  }
}
