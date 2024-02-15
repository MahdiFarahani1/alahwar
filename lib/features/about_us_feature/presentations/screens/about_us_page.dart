import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constans/const_colors.dart';
import 'package:flutter_application_1/features/about_us_feature/widgets/widget_us.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ConstColor.appbarColor,
        title: const Text("AboutUs"),
      ),
      body: Column(
        children: [
          const Text(
            "sajjhdsjkhjfksdhjdsjlf;lska;ksakl;dasl;jkdakjdhjlasjldsasdadas",
          ),
          Wrap(
            children: BtnSocial.allbtn(),
          )
        ],
      ),
    );
  }
}
