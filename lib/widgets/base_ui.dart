import 'package:event_planner_udaipur/constant.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BaseUI extends StatelessWidget {
  final EdgeInsets padding;
  final String text1, text2;
  final double height;
  final FontWeight fontWeight1, fontWeight2;
  final double fontsize1;
  final double fontsize2;
  final Widget child;
  final BorderRadius radius;

  BaseUI(
      {this.fontWeight1,
      this.padding,
      this.text2 = '',
      this.text1 = '',
      this.height,
      this.child,
      this.fontsize1,
      this.fontsize2,
      this.radius,
      this.fontWeight2});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                baseColor: Color(0xFFFF8038),
                highlightColor: Colors.amber.shade300,
                child: Text(
                  text1,
                  style: kloginText.copyWith(
                      fontSize: fontsize1, fontWeight: fontWeight2),
                ),
              ),
              Shimmer.fromColors(
                baseColor: Color(0xFFFF8038),
                highlightColor: Colors.amber.shade300,
                child: Text(
                  text2,
                  style: kloginText.copyWith(
                    fontSize: fontsize2,
                    fontWeight: fontWeight1,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: height),
        Expanded(
          child: Container(
            decoration: kloginContainerDecoration.copyWith(
              borderRadius: radius,
            ),
            child: child,
          ),
        ),
      ],
    );
  }
}
