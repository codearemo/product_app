import 'package:assessment/core/ui/app_categories_selection.dart';
import 'package:assessment/core/utils/app_utils.dart';
import 'package:assessment/core/utils/size.dart';
import 'package:assessment/modules/products/presentation/bloc/product_module_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PriceFilterModal extends StatefulWidget {
  const PriceFilterModal({super.key});

  @override
  _PriceFilterModalState createState() => _PriceFilterModalState();
}

class _PriceFilterModalState extends State<PriceFilterModal> {
  late double _minPrice;
  late double _maxPrice;
  late RangeValues _currentRangeValues;
  final selectedCategories = <String>[];

  onCategorySelection(List<String> categories) {
    setState(() {
      selectedCategories.clear();
      selectedCategories.addAll(categories);
    });
  }

  void initializeFilters() {
    final productModuleBloc = context.read<ProductModuleBloc>();

    _minPrice = productModuleBloc.minValue ?? 0;
    _maxPrice = productModuleBloc.maxValue ?? 1000;

    final currentRangeMin = productModuleBloc.filters.priceRange?.minValue ?? 0;
    final currentRangeMax = productModuleBloc.filters.priceRange?.maxValue ?? 0;

    _currentRangeValues = RangeValues(currentRangeMin, currentRangeMax);

    onCategorySelection(productModuleBloc.filters.categories ?? []);
  }

  @override
  void initState() {
    super.initState();
    initializeFilters();
  }

  @override
  Widget build(BuildContext context) {
    final productModuleBloc = context.watch<ProductModuleBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Filter by Price Range',
        ),
        centerTitle: false,
      ),
      persistentFooterButtons: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: const Color(0xFFFF7643),
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 48),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
          ),
          onPressed: () {
            productModuleBloc.setFilters(
              ProductFilters(
                categories: selectedCategories,
                priceRange: AppRange(
                    minValue: _currentRangeValues.start,
                    maxValue: _currentRangeValues.end),
              ),
            );
            Navigator.pop(context);
          },
          child: const Text("Apply"),
        ),
      ],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Price Range',
                  style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              S.h(10),
              RangeSlider(
                values: _currentRangeValues,
                min: _minPrice,
                max: _maxPrice,
                divisions: 100,
                labels: RangeLabels(
                  AppUtils.generateAmountDigits(_currentRangeValues.start),
                  AppUtils.generateAmountDigits(_currentRangeValues.end),
                ),
                onChanged: (RangeValues values) {
                  setState(() {
                    _currentRangeValues = values;
                  });
                },
              ),
              S.h(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      'Min: ${AppUtils.generateAmountDigits(_currentRangeValues.start)}'),
                  Text(
                      'Max: ${AppUtils.generateAmountDigits(_currentRangeValues.end)}'),
                ],
              ),
              S.h(30),
              const Text('Categories',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )),
              S.h(10),
              CategorySelectionForm(
                allCategories: productModuleBloc.categories,
                onSelectCategory: onCategorySelection,
                selectedCategories: selectedCategories,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
