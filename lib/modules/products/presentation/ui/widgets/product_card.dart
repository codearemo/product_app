import 'package:assessment/core/utils/app_assets_urls.dart';
import 'package:assessment/core/utils/app_utils.dart';
import 'package:assessment/modules/products/data/models/product_model.dart';
import 'package:assessment/modules/products/presentation/ui/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.product,
    required this.onPress,
  }) : super(key: key);

  final double width, aspectRetio;
  final ProductModel? product;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: GestureDetector(
        onTap: () {
          if (product != null) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ProductDetailsScreen(
                selecteProduct: product!,
              );
            }));
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.02,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF979797).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Hero(
                  tag: '${product?.id}',
                  child: Image.network(
                    product!.images![0],
                    errorBuilder: (context, error, stackTrace) {
                      return SvgPicture.network(AppAssetsUrls.starIcon);
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${product?.title}',
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppUtils.generateAmountDigits(product?.price),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFFF7643),
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    height: 24,
                    width: 24,
                    decoration: BoxDecoration(
                      color: product?.isFavourite == true
                          ? const Color(0xFFFF7643).withOpacity(0.15)
                          : const Color(0xFF979797).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      AppAssetsUrls.heartIcon,
                      colorFilter: ColorFilter.mode(
                          product?.isFavourite == true
                              ? const Color(0xFFFF4848)
                              : const Color(0xFFDBDEE4),
                          BlendMode.srcIn),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
