// import 'package:fixit/constants.dart';
// import 'package:flutter/material.dart';

// class CustomDropdown<T> extends StatefulWidget {
//   final List<T> items;
//   final String hintText;
//   final String labelText;
//   final T? initialValue;
//   final void Function(T? value) onChanged;
//   final Color dropdownMenuBackgroundColor;

//   const CustomDropdown({
//     Key? key,
//     required this.items,
//     required this.hintText,
//     required this.labelText,
//     required this.initialValue,
//     required this.onChanged,
//     this.dropdownMenuBackgroundColor = Colors.white,
//   }) : super(key: key);

//   @override
//   _CustomDropdownState<T> createState() => _CustomDropdownState<T>();
// }

// class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
//   T? _selectedItem;
//   bool _isDropdownOpened = false;

//   @override
//   void initState() {
//     super.initState();
//     _selectedItem = widget.initialValue;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         InputDecorator(
//           decoration: InputDecoration(
//             labelText: _isDropdownOpened
//                 ? widget.labelText
//                 : _selectedItem == null
//                     ? null
//                     : widget.labelText,
//             hintText: widget.hintText,
//             labelStyle: TextStyle(
//               color: Colors.grey,
//             ),
//             hintStyle: TextStyle(color: Colors.grey),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(16),
//               borderSide: BorderSide(
//                 color: _isDropdownOpened
//                     ? KSecondary
//                     : KSf2, // Dynamic border color
//               ),
//             ),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(16),
//               borderSide: BorderSide(
//                 color: _isDropdownOpened
//                     ? KSecondary
//                     : KSf2, // Dynamic border color
//               ),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(16),
//               borderSide: BorderSide(
//                 color: KSecondary, // Border color when focused
//               ),
//             ),
//             suffixIcon: GestureDetector(
//               onTap: () {
//                 setState(() {
//                   _isDropdownOpened = !_isDropdownOpened;
//                 });
//               },
//               child: Icon(
//                 Icons.arrow_drop_down,
//                 color: Colors.grey,
//               ),
//             ),
//           ),
//           child: Text(
//             _selectedItem != null
//                 ? _selectedItem.toString()
//                 : _isDropdownOpened
//                     ? widget.hintText
//                     : widget.labelText,
//             style: TextStyle(
//               color: _selectedItem != null ? Colors.white : Colors.grey,
//             ),
//           ),
//         ),
//         if (_isDropdownOpened)
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(16),
//               color: widget.dropdownMenuBackgroundColor,
//               border: Border.all(
//                 color: KSecondary, // Separate border for the dropdown menu
//               ),
//             ),
//             child: Column(
//               children: widget.items
//                   .map(
//                     (value) => RadioListTile<T>(
//                       fillColor: MaterialStateColor.resolveWith(
//                           (states) => Colors.white),
//                       title: Text(
//                         value.toString(),
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       value: value,
//                       groupValue: _selectedItem,
//                       onChanged: (newValue) {
//                         setState(() {
//                           _selectedItem = newValue;
//                           _isDropdownOpened = false;
//                         });
//                         widget.onChanged(_selectedItem);
//                       },
//                       controlAffinity: ListTileControlAffinity.trailing,
//                       activeColor: Colors.white, // Move radio to the right
//                     ),
//                   )
//                   .toList(),
//             ),
//           ),
//       ],
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:fixit/constants.dart';

// class CustomDropdown<T> extends StatefulWidget {
//   final List<T> items;
//   final String hintText;
//   final String labelText;
//   final T? initialValue;
//   final void Function(T? value) onChanged;
//   final Color dropdownMenuBackgroundColor;
//   final double dropdownMenuHeight; // New property for dropdown menu height

//   const CustomDropdown({
//     Key? key,
//     required this.items,
//     required this.hintText,
//     required this.labelText,
//     required this.initialValue,
//     required this.onChanged,
//     this.dropdownMenuBackgroundColor = Colors.white,
//     this.dropdownMenuHeight = 200.0, // Default height for dropdown menu
//   }) : super(key: key);

//   @override
//   _CustomDropdownState<T> createState() => _CustomDropdownState<T>();
// }

// class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
//   T? _selectedItem;
//   bool _isDropdownOpened = false;
//   late OverlayEntry _overlayEntry;

//   @override
//   void initState() {
//     super.initState();
//     _selectedItem = widget.initialValue;
//   }

//   @override
//   void dispose() {
//     _overlayEntry.remove();
//     super.dispose();
//   }

//   void _toggleDropdown() {
//     if (_isDropdownOpened) {
//       _overlayEntry.remove();
//     } else {
//       _overlayEntry = _createOverlayEntry();
//       Overlay.of(context)!.insert(_overlayEntry);
//     }
//     setState(() {
//       _isDropdownOpened = !_isDropdownOpened;
//     });
//   }

//   OverlayEntry _createOverlayEntry() {
//     final RenderBox renderBox = context.findRenderObject() as RenderBox;
//     final Offset offset = renderBox.localToGlobal(Offset.zero);
//     final Size size = renderBox.size;

//     return OverlayEntry(
//       builder: (context) => Positioned(
//         left: offset.dx,
//         top: offset.dy + size.height,
//         width: size.width,
//         child: Material(
//           elevation: 4,
//           child: Container(
//             height: widget.dropdownMenuHeight,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(16),
//               color: widget.dropdownMenuBackgroundColor,
//               border: Border.all(color: KSecondary),
//             ),
//             child: SingleChildScrollView(
//               child: Column(
//                 children: widget.items
//                     .map(
//                       (value) => RadioListTile<T>(
//                         fillColor: MaterialStateColor.resolveWith(
//                             (states) => Colors.white),
//                         title: Text(
//                           value.toString(),
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         value: value,
//                         groupValue: _selectedItem,
//                         onChanged: (newValue) {
//                           setState(() {
//                             _selectedItem = newValue;
//                             _isDropdownOpened = false;
//                           });
//                           _overlayEntry.remove();
//                           widget.onChanged(_selectedItem);
//                         },
//                         controlAffinity: ListTileControlAffinity.trailing,
//                         activeColor: Colors.white,
//                       ),
//                     )
//                     .toList(),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         InputDecorator(
//           decoration: InputDecoration(
//             labelText: _isDropdownOpened
//                 ? widget.labelText
//                 : _selectedItem == null
//                     ? null
//                     : widget.labelText,
//             hintText: widget.hintText,
//             labelStyle: TextStyle(color: Colors.grey),
//             hintStyle: TextStyle(color: Colors.grey),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(16),
//               borderSide: BorderSide(
//                 color: _isDropdownOpened ? KSecondary : KSf2,
//               ),
//             ),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(16),
//               borderSide: BorderSide(
//                 color: _isDropdownOpened ? KSecondary : KSf2,
//               ),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(16),
//               borderSide: BorderSide(
//                 color: KSecondary,
//               ),
//             ),
//             suffixIcon: GestureDetector(
//               onTap: _toggleDropdown,
//               child: Icon(
//                 Icons.arrow_drop_down,
//                 color: Colors.grey,
//               ),
//             ),
//           ),
//           child: Text(
//             _selectedItem != null
//                 ? _selectedItem.toString()
//                 : _isDropdownOpened
//                     ? widget.hintText
//                     : widget.labelText,
//             style: TextStyle(
//               color: _selectedItem != null ? Colors.white : Colors.grey,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:fixit/constants.dart';

class CustomDropdown<T> extends StatefulWidget {
  final List<T> items;
  final String hintText;
  final String labelText;
  final T? initialValue;
  final void Function(T? value) onChanged;
  final Color dropdownMenuBackgroundColor;
  final double dropdownMenuHeight; // New property for dropdown menu height

  const CustomDropdown({
    Key? key,
    required this.items,
    required this.hintText,
    required this.labelText,
    required this.initialValue,
    required this.onChanged,
    this.dropdownMenuBackgroundColor = Colors.white,
    this.dropdownMenuHeight = 200.0, // Default height for dropdown menu
  }) : super(key: key);

  @override
  _CustomDropdownState<T> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  T? _selectedItem;
  bool _isDropdownOpened = false;
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.initialValue;
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  void _toggleDropdown() {
    if (_isDropdownOpened) {
      _removeOverlay();
    } else {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context)?.insert(_overlayEntry!);
    }
    setState(() {
      _isDropdownOpened = !_isDropdownOpened;
    });
  }

  void _removeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  OverlayEntry _createOverlayEntry() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + size.height,
        width: size.width,
        child: Material(
          elevation: 4,
          child: Container(
            height: widget.dropdownMenuHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: widget.dropdownMenuBackgroundColor,
              border: Border.all(color: KSecondary),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: widget.items
                    .map(
                      (value) => RadioListTile<T>(
                        fillColor: MaterialStateColor.resolveWith(
                            (states) => Colors.white),
                        title: Text(
                          value.toString(),
                          style:
                              TextStyle(color: Colors.white, fontFamily: Kword),
                        ),
                        value: value,
                        groupValue: _selectedItem,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedItem = newValue;
                            _isDropdownOpened = false;
                          });
                          _removeOverlay(); // Just remove the overlay here, no need to access _overlayEntry
                          widget.onChanged(_selectedItem);
                        },
                        controlAffinity: ListTileControlAffinity.trailing,
                        activeColor: Colors.white,
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InputDecorator(
          decoration: InputDecoration(
            labelText: _isDropdownOpened
                ? widget.labelText
                : _selectedItem == null
                    ? null
                    : widget.labelText,
            hintText: widget.hintText,
            labelStyle: TextStyle(color: Colors.grey, fontFamily: Kword),
            hintStyle: TextStyle(color: Colors.grey, fontFamily: Kword),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: _isDropdownOpened ? KSecondary : KSf2,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: _isDropdownOpened ? KSecondary : KSf2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: KSecondary,
              ),
            ),
            suffixIcon: GestureDetector(
              onTap: _toggleDropdown,
              child: Icon(
                Icons.arrow_drop_down,
                color: Colors.grey,
              ),
            ),
          ),
          child: Text(
            _selectedItem != null
                ? _selectedItem.toString()
                : _isDropdownOpened
                    ? widget.hintText
                    : widget.labelText,
            style: TextStyle(
                color: _selectedItem != null ? Colors.white : Colors.grey,
                fontFamily: Kword),
          ),
        ),
      ],
    );
  }
}
