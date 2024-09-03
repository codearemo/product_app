import 'package:assessment/core/ui/app_confirm_content.dart';
import 'package:assessment/core/usecases/general_usecase.dart';
import 'package:assessment/core/utils/app_assets_urls.dart';
import 'package:assessment/core/utils/size.dart';
import 'package:assessment/modules/products/data/models/product_model.dart';
import 'package:assessment/modules/products/presentation/bloc/product_module_bloc.dart';
import 'package:assessment/modules/products/presentation/ui/screens/add_edit_product_screen.dart';
import 'package:assessment/modules/products/presentation/ui/widgets/product_color.dart';
import 'package:assessment/modules/products/presentation/ui/widgets/product_description.dart';
import 'package:assessment/modules/products/presentation/ui/widgets/product_images.dart';
import 'package:assessment/modules/products/presentation/ui/widgets/top_rounded_corner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum DropdownOptionAction {
  delete,
}

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({
    super.key,
    required this.selecteProduct,
  });

  final ProductModel selecteProduct;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  triggerConfirmDeleteDialog() async {
    final confirmLogout = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return const ConfirmContentDialog();
      },
    );

    if (confirmLogout == true) {
      triggerDeleteProduct();
    }
  }

  triggerDeleteProduct() {
    try {
      final productModuleBloc = context.read<ProductModuleBloc>();

      final products = productModuleBloc.productsData?.data ?? [];

      int index = products
          .indexWhere((element) => element?.id == widget.selecteProduct.id);

      products.removeAt(index);

      productModuleBloc.add(SaveProductsEvent(
        params: products,
      ));

      Navigator.pop(context);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final productModuleBloc = context.watch<ProductModuleBloc>();
    final product = productModuleBloc.productsData?.data?.firstWhere(
      (element) => element?.id == widget.selecteProduct.id,
      orElse: () => null,
    );

    return BlocConsumer<ProductModuleBloc, ProductModuleState>(
      listener: (context, state) {
        if (state is SaveProductsSuccess) {
          productModuleBloc.add(
            FetchProductsEvent(
              params: NoParams(),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          backgroundColor: const Color(0xFFF5F6F9),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: EdgeInsets.zero,
                  elevation: 0,
                  backgroundColor: Colors.white,
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
            actions: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        const Text(
                          "4.7",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        SvgPicture.asset(AppAssetsUrls.starIcon),
                      ],
                    ),
                  ),
                ],
              ),
              PopupMenuButton<DropdownOptionAction>(
                color: Colors.white,
                surfaceTintColor: Colors.white,
                // padding: const EdgeInsets.all(0),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    padding: EdgeInsets.symmetric(
                      horizontal: 25.w,
                      vertical: 8.h,
                    ),
                    height: 20,
                    value: DropdownOptionAction.delete,
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 24.sp,
                        ),
                        S.w(10),
                        Text(
                          "Delete",
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                // initialValue: 0,
                onCanceled: () {},
                onSelected: (value) {
                  switch (value) {
                    case DropdownOptionAction.delete:
                      triggerConfirmDeleteDialog();
                      break;
                    default:
                      break;
                  }
                },
                offset: const Offset(-30, 40),
                child: Container(
                  margin: const EdgeInsets.only(right: 20),
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.more_vert),
                ),
              ),
            ],
          ),
          body: product == null
              ? const Center(child: Text("Product not found"))
              : ListView(
                  children: [
                    ProductImages(product: product),
                    TopRoundedContainer(
                      color: Colors.white,
                      child: Column(
                        children: [
                          ProductDescription(
                            product: product,
                            pressOnSeeMore: () {},
                          ),
                          TopRoundedContainer(
                            color: const Color(0xFFF6F7F9),
                            child: Column(
                              children: [
                                ColorDots(product: product),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
          bottomNavigationBar: TopRoundedContainer(
            color: Colors.white,
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: ElevatedButton(
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return AddEditProductScreen(
                        product: product,
                      );
                    }));
                  },
                  child: const Text("Edit Product"),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
