import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/search_feature/presentations/screens/search.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchFeature {
  static Widget add(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            Search.rn,
          );
        },
        icon: const Icon(
          FontAwesomeIcons.magnifyingGlass,
          size: 18.5,
        ));
  }
}
