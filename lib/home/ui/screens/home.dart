import 'package:assessment/core/navigation/reveal_page.dart';
import 'package:assessment/modules/products/presentation/bloc/product_module_bloc.dart';
import 'package:assessment/modules/products/presentation/ui/screens/add_edit_product_screen.dart';
import 'package:assessment/modules/products/presentation/ui/screens/all_products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppHome extends StatelessWidget {
  const AppHome({super.key});

  @override
  Widget build(BuildContext context) {
    final productModuleBloc = context.watch<ProductModuleBloc>();

    return Scaffold(
      floatingActionButton: (productModuleBloc.productsData?.data ?? []).isEmpty ? null : FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            RevealPageRoute(page: const AddEditProductScreen()),
          );
        },
      ),
      body: const AllProductsDetails(),
    );
  }
}
