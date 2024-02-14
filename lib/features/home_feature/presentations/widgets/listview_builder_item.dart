import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constans/const_colors.dart';
import 'package:flutter_application_1/core/utils/esay_size.dart';

class ItemHome extends StatelessWidget {
  final String title;
  final int time;
  const ItemHome({Key? key, required this.title, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        border: Border.all(color: ConstColor.appbarColor),
        color: Colors.white,
      ),
      margin: const EdgeInsets.all(10),
      width: EsaySize.width(context) - 50,
      height: EsaySize.height(context) / 8.2,
      child: Stack(
        children: [
          Positioned(bottom: 5, left: 5, child: Text(time.toString())),
          Positioned.fill(
            top: 5,
            right: 60,
            left: 5,
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(
                    right: EsaySize.width(context) / 11, top: 5),
                child: Text(
                  title,
                  textDirection: TextDirection.rtl,
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              width: (EsaySize.width(context) - 50) / 4.4,
              height: EsaySize.height(context) / 8.2,
            ),
          ),
        ],
      ),
    );
  }
}
