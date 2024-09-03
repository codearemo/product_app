import 'package:assessment/core/ui/app_categories_selection.dart';
import 'package:assessment/core/ui/app_dropdown.dart';
import 'package:assessment/core/ui/text_input_field.dart';
import 'package:assessment/core/usecases/general_usecase.dart';
import 'package:assessment/core/utils/app_form_validators.dart';
import 'package:assessment/core/utils/constants.dart';
import 'package:assessment/core/utils/money_mask_controller.dart';
import 'package:assessment/core/utils/size.dart';
import 'package:assessment/modules/products/data/models/product_model.dart';
import 'package:assessment/modules/products/presentation/bloc/product_module_bloc.dart';
import 'package:assessment/modules/products/presentation/ui/widgets/products_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppImageData {
  final String imageUrl;

  AppImageData({
    required this.imageUrl,
  });
}

class AddEditProductScreen extends StatefulWidget {
  const AddEditProductScreen({
    super.key,
    this.product,
  });

  final ProductModel? product;

  @override
  State<AddEditProductScreen> createState() => _AddEditProductScreenState();
}

class _AddEditProductScreenState extends State<AddEditProductScreen> {
  CustomDropdownItem? selectedImage;
  bool? _attemptFormSubmit;
  List<String>? selectedCategory = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController productNameTextCtrl = TextEditingController();
  MoneyMaskedTextController productPriceCtrl = MoneyMaskedTextController();
  TextEditingController productDescriptionTextCtrl = TextEditingController();

  triggerCreateEditProduct() {
    setState(() {
      _attemptFormSubmit = true;
    });
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final productModuleBloc = context.read<ProductModuleBloc>();
      final products = productModuleBloc.productsData?.data ?? [];

      if (widget.product?.id != null) {
        int index =
            products.indexWhere((element) => element?.id == widget.product?.id);

        products[index] = ProductModel(
          id: widget.product?.id,
          title: productNameTextCtrl.text,
          price: productPriceCtrl.numberValue,
          description: productDescriptionTextCtrl.text,
          categories: selectedCategory?.toList(),
          images: [selectedImage?.value.imageUrl],
          colors: [
            "F6625E",
            "836DB8",
            "DECB9C",
            "FFFFFF",
          ],
          rating: 4.8,
          isFavourite: false,
          isPopular: false,
        );
      } else {
        products.add(
          ProductModel(
            id: products.length + 1,
            title: productNameTextCtrl.text,
            price: productPriceCtrl.numberValue,
            description: productDescriptionTextCtrl.text,
            categories: selectedCategory?.toList(),
            images: [selectedImage?.value.imageUrl],
            colors: [
              "F6625E",
              "836DB8",
              "DECB9C",
              "FFFFFF",
            ],
            rating: 4.8,
            isFavourite: false,
            isPopular: false,
          ),
        );
      }

      productModuleBloc.add(
        SaveProductsEvent(params: products),
      );
    }
  }

  onCategorySelection(List<String> categories) {
    selectedCategory?.clear();
    selectedCategory?.addAll(categories);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (widget.product != null) {      
      productNameTextCtrl.text = widget.product?.title ?? '';
      productPriceCtrl.text = '${widget.product?.price.toString()}0';
      productDescriptionTextCtrl.text = widget.product?.description ?? '';
      selectedCategory?.addAll(widget.product?.categories ?? []);

      selectedImage = productImages.firstWhere((element) {
        return element.value?.imageUrl == widget.product?.images![0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final productModuleBloc = context.watch<ProductModuleBloc>();

    final selectedImageData = selectedImage == null
        ? null
        : AppImageData(
            imageUrl: selectedImage?.value.imageUrl ?? '',
          );
    return BlocConsumer<ProductModuleBloc, ProductModuleState>(
      listener: (context, state) {
        if (state is SaveProductsSuccess) {
          productModuleBloc.add(
            FetchProductsEvent(
              params: NoParams(),
            ),
          );

          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
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
              onPressed: triggerCreateEditProduct,
              child: Text(widget.product == null ? "Add Product" : "Update Product"),
            ),
          ],
          body: SafeArea(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.all(AppConstants.appPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Product Details',
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Enter product details',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                    S.h(20),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CategorySelectionForm(
                              formSubmited: _attemptFormSubmit,
                              multiSelect: false,
                              allCategories: productModuleBloc.categories,
                              onSelectCategory: onCategorySelection,
                              selectedCategories: selectedCategory?.toList(),
                            ),
                            S.h(20),
                            AppInputField(
                              hintText: "Name",
                              controller: productNameTextCtrl,
                              validator: (value) {
                                return AppFormValidator.validateField(
                                    value, "Name");
                              },
                              textCapitalization: TextCapitalization.words,
                            ),
                            S.h(30),
                            AppInputField(
                              hintText: "Price",
                              controller: productPriceCtrl,
                              validator: (value) {
                                return AppFormValidator.validAmount(
                                    productPriceCtrl.numberValue, "Price");
                              },
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                            ),
                            S.h(30),
                            AppInputField(
                              hintText: "Description",
                              controller: productDescriptionTextCtrl,
                              validator: (value) {
                                return AppFormValidator.validateField(
                                    value, "Description");
                              },
                              maxLines: null,
                              textCapitalization: TextCapitalization.sentences,
                            ),
                            S.h(30),
                            CustomDropdown(
                              items: productImages,
                              selectedOption: selectedImage,
                              validator: (value) {
                                return AppFormValidator.validateField(
                                    value?.label, "Image");
                              },
                              hintText: 'Image',
                              onChanged: (newValue) {
                                setState(() {
                                  selectedImage = newValue;
                                });
                              },
                            ),
                            if (selectedImageData != null) ...[
                              S.h(20),
                              Image.network(
                                selectedImageData.imageUrl,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return const Center(
                                    child: Text("Error loading image"),
                                  );
                                },
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
