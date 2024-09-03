import 'package:assessment/core/utils/size.dart';
import 'package:flutter/material.dart';

class CategorySelectionForm extends StatefulWidget {
  const CategorySelectionForm({
    super.key,
    required this.allCategories,
    this.selectedCategories,
    this.onSelectCategory,
    this.formSubmited = false,
    this.multiSelect = true,
  });

  final List<String>? selectedCategories;
  final List<String> allCategories;
  final Function(List<String>)? onSelectCategory;
  final bool? formSubmited;
  final bool multiSelect;

  @override
  _CategorySelectionFormState createState() => _CategorySelectionFormState();
}

class _CategorySelectionFormState extends State<CategorySelectionForm> {
  // List of categories
  late List<String> _categories;

  // Track the selected categories
  final List<String> _selectedCategories = [];

  // Shuffle multi flag
  void _shuffleMulti(category) {
    if (!widget.multiSelect) {
      _selectedCategories.clear();
    }
  }

  // Handle chip selection
  void _onCategorySelected(bool selected, String category) {
    setState(() {
      if (selected) {
        _shuffleMulti(category);
        _selectedCategories.add(category);
      } else {
        _selectedCategories.remove(category);
      }
    });

    if (widget.onSelectCategory != null) {
      widget.onSelectCategory!(_selectedCategories);
    }
  }

  @override
  void initState() {
    super.initState();

    _categories = widget.allCategories;

    if (widget.selectedCategories != null) {
      _selectedCategories.addAll(widget.selectedCategories!);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
          spacing: 8.0,
          children: _categories.map((category) {
            return FilterChip(
              label: Text(category),
              selected: _selectedCategories.contains(category),
              onSelected: (selected) => _onCategorySelected(selected, category),
              selectedColor: const Color(0xFFFF7643),
              checkmarkColor: Colors.white,
              labelStyle: TextStyle(
                color: _selectedCategories.contains(category)
                    ? Colors.white
                    : Colors.black87,
              ),
            );
          }).toList(),
        ),
        S.h(2),
        if (widget.formSubmited == true && _selectedCategories.isEmpty) ...[
          Padding(
            padding: const EdgeInsets.only(left: 14.0),
            child: Text(
              'Select at least one category',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
            ),
          )
        ],
      ],
    );
  }
}
