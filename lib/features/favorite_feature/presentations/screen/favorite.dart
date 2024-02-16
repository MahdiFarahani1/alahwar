import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/widgets/appbar_common.dart';

class Favorite extends StatelessWidget {
  static String rn = "/Favorite";
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBarCommon.appBar("Favorite"),
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(10),
        width: double.infinity,
        height: 120,
        color: Colors.pink.shade100,
        child: const Text(
          "hjhgjhghgjghjhhg....",
          style: TextStyle(color: Colors.redAccent),
        ),
      ),
    );
  }
}
