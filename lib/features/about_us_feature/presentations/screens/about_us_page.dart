import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/common/divider.dart';
import 'package:flutter_application_1/core/constans/const_colors.dart';
import 'package:flutter_application_1/core/utils/esay_size.dart';
import 'package:flutter_application_1/features/about_us_feature/widgets/widget_us.dart';

import '../../../../core/common/appbar.dart';

class AboutUs extends StatelessWidget {
  static String rn = "/aboutus";
  final String pageName = "حول التطبیق";
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBarCommon.appBar(pageName, context),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20),
              width: EsaySize.width(context) * 0.9,
              height: EsaySize.height(context) * 0.75,
              decoration: BoxDecoration(
                  color: ConstColor.greyWithShade,
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Column(
                children: [
                  EsaySize.gap(40),
                  Image.asset("assets/images/logo-big.png"),
                  EsaySize.gap(20),
                  CostumDivider.div(),
                  EsaySize.gap(20),
                  Text(
                    pageName,
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  EsaySize.gap(20),
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      textAlign: TextAlign.justify,
                      "اذاعة وتلفزيون الاهوار - مؤسسة اعلامية عراقية هادفة تبث برامجها من جنوب العراق - ذي قار , اذاعة وتلفزيون الاهوار - مؤسسة اعلامية عراقية هادفة تبث برامجها من جنوب العراق - ذي قاراذاعة وتلفزيون الاهوار - مؤسسة اعلامية عراقية هادفة تبث برامجها من جنوب العراق - ذي قاراذاعة وتلفزيون الاهوار - مؤسسة اعلامية عراقية هادفة تبث برامجها من جنوب العراق - ذي قاراذاعة وتلفزيون الاهوار - مؤسسة اعلامية عراقية هادفة تبث برامجها من جنوب العراق - ذي قار",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: Btn.allbtn(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
