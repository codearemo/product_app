import 'package:assessment/core/ui/section_title.dart';
import 'package:flutter/material.dart';
import 'package:assessment/core/utils/constants.dart';
import 'package:assessment/core/utils/size.dart';
import 'package:assessment/home/ui/widgets/discount_banner.dart';
import 'package:assessment/home/ui/widgets/home_header.dart';
import 'package:assessment/modules/products/presentation/ui/widgets/popular_products.dart';

class AllProductsDetails extends StatefulWidget {
  const AllProductsDetails({super.key});

  @override
  State<AllProductsDetails> createState() => _AllProductsDetailsState();
}

class _AllProductsDetailsState extends State<AllProductsDetails> {
  final TextEditingController searchText = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    searchText.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            S.h(4),
            HomeHeader(
              searchText: searchText,
              onChanged: (value) {
                setState(() {
                  searchText.text = value ?? '';
                });
              },
            ),
            const DiscountBanner(),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: AppConstants.appPadding),
              child: SectionTitle(
                title: "All Products",
                press: () {},
                searchText: searchText,
              ),
            ),
            S.h(10),
            Expanded(
              child: PopularProducts(
                searchText: searchText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
