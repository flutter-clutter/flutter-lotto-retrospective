import 'package:flutter/material.dart';

class LottoBall extends StatelessWidget {
  LottoBall({
    @required this.number
  });

  final int number;

  @override
  Widget build(BuildContext context) {
   return Container(
     width: 64,
     height: 64,
     decoration: BoxDecoration(
       gradient: RadialGradient(
           colors: [Colors.white, Color(0xffe0e0e0)]
       ),
       //  color: Colors.white,
       shape: BoxShape.circle
     ),
     child: Center(
       child: Text(
         number.toString(),
         style: TextStyle(
           fontSize: 20,
           fontWeight: FontWeight.bold
         ),
       )
     ),
   );
  }


}