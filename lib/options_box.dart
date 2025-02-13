import 'package:flutter/material.dart';
import 'package:vision_gpt/pallete.dart';

class OptionsBox extends StatelessWidget {
  final Color color; 
  final String headertext;
  final String descriptiontext;
  const OptionsBox({super.key, required this.color, required this.headertext, required this.descriptiontext});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 35,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(15),),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0).copyWith(
          left: 15,
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                headertext,
                style: TextStyle(
                  fontFamily: 'Cera Pro',
                  color: Pallete.blackColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                  ),
              ),
            ),
            const SizedBox(height: 3),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(
                descriptiontext,
                style: TextStyle(
                  fontFamily: 'Cera Pro',
                  color: Pallete.blackColor,
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}