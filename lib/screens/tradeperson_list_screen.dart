import 'package:flutter/material.dart';

class TradepersonListScreen extends StatelessWidget {
  const TradepersonListScreen({Key? key}) : super(key: key);
  static String id = 'TradepersonListScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0Xff000000),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0Xff2B2831),
                    ),
                    height: 100,
                    child: Row(
                      children: [
                        Container(
                          color: const Color(0Xff2B2831),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child:
                                  Image.asset('assets/images/tradeperson.jpg'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Jenny Wilson',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Color(0XffFFFFFF),
                                    size: 18,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    '4.7',
                                    style: TextStyle(color: Color(0XffFFFFFF)),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'irbid',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        RawMaterialButton(
                          onPressed: () {},
                          elevation: 2.0,
                          fillColor: Color(0Xff2B2831),
                          child: Icon(
                            Icons.phone,
                            color: Color(0XffB73B67),
                            size: 35.0,
                          ),
                          padding: EdgeInsets.all(15.0),
                          shape: CircleBorder(),
                        ),
                      ],
                    ),
                  ),
                ),
                if (index < 9)
                  Container(
                    height: 8,
                    color: Colors.black,
                  )
              ],
            );
          },
        ),
      ),
    );
  }
}
