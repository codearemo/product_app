import 'package:flutter/material.dart';

class CustomDropdownItem<T> {
  final T? value;
  final String? label;

  CustomDropdownItem({
    required this.value,
    required this.label,
  });
}

class CustomDropdown extends StatefulWidget {
  final List<CustomDropdownItem?> items;
  final CustomDropdownItem? selectedOption;
  final ValueChanged<CustomDropdownItem?> onChanged;
  final String? labelText;
  final Widget? prefixIcon;
  final String? hintText;

  final TextEditingController? controller;
  final String? Function(CustomDropdownItem?)? validator;
  final bool obscureText;
  final int? maxLines;
  final int? maxLength;
  final TextCapitalization textCapitalization;
  final TextInputType keyboardType;
  final Widget? label;
  final bool enabled;
  final bool readOnly;
  final Widget? suffixIcon;
  final Function()? onTap;
  final FocusNode? focusNode;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.onChanged,
    this.selectedOption,
    this.labelText,
    this.prefixIcon,
    this.hintText,
    this.controller,
    this.validator,
    this.obscureText = false,
    this.maxLines = 1,
    this.maxLength,
    this.textCapitalization = TextCapitalization.none,
    this.keyboardType = TextInputType.text,
    this.label,
    this.enabled = true,
    this.readOnly = false,
    this.suffixIcon,
    this.onTap,
    this.focusNode,
  });

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<CustomDropdownItem>(
      validator: widget.validator,
      onTap: widget.onTap,
      hint: Text(widget.hintText ?? ''),
      focusNode: widget.focusNode,
      onChanged: widget.onChanged,
      value: widget.selectedOption,
      items: List.generate(widget.items.length, (index) {
        final item = widget.items[index];
        
        return DropdownMenuItem<CustomDropdownItem>(
          value: item,
          child: Text(item?.label ?? ''),
        );
      }),
      // items: widget.items.map<DropdownMenuItem<CustomDropdownItem>>(
      //   (CustomDropdownItem value) {
      //     return DropdownMenuItem<CustomDropdownItem>(
      //       value: value,
      //       child: Text('${value.label}'),
      //     );
      //   },
      // ).toList(),
      decoration: InputDecoration(
        filled: true,
        hintStyle: const TextStyle(color: Color(0xFF757575)),
        fillColor: const Color(0xFF979797).withOpacity(0.1),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide.none,
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide.none,
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide.none,
        ),
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon,
      ),
      icon: const Icon(
        Icons.arrow_drop_down,
      ),
    );
  }
}

// class CustomItem {
//   final String id;
//   final String name;

//   CustomItem({required this.id, required this.name});

//   @override
//   String toString() {
//     return name;
//   }
// }




// class CustomDropdown extends StatefulWidget {
//   final List<CustomItem> items;
//   final CustomItem? initialValue;
//   final ValueChanged<CustomItem?> onChanged;
//   final String? labelText;

//   CustomDropdown({
//     required this.items,
//     required this.onChanged,
//     this.initialValue,
//     this.labelText,
//   });

//   @override
//   _CustomDropdownState createState() => _CustomDropdownState();
// }

// class _CustomDropdownState extends State<CustomDropdown> {
//   CustomItem? _selectedValue;

//   @override
//   void initState() {
//     super.initState();
//     _selectedValue = widget.initialValue ?? widget.items.first;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonFormField<CustomItem>(
//       value: _selectedValue,
//       onChanged: (CustomItem? newValue) {
//         setState(() {
//           _selectedValue = newValue;
//         });
//         widget.onChanged(newValue);
//       },
//       items: widget.items.map<DropdownMenuItem<CustomItem>>((CustomItem item) {
//         return DropdownMenuItem<CustomItem>(
//           value: item,
//           child: Text(item.name),
//         );
//       }).toList(),
//       decoration: InputDecoration(
//         labelText: widget.labelText ?? 'Select an option',
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(5),
//           borderSide: BorderSide(color: Colors.blue, width: 2),
//         ),
//         contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//         filled: true,
//         fillColor: Colors.grey[100],
//       ),
//       icon: Icon(Icons.arrow_drop_down, color: Colors.blue),
//       style: TextStyle(color: Colors.black, fontSize: 16),
//     );
//   }
// }

