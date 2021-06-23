import 'package:flutter/material.dart';
import 'package:inventory_v1/constants.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomPaint(
          painter: BottomCurvePainter(),
          child: CustomPaint(
            painter: CurvePainter(),
            child: Stack(
              children: [
                // Column(
                //   children: [
                //     Expanded(
                //       child: Container(
                //         color: kCardColor,
                //       ),
                //     ),
                //     Expanded(
                //       child: Container(
                //         color: Colors.white,
                //       ),
                //     ),
                //   ],
                // ),
                Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 110,
                  ),
                ),
                Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 104,
                  ),
                ),
                Center(
                  child: CircleAvatar(
                    child: Text(
                      'LMNS',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 55,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    backgroundColor: Colors.white,
                    radius: 100,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 50,
                    width: 150,
                    margin: EdgeInsets.only(bottom: 100),
                    child: MaterialButton(
                      elevation: 8,
                      child: Text(
                        'LOGIN',
                        style: TextStyle(fontSize: 25),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/landingScreen');
                      },
                      color: kCardColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10, right: 20),
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        'CONTACT US',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10, left: 20),
                    child: Row(
                      children: [
                        Icon(
                          Icons.copyright,
                          color: Colors.grey,
                          size: 13,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Anto App Solutions',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = kCardColor;
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * 0.4);
    path.quadraticBezierTo(
        size.width * 0.5, size.height * 0.5, size.width, size.height * 0.4);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class BottomCurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..shader = RadialGradient(
        colors: [
          Color(0000212338),
          Color(0xFF112338),
        ],
      ).createShader(Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: 500,
      ));
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * 0.2);
    path.quadraticBezierTo(
        size.width * 0.1, size.height * 0.6, size.width, size.height * 0.7);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
