import 'package:fixit/constants.dart';
import 'package:fixit/screens/login_screen.dart';
import 'package:flutter/material.dart';

class WelcomScreen extends StatefulWidget {
  static String id = 'welcomScreen';

  @override
  _WelcomScreenState createState() => _WelcomScreenState();
}

class _WelcomScreenState extends State<WelcomScreen> {
  PageController nextpage = PageController();
  int pagenumber = 0;

  @override
  void dispose() {
    nextpage.dispose();
    super.dispose();
  }

  void onPageChanged(int value) {
    setState(() {
      pagenumber = value;
    });
  }

  Widget dotpageview() {
    return Builder(
      builder: ((context) {
        return Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              for (int i = 0; i < 3; i++)
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  width: i == pagenumber ? 25 : 6,
                  height: 6,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: i == pagenumber
                          ? Color(0XffB73B67)
                          : Color.fromARGB(255, 107, 46, 67)),
                ),
            ],
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KSurface,
      body: PageView(
        onPageChanged: onPageChanged,
        controller: nextpage,
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
                              fontSize: 18,
                              fontFamily: Kword))),
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
              'Welcome to FixIt',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white, fontSize: 32, fontFamily: 'Angkor'),
            ),
            const SizedBox(height: 16),
            const Text(
              'Your trusted solution for all mechanical needs',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white, fontSize: 25, fontFamily: 'Kalam'),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () {
                    nextpage.animateToPage(1,
                        duration: Duration(milliseconds: 700),
                        curve: Curves.easeIn);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(20),
                  ),
                  child: Icon(
                    Icons.arrow_forward,
                    color: Color(0XffB73B67),
                    size: 30,
                  ),
                ),
              ),
            ),
            dotpageview()
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
                              fontSize: 18,
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
                'What is FixIt?',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white, fontSize: 32, fontFamily: 'Angkor'),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  'FixIt connects you with skilled professionals for all your mechanical needs',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontSize: 25, fontFamily: 'Kalam'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: () {
                      nextpage.animateToPage(2,
                          duration: Duration(milliseconds: 700),
                          curve: Curves.easeIn);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(20),
                    ),
                    child: Icon(
                      Icons.arrow_forward,
                      color: Color(0XffB73B67),
                      size: 30,
                    ),
                  ),
                ),
              ),
              dotpageview()
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
                              fontSize: 18,
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
                  'Discover various mechanical services tailored to your needs',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontSize: 25, fontFamily: 'Kalam'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, LoginScreen.id);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(20)),
                      child: Icon(Icons.arrow_forward,
                          color: Color(0XffB73B67), size: 30)),
                ),
              ),
              dotpageview(),
            ],
          )
        ],
      ),
    );
  }
}
