import 'package:assessment/core/ui/icon_button_with_counter.dart';
import 'package:assessment/core/ui/text_input_field.dart';
import 'package:assessment/core/utils/app_assets_urls.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  final TextEditingController? searchText;
  final Function(String?)? onChanged;

  const HomeHeader({
    Key? key,
    required this.searchText,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: AppInputField(
            prefixIcon: const Icon(Icons.search),
            hintText: "Search product",
            controller: searchText,
            onChanged: (value) {
              if (onChanged != null) {
                onChanged!(value);
              }
              return null;
            },
          )),
          const SizedBox(width: 16),
          IconBtnWithCounter(
            // numOfitem: 3,
            svgSrc: AppAssetsUrls.cartIcon,
            press: () {},
          ),
          const SizedBox(width: 8),
          IconBtnWithCounter(
            svgSrc: AppAssetsUrls.bellIcon,
            numOfitem: 3,
            press: () {},
          ),
        ],
      ),
    );
  }
}
