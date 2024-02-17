import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/about_us_feature/widgets/widget_us.dart';

import '../../../../core/common/appbar.dart';

class AboutUs extends StatelessWidget {
  static String rn = "/aboutus";
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCommon.appBar("AboutUs"),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "sajjhdsjkhjfksdhjdsjlf;lskghjhgjhgkhjkhjgkjukhgjhgghghkghghkgkjhga;ksakl;dasl;jkdakjdhjlasjldsasdadas",
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: BtnSocial.allbtn(),
            ),
          )
        ],
      ),
    );
  }
}
