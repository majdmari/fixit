  //  DropdownSearch<String>(
  //                 popupProps: PopupProps.menu(
  //                   showSelectedItems: true,
  //                   // disabledItemFn: (String s) => s.startsWith('I'),
  //                 ),
  //                 items: ["Male", 'Female'],
  //                 dropdownDecoratorProps: DropDownDecoratorProps(
  //                   baseStyle: TextStyle(
  //                     color: Colors.white,
  //                   ),
  //                   dropdownSearchDecoration: InputDecoration(
  //                     suffixIconColor: Colors.grey,
  //                     labelText: "Gender",
  //                     hintText: "Gender in menu mode",
  //                     labelStyle: TextStyle(
  //                       color: Colors.grey,
  //                     ),
  //                     hintStyle: TextStyle(color: Colors.grey),
  //                     enabledBorder: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(16),
  //                       borderSide: BorderSide(
  //                         color: KSf2,
  //                       ),
  //                     ),
  //                     border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(16),
  //                       borderSide: BorderSide(
  //                         color: KSf2,
  //                       ),
  //                     ),
  //                     focusedBorder: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(16),
  //                       borderSide: BorderSide(
  //                         color: KSecondary,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 onChanged: print,
  //                 // selectedItem: "",
  //               ),
 


 //__________________________________________
              // Container(
                //   width: double.infinity,
                //   height: 40,
                //   color: Colors.transparent,
                //   child: Row(
                //     children: [
                //       Text(
                //         'Selected Gender: ${_selectedValue ?? "Not Selected"}',
                //       ),
                //       SizedBox(
                //         width: 40,
                //       ),
                //       IconButton(
                //         onPressed: () {
                //           showDialog(
                //             context: context,
                //             builder: (BuildContext context) {
                //               return StatefulBuilder(
                //                 builder: (context, setState) {
                //                   return PopupWidget(
                //                     titleText:
                //                         'Selected Gender: ${_selectedValue ?? "Not Selected"}',
                //                     body: [
                //                       RadioListTile(
                //                         title: Text('Male'),
                //                         value: 'male',
                //                         groupValue: _selectedValue,
                //                         onChanged: (value) {
                //                           setState(() {
                //                             _selectedValue = value!;
                //                           });
                //                         },
                //                       ),
                //                       RadioListTile(
                //                         title: Text('Female'),
                //                         value: 'Female',
                //                         groupValue: _selectedValue,
                //                         onChanged: (value) {
                //                           setState(() {
                //                             _selectedValue = value!;
                //                           });
                //                         },
                //                       ),
                //                     ],
                //                   );
                //                 },
                //               );
                //             },
                //           );
                //         },
                //         icon: Icon(Icons.expand_more),
                //       ),
                //     ],
                //   ),
                // ),

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
//             // hintText: _isDropdownOpened ? null : widget.hintText,
//             // labelText: widget.labelText,
//             hintText: widget.hintText,
//             labelStyle: TextStyle(
//               color: Colors.grey,
//             ),
//             hintStyle: TextStyle(color: Colors.grey),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(16),
//               borderSide: BorderSide(
//                 color: KSf2,
//               ),
//             ),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(16),
//               borderSide: BorderSide(
//                 color: KSecondary,
//               ),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(16),
//               borderSide: BorderSide(
//                 color: KSecondary,
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
//             style: _selectedItem != null
//                 ? TextStyle(color: Colors.white)
//                 : TextStyle(color: Colors.grey),
//           ),
//         ),
//         if (_isDropdownOpened)
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(16),
//               color: widget.dropdownMenuBackgroundColor,
//               border: Border.all(
//                   color: KSecondary), // Separate border for the dropdown menu
//             ),
//             child: Column(
//               children: widget.items
//                   .map((value) => ListTile(
//                         title: Text(
//                           value.toString(),
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         onTap: () {
//                           setState(() {
//                             _selectedItem = value;
//                             _isDropdownOpened = false;
//                           });
//                           widget.onChanged(_selectedItem);
//                         },
//                       ))
//                   .toList(),
//             ),
//           ),
//       ],
//     );
//   }
// }
