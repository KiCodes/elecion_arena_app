import 'package:election_arena_app/main.dart';
import 'package:election_arena_app/pages/signup.dart';
import 'package:flutter/material.dart';
import 'package:election_arena_app/pages/login.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class AppBarPanel extends StatelessWidget {
  const AppBarPanel({
    super.key,
    required this.theme,
    required this.isLogin,
  });

  final ColorScheme theme;
  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage()),
            );
          },
          child: ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                colors: [theme.secondary, theme.primary],
                stops: [0.2, 1.0],
              ).createShader(bounds);
            },
            child: Text('ElectionArena', style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 23,
        ),
        !isLogin
            ? ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupPage()),
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: theme.secondary,
                    shadowColor: theme.secondary,
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                      color: theme.tertiary,
                      fontSize: 15,
                    ),
                  ),
                )
            : SizedBox(),
        SizedBox(
          width: 12,
        ),
        !isLogin
            ? ElevatedButton(
                style: TextButton.styleFrom(
                  backgroundColor: theme.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  shadowColor: theme.secondary,
                  elevation: 6,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text(
                  'login',
                  style: TextStyle(
                    color: theme.tertiary,
                    fontSize: 15,
                  ),
                ),
              )
            : SizedBox()
      ],
    );
  }


}

