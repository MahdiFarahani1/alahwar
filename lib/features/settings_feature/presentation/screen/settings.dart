import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/common/appbar.dart';
import 'package:flutter_application_1/core/common/gradient.dart';
import 'package:flutter_application_1/core/constans/const_colors.dart';
import 'package:flutter_application_1/core/utils/esay_size.dart';

class Setting extends StatelessWidget {
  static String rn = "/setting";
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCommon.appBar("Setting"),
      body: Container(
        width: EsaySize.width(context),
        height: EsaySize.height(context),
        decoration: BoxDecoration(gradient: CostumGradient.linear()),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              width: EsaySize.width(context),
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: ConstColor.objectColor, width: 4),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CircleAvatar(
                    child: Icon(Icons.color_lens),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        clickContainer(
                          color: Colors.brown,
                          onPress: () {},
                        ),
                        clickContainer(
                          color: Colors.purpleAccent,
                          onPress: () {},
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 35, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Title"),
                        Text("Description"),
                      ],
                    ),
                  ),
                  const SizedBox.shrink()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector clickContainer(
      {required Color color, required VoidCallback onPress}) {
    return GestureDetector(
        onTap: onPress,
        child: Container(
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(8)),
          width: 40,
          height: 40,
        ));
  }
}
