import 'package:election_arena_app/pages/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:election_arena_app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:election_arena_app/constants/texts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isExpanded = false;
  bool _isLogin = true;

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
          body: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    _buildBottomHalf(theme),
                    Positioned(
                      top: 0,
                      right: 12,
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
            Text(Texts.login,
              style: TextStyle(
                fontSize: 60, color: theme.onBackground,),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Neumorphic(
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
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.mail, color: theme.secondary,),
                    fillColor: Colors.black,
                    hintText: Texts.email,
                  ),
                ),
              ),
            ),
            SizedBox(height: 23),
            Neumorphic(
              style: NeumorphicStyle(
                depth: 10,
                color: theme.background,
                shadowLightColor: Colors.white.withOpacity(0.3),
                shadowDarkColor:  Colors.white.withOpacity(0.3),
                intensity: 22,
                lightSource: LightSource.bottom,
                boxShape: NeumorphicBoxShape.roundRect(
                  BorderRadius.circular(12),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: Texts.password,
                    prefixIcon: Icon(Icons.key, color: theme.secondary,),
                    labelStyle: TextStyle(
                      color: Colors.black,)
                    ),
                ),
              ),
            ),
            SizedBox(height: 26),
            Align(
              alignment: Alignment.centerRight,
              child: Text(Texts.forgot),
            ),
            SizedBox(
              height: 23,
            ),
            SizedBox(
              width: 100,
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
                  Texts.login,
                  style: TextStyle(
                      color: theme.tertiary,
                      fontSize: 30,
                      fontWeight: FontWeight.bold
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
                        MaterialPageRoute(builder: (context) => SignupPage()),
                      );
                    },
                    child: Text('Sign Up', style: TextStyle(color: theme.onBackground, fontSize: 20), ))
              ],
            ),

          ],
        ),
      ),
    );
  }
}
