import 'package:assessment/core/navigation/reveal_page.dart';
import 'package:assessment/core/ui/app_empty_list.dart';
import 'package:assessment/core/usecases/general_usecase.dart';
import 'package:assessment/core/utils/constants.dart';
import 'package:assessment/modules/products/data/models/product_model.dart';
import 'package:assessment/modules/products/presentation/bloc/product_module_bloc.dart';
import 'package:assessment/modules/products/presentation/ui/screens/add_edit_product_screen.dart';
import 'package:assessment/modules/products/presentation/ui/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularProducts extends StatefulWidget {
  final TextEditingController? searchText;

  const PopularProducts({
    super.key,
    required this.searchText,
  });

  @override
  State<PopularProducts> createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  fetchProducts() {
    final productModuleBloc = context.read<ProductModuleBloc>();

    productModuleBloc.add(
      FetchProductsEvent(
        params: NoParams(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final String searchText = widget.searchText?.text ?? '';

    final productModuleBloc = context.watch<ProductModuleBloc>();

    final productsData = productModuleBloc.productsData;
    final demoProducts = productsData?.data ?? [];

    final filters = productModuleBloc.filters;

    final filteredProducts = demoProducts.where((product) {
      ProductModel? prod;

      if ((filters.categories ?? []).contains(product?.categories?.first)) {
        prod = product;
      } else if (((filters.priceRange?.minValue ?? 0) <=
              (product?.price ?? 0)) &&
          ((filters.priceRange?.maxValue ?? 1000) >= (product?.price ?? 0))) {
        prod = product;
      } else if (searchText.isNotEmpty && ((product?.title ?? '').toLowerCase().contains(searchText.toLowerCase()))) {
        prod = product;
      }

      return prod != null;
    }).toList();

    return BlocConsumer<ProductModuleBloc, ProductModuleState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (demoProducts.isEmpty) {
          return AppEmptyList(
            message: "No Products Available",
            buttonText: "Add Product",
            onPressed: () {
              Navigator.of(context).push(
                RevealPageRoute(page: const AddEditProductScreen()),
              );
            },
          );
        } else if (filteredProducts.isEmpty) {
          return AppEmptyList(
            message: "Empty search results",
            buttonText: "Reset Filter",
            onPressed: () {
              productModuleBloc.setFilters(null);
              setState(() {
              widget.searchText?.clear();
              });
            },
          );
        } else {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: AppConstants.appPadding),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredProducts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 20,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                final product = filteredProducts[index];

                return ProductCard(
                  product: product,
                  onPress: () {},
                );
              },
            ),
          );
        }
      },
    );
  }
}
