import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatefulWidget {
  final List<T> items;
  final String hintText;
  final String labelText;
  final T initialValue;
  final void Function(T? value) onChanged;
  final Color dropdownMenuBackgroundColor;

  const CustomDropdown({
    Key? key,
    required this.items,
    required this.hintText,
    required this.labelText,
    required this.initialValue,
    required this.onChanged,
    this.dropdownMenuBackgroundColor = Colors.red,
  }) : super(key: key);

  @override
  _CustomDropdownState<T> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  late T _selectedItem;
  bool _isDropdownOpened = false;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InputDecorator(
          decoration: InputDecoration(
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _isDropdownOpened = !_isDropdownOpened;
                });
              },
              child: Icon(Icons.arrow_drop_down),
            ),
            labelText: widget.labelText,
            hintText: widget.hintText,
            labelStyle: TextStyle(
              color: Colors.grey,
            ),
            hintStyle: TextStyle(color: Colors.grey),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: Colors.blue,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: Colors.blue,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: Colors.green,
              ),
            ),
          ),
          child: Text(
            _selectedItem.toString(),
            style: TextStyle(color: Colors.black),
          ),
        ),
        if (_isDropdownOpened)
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: widget.dropdownMenuBackgroundColor,
              border: Border.all(
                  color: Colors.blue), // Separate border for the dropdown menu
            ),
            child: Column(
              children: widget.items
                  .map((value) => ListTile(
                        title: Text(
                          value.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          setState(() {
                            _selectedItem = value;
                            _isDropdownOpened = false;
                          });
                          widget.onChanged(_selectedItem);
                        },
                      ))
                  .toList(),
            ),
          ),
      ],
    );
  }
}
