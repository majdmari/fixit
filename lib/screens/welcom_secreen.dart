import 'package:fixit/constants.dart';
import 'package:fixit/screens/login_screen.dart';
import 'package:flutter/material.dart';

class WelcomScreen extends StatelessWidget {
  const WelcomScreen({super.key});
  static String id = 'welcomScreen';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: KSurface,
        body: PageView(
          children: [
            Column(children: [
              SizedBox(
                height: 90,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, LoginScreen.id);
                        },
                        child: Text('skip',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.grey,
                            ))),
                  ),
                ],
              ),
              SizedBox(
                height: 70,
              ),
              CircleAvatar(
                  radius: 152,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 150,
                    backgroundImage: AssetImage('assets/images/welcome.png'),
                  )),
              SizedBox(
                height: 30,
              ),
              Text(
                'Welcom to FixIt',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white, fontSize: 32, fontFamily: 'Angkor'),
              ),
              const SizedBox(height: 16),
              const Text(
                'Your trusted solution for all mechanical needs',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontFamily: 'Truculenta'),
              ),
              SizedBox(
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      'assets/images/next.png',
                      width: 70,
                      height: 70,
                    ),
                  ),
                ),
              )
            ]),
            Column(
              children: [
                SizedBox(
                  height: 90,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, LoginScreen.id);
                          },
                          child: Text('skip',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.grey,
                              ))),
                    ),
                  ],
                ),
                SizedBox(
                  height: 70,
                ),
                CircleAvatar(
                    radius: 152,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 150,
                      backgroundImage: AssetImage('assets/images/purpose.png'),
                    )),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'What is FixIt ?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontSize: 32, fontFamily: 'Angkor'),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    'Fixit connects you with skilled professionals for all your mechanical needs. our platform makes it easy to find reliable services tailored to you.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontFamily: 'Truculenta'),
                  ),
                ),
                SizedBox(
                  height: 1,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () {},
                      child: Image.asset(
                        'assets/images/next.png',
                        width: 70,
                        height: 70,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: 90,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, LoginScreen.id);
                          },
                          child: Text('skip',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.grey,
                              ))),
                    ),
                  ],
                ),
                SizedBox(
                  height: 70,
                ),
                CircleAvatar(
                    radius: 152,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 150,
                      backgroundImage: AssetImage('assets/images/Discover.png'),
                    )),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Explore Our Services',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontSize: 32, fontFamily: 'Angkor'),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    'Discover various mechanical services tailored to your needs,Find the perfect solution for you.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontFamily: 'Truculenta'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () {},
                      child: Image.asset(
                        'assets/images/next.png',
                        width: 70,
                        height: 70,
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
}
