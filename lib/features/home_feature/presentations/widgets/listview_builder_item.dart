import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/common/loading.dart';
import 'package:flutter_application_1/core/constans/const_colors.dart';
import 'package:flutter_application_1/core/utils/esay_size.dart';
import 'package:highlight_text/highlight_text.dart';

class ItemHome extends StatelessWidget {
  final String title;
  final String time;
  final String pathImages;
  final bool isSearch;
  final VoidCallback? onTap;
  final String? searchWord;
  const ItemHome({
    super.key,
    required this.title,
    required this.time,
    required this.pathImages,
    this.onTap,
    this.isSearch = false,
    this.searchWord,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                  child: isSearch
                      ? TextHighlight(
                          textStyle: Theme.of(context).textTheme.titleMedium,
                          text: title,
                          textDirection: TextDirection.rtl,
                          words: {
                            searchWord!: HighlightedWord(
                                textStyle: TextStyle(
                                    color: ConstColor.objectColor,
                                    fontWeight: FontWeight.bold))
                          },
                        )
                      : Text(
                          style: Theme.of(context).textTheme.titleMedium,
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
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                width: (EsaySize.width(context) - 50) / 4.4,
                height: EsaySize.height(context) / 8.2,
                child: CachedNetworkImage(
                  imageUrl: pathImages,
                  placeholder: (context, url) {
                    return CostumLoading.loadCircle(context);
                  },
                  errorWidget: (context, url, error) {
                    return const Center(
                        child: Icon(
                      Icons.error,
                    ));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
