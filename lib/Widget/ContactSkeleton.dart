import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ContactSkeleton extends StatelessWidget {
  ContactSkeleton({Key? key, required this.isloaded}) : super(key: key);
  bool isloaded;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(

        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        direction: ShimmerDirection.ltr,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
            child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            height: 20.0,
          ),
    ),
        ),);
  }
}
