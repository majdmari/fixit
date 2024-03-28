import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  const Info({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          color: Color(0Xff2B2831),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/images/tradeperson.jpg'),
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
                style: TextStyle(
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
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Spacer(),
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
        )
      ],
    );
  }
}
