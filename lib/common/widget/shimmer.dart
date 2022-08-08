import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class shimmerLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: 20,
      itemBuilder: ((context, index) {
        return Container(
          margin: EdgeInsets.all(10),
          width: size.width,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomWidget.circular(height: 100, width: 64),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    CustomWidget.rectangular(
                      height: 20,
                      width: size.width * 0.35,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    CustomWidget.rectangular(
                      height: 70,
                      width: size.width * 0.68,
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class CustomWidget extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const CustomWidget.rectangular(
      {this.width = double.infinity, required this.height})
      : this.shapeBorder = const RoundedRectangleBorder();

  const CustomWidget.circular(
      {this.width = double.infinity,
      required this.height,
      this.shapeBorder = const CircleBorder()});

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: Colors.grey.shade400,
        highlightColor: Colors.grey[300]!,
        period: Duration(seconds: 2),
        child: Container(
          width: width,
          height: height,
          decoration: ShapeDecoration(
            color: Colors.grey[400]!,
            shape: shapeBorder,
          ),
        ),
      );
}
