import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  final String textButton;
  final TextStyle textStyle;
  final Color colorButton;
  final Function() onPressd;
  final double? heigth;
  final double? width;
  final double? radius;
  final Color? colorBorder;

  const CustomButtonWidget({
    super.key,
    required this.onPressd,
    required this.textStyle,
    required this.textButton,
    this.heigth,
    this.width,
     this.radius,
    required this.colorButton,
    this.colorBorder
  });

  @override
  Widget build(BuildContext context) {
      final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return ElevatedButton(
      
      style: ElevatedButton.styleFrom(

       
        fixedSize: Size(width  , heigth ?? height ),
        backgroundColor: colorButton,
        shadowColor: Colors.blueGrey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(radius ?? 180),
          side: BorderSide(color: colorBorder ?? Colors.transparent)
        ),
      ),
      onPressed: onPressd,
      child: Text(textButton, style: textStyle ,textAlign: TextAlign.center,),
    );
  }
}
