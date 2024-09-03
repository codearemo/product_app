
import 'package:assessment/modules/products/data/models/product_model.dart';
import 'package:assessment/modules/products/presentation/ui/widgets/small_product_image.dart';
import 'package:flutter/material.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    final productImages = widget.product.images ?? [];

    return Column(
      children: [
        Hero(
          tag: widget.product.id.toString(),
          child: SizedBox(
            width: 238,
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.network(productImages[selectedImage]),
            ),
          ),
        ),
        // SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(
              productImages.length,
              (index) => SmallProductImage(
                isSelected: index == selectedImage,
                press: () {
                  setState(() {
                    selectedImage = index;
                  });
                },
                image: productImages[index],
              ),
            ),
          ],
        )
      ],
    );
  }
}
