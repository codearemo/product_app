import 'package:assessment/core/ui/icon_button_with_counter.dart';
import 'package:assessment/core/utils/app_assets_urls.dart';
import 'package:assessment/modules/products/presentation/bloc/product_module_bloc.dart';
import 'package:assessment/modules/products/presentation/ui/widgets/product_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.title,
    required this.press,
    required this.searchText,
  }) : super(key: key);

  final String title;
  final GestureTapCallback press;
  final TextEditingController? searchText;

  void showPriceFilterModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const PriceFilterModal();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final productModuleBloc = context.watch<ProductModuleBloc>();
    final bool isCategoriesFiltered = productModuleBloc.categories.length !=
        productModuleBloc.filters.categories?.length;

    final bool isMaxRangeFiltered =
        productModuleBloc.filters.priceRange?.maxValue !=
            productModuleBloc.maxValue;
    final bool isMinRangeFiltered =
        productModuleBloc.filters.priceRange?.minValue !=
            productModuleBloc.minValue;
    final bool isPriceRangeFiltered = isMaxRangeFiltered || isMinRangeFiltered;

    final canResetFilters = isPriceRangeFiltered || isCategoriesFiltered;

    final int filterCounts = [searchText?.text.isNotEmpty, isPriceRangeFiltered, isCategoriesFiltered].where((e) => e == true).length;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        Row(
          children: [
            if (canResetFilters || searchText?.text != '') ...[
              TextButton(
                onPressed: () {
                  productModuleBloc.setFilters(null);
                  searchText?.clear();
                },
                child: Text(
                  'Reset Filters',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ],
            IconBtnWithCounter(
              svgSrc: AppAssetsUrls.filterIcon,
              numOfitem: filterCounts,
              press: () {
                showPriceFilterModal(context);
              },
            ),
          ],
        ),
      ],
    );
  }
}
