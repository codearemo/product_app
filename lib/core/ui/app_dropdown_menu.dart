// import 'package:flutter/material.dart';

// class CustomPopupMenuButton extends StatefulWidget {
//   final List<PopupMenuEntry> items;
//   final Widget child;

//   const CustomPopupMenuButton({required this.items, required this.child});

//   @override
//   _CustomPopupMenuButtonState createState() => _CustomPopupMenuButtonState();
// }

// class _CustomPopupMenuButtonState extends State<CustomPopupMenuButton> {
//   OverlayEntry? _overlayEntry;
//   final LayerLink _layerLink = LayerLink();

//   void _toggleMenu() {
//     if (_overlayEntry == null) {
//       _overlayEntry = _createOverlayEntry();
//       Overlay.of(context).insert(_overlayEntry!);
//     } else {
//       _overlayEntry?.remove();
//       _overlayEntry = null;
//     }
//   }

//   OverlayEntry _createOverlayEntry() {
//     RenderBox renderBox = context.findRenderObject() as RenderBox;
//     var size = renderBox.size;
//     var offset = renderBox.localToGlobal(Offset.zero);

//     return OverlayEntry(
//       builder: (context) => Positioned(
//         width: size.width,
//         child: CompositedTransformFollower(
//           link: _layerLink,
//           offset: Offset(0, size.height),
//           showWhenUnlinked: false,
//           child: Material(
//             elevation: 3.0,
//             child: ConstrainedBox(
//               constraints: BoxConstraints(
//                 maxHeight: MediaQuery.of(context).size.height - offset.dy - size.height - 8.0,
//               ),
//               child: ListView(
//                 shrinkWrap: true,
//                 padding: EdgeInsets.zero,
//                 children: widget.items,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CompositedTransformTarget(
//       link: _layerLink,
//       child: GestureDetector(
//         onTap: _toggleMenu,
//         child: widget.child,
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _overlayEntry?.remove();
//     super.dispose();
//   }
// }
