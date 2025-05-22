import 'package:flutter/material.dart';

class DropdownInput<T> extends StatefulWidget {
  final Color? backgroundColor;
  final String label;
  final IconData? icon;
  final EdgeInsetsGeometry? margin;
  final List<DropdownMenuItem<T>> items;
  final String? hint;
  final T? value;
  final ValueChanged<T?>? onChanged;

  const DropdownInput({
    super.key,
    this.margin,
    this.icon,
    this.hint,
    this.backgroundColor,
    required this.label,
    required this.items,
    required this.value,
    this.onChanged,
  });

  @override
  State<DropdownInput<T>> createState() => _DropdownInputState<T>();
}

class _DropdownInputState<T> extends State<DropdownInput<T>> {
  late TextEditingController _controller;
  late T? _selectedValue;
  final GlobalKey _fieldKey = GlobalKey();
  double _fieldWidth = 0;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.value;
    _controller = TextEditingController(
      text: _getItemLabel(_selectedValue),
    );
  }

  String? _getItemLabel(T? value) {
    final matchedItem = widget.items.firstWhere(
      (item) => item.value == value,
      orElse: () => DropdownMenuItem<T>(
        value: null,
        child: Text(widget.hint ?? ''),
      ),
    );
    return matchedItem.child is Text ? (matchedItem.child as Text).data : null;
  }

  void _selectItem(T? value) {
    setState(
      () {
        _selectedValue = value;
        _controller.text = _getItemLabel(value) ?? '';
      },
    );
    if (widget.onChanged != null) {
      widget.onChanged!(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin ??
          const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return MenuAnchor(
            style: MenuStyle(
              backgroundColor: WidgetStatePropertyAll(
                widget.backgroundColor,
              ),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                  side: BorderSide(),
                ),
              ),
            ),
            builder: (context, controller, _) {
              return SizedBox(
                key: _fieldKey,
                width: constraints.maxWidth,
                child: TextFormField(
                  readOnly: true,
                  controller: _controller,
                  onTap: () {
                    final renderBox = _fieldKey.currentContext
                        ?.findRenderObject() as RenderBox?;
                    if (renderBox != null) {
                      setState(() {
                        _fieldWidth = renderBox.size.width;
                      });
                    }
                    controller.isOpen ? controller.close() : controller.open();
                  },
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    fillColor: widget.backgroundColor,
                    filled: true,
                    hintText: widget.hint,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    label: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 8,
                      ),
                      decoration: BoxDecoration(
                        color: widget.backgroundColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      child: Text(
                        widget.label,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    suffix: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        ),
                        widget.icon == null
                            ? SizedBox()
                            : Icon(
                                widget.icon,
                                color: Colors.black,
                              )
                      ],
                    ),
                  ),
                ),
              );
            },
            menuChildren: [
              SizedBox(
                width: _fieldWidth,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: widget.items.map((item) {
                    return SizedBox(
                      width: double.infinity,
                      child: MenuItemButton(
                        onPressed: () => _selectItem(item.value),
                        child: item.child,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
