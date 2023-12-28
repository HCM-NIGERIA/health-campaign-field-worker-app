import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../theme/colors.dart';


class DigitDropdown<T> extends StatefulWidget {
  /// the child widget for the button, this will be ignored if text is supplied
  final Widget child;
  final TextEditingController textEditingController;

  /// onChange is called when the selected option is changed.;
  /// It will pass back the value and the index of the option.
  final void Function(String, String) onChange;

  /// list of DropdownItems
  final List<DropdownItem<String>> items;
  final DropdownStyle dropdownStyle;

  /// dropdownButtonStyles passes styles to OutlineButton.styleFrom()
  final DropdownButtonStyle dropdownButtonStyle;

  /// dropdown button icon defaults to caret
  final Icon? icon;
  final bool hideIcon;
  final DropdownType dropdownType;

  /// if true the dropdown icon will as a leading icon, default to false
  final bool leadingIcon;
  const DigitDropdown({
    Key? key,
    this.hideIcon = false,
    required this.child,
    required this.items,
    this.dropdownStyle = const DropdownStyle(),
    this.dropdownButtonStyle = const DropdownButtonStyle(),
    this.icon,
    this.leadingIcon = false,
    required this.onChange,
    this.dropdownType = DropdownType.singleSelect,
    required this.textEditingController,
  }) : super(key: key);

  @override
  _DigitDropdownState<T> createState() => _DigitDropdownState<T>();
}

class _DigitDropdownState<T> extends State<DigitDropdown<T>>
    with TickerProviderStateMixin {
  final FocusNode _focusNode = FocusNode();
  final LayerLink _layerLink = LayerLink();
  late OverlayEntry _overlayEntry;
  bool _isOpen = false;
  int _currentIndex = -1;
  String _nestedSelected = '';
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;
  late Animation<double> _rotateAnimation;
  late List<DropdownItem<String>> filteredItems;
  late List<DropdownItem<String>> _lastFilteredItems;
  late List<bool> itemHoverStates;


  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
    filteredItems = List.from(widget.items);
    _lastFilteredItems = List.from(widget.items);
    itemHoverStates = List.generate(widget.items.length, (index) => false);
    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _rotateAnimation = Tween(begin: 0.0, end: 0.5).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    // ...
    super.dispose();
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
      _toggleDropdown(close: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    var style = widget.dropdownButtonStyle;

    // Responsive width based on screen size
    double dropdownWidth = MediaQuery.of(context).size.width < 600 ? 340 : 600;

    // link the overlay to the button
    return CompositedTransformTarget(
      link: this._layerLink,
      child: Container(
        width: style.width ?? dropdownWidth,
        height: style.height,
        child: TextField(
          onTap: () {
            _toggleDropdown();
            FocusScope.of(context).requestFocus(_focusNode);
          },
          onChanged: (input) {
            _filterItems(input);
            if (!listEquals(filteredItems, _lastFilteredItems)) {
              _updateOverlay();
              _lastFilteredItems = filteredItems;
            }
          },
          focusNode: _focusNode,
          controller: widget.textEditingController,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.zero,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: const DigitColors().woodsmokeBlack, width: 1.0),
              borderRadius: BorderRadius.zero,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: const DigitColors().burningOrange, width: 1.0),
              borderRadius: BorderRadius.zero,
            ),
            contentPadding: style.padding ?? const EdgeInsets.only(left: 8,),
            suffixIcon: RotationTransition(
              turns: _rotateAnimation,
              child: widget.icon ?? const Icon(Icons.arrow_drop_down),
            ),
            suffixIconColor: const DigitColors().davyGray,
          ),
        ),
      ),
    );
  }

  void _filterItems(String input) {
    List<DropdownItem<String>> newFilteredItems = widget.items
        .where((item) => item.value.toLowerCase().contains(input.toLowerCase()))
        .toList();

    if (!listEquals(newFilteredItems, _lastFilteredItems)) {
      setState(() {
        filteredItems = newFilteredItems;
      });
    }
  }

  void _updateOverlay() {
    if (_isOpen && _overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context)!.insert(_overlayEntry!);
    }
  }

  OverlayEntry _createOverlayEntry() {
    // find the size and position of the current widget
    RenderBox? renderBox = context?.findRenderObject() as RenderBox?;
    OverlayEntry? _overlayEntry;

    if (renderBox == null) {
      // Handle the case where renderBox is null (e.g., widget not yet laid out)
      return OverlayEntry(builder: (context) => const SizedBox.shrink());
    }
    var size = renderBox.size;

    var offset = renderBox.localToGlobal(Offset.zero);
    var topOffset = offset.dy + size.height ;
    OverlayEntry overlayEntry = OverlayEntry(
      // full screen GestureDetector to register when a
      // user has clicked away from the dropdown
      builder: (context) => GestureDetector(
        onTap: () => _toggleDropdown(close: true),
        behavior: HitTestBehavior.translucent,
        // full screen container to register taps anywhere and close drop down
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned(
                left: offset.dx,
                top: topOffset,
                width: widget.dropdownStyle.width ?? size.width,
                child: CompositedTransformFollower(
                  offset:
                  widget.dropdownStyle.offset ?? Offset(0, size.height),
                  link: this._layerLink,
                  showWhenUnlinked: false,
                  child: Material(
                    elevation: widget.dropdownStyle.elevation ?? 0,
                    borderRadius:
                    widget.dropdownStyle.borderRadius ?? BorderRadius.zero,
                    color: widget.dropdownStyle.color,
                    clipBehavior: Clip.none,
                    child: SizeTransition(
                      axisAlignment: 1,
                      sizeFactor: _expandAnimation,
                      child: ConstrainedBox(
                        constraints: widget.dropdownStyle.constraints ??
                            BoxConstraints(
                              maxHeight: MediaQuery.of(context).size.height -
                                  topOffset -
                                  15,
                            ),
                        child:_buildDropdownListView(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    return overlayEntry;
  }

  Widget _buildDropdownListView() {
    switch (widget.dropdownType) {
      case DropdownType.singleSelect:
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: _buildListView(),
        );
      case DropdownType.nestedSelect:
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: _buildNestedListView(),
        );
    }
  }

  Widget _buildListView() {
    return ListView(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      children: filteredItems.isNotEmpty
          ? filteredItems.asMap().entries.map((item) {
        Color backgroundColor =
        item.key % 2 == 0 ? const DigitColors().white : const DigitColors().alabasterWhite;

        return StatefulBuilder(
          builder: (context, setState) {
            return InkWell(
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              onHover: (hover) {
                setState(() {
                  itemHoverStates[item.key] = hover;
                });
              },
              onTap: () {
                setState(() => _currentIndex = item.key);
                widget.onChange(item.value.value, 'selected');
                _toggleDropdown();
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: itemHoverStates[item.key]
                        ? const DigitColors().burningOrange
                        : Colors.transparent,
                  ),
                  color: itemHoverStates[item.key]
                      ? const DigitColors().orangeBG
                      : backgroundColor,
                ),
                padding: EdgeInsets.zero,
                child: item.value,
              ),
            );
          },
        );
      }).toList()
          : [
        const Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("No Options available"),
          ),
        ),
      ],
    );
  }

  Widget _buildNestedListView() {
    return ListView(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      children: _buildGroupedItems(),
    );
  }

  List<Widget> _buildGroupedItems() {
    List<Widget> groupedItems = [];
    Set<String?> uniqueTypes = filteredItems.map((item) => item.type).toSet();

    for (String? type in uniqueTypes) {
      if (type != null) {
        // Add a header for the type
        groupedItems.add(
          Container(
            padding: const EdgeInsets.all(10),
            color: const DigitColors().alabasterWhite,
            child: Text(
              type,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                fontFamily: 'Roboto',
                color: const DigitColors().davyGray,
              ),
            ),
          ),
        );

        // Add items of the current type
        List<DropdownItem<String>> typeItems =
        widget.items.where((item) => item.type == type).toList();

        for (DropdownItem<String> item in typeItems) {
          groupedItems.add(
            StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      onHover: (hover) {
                        setState(() {
                          itemHoverStates[typeItems.indexOf(item)] = hover;
                        });
                      },
                      onTap: () {
                        _nestedSelected = '$type,${item.value}';
                        widget.onChange(item.value, type);
                        _toggleDropdown();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: itemHoverStates[typeItems.indexOf(item)]
                                ? const DigitColors().burningOrange
                                : Colors.transparent,
                          ),
                          color: itemHoverStates[typeItems.indexOf(item)]
                              ? const DigitColors().orangeBG
                              : const DigitColors().white,
                        ),
                        padding: EdgeInsets.zero,
                        child: item.child,
                      ),
                    ),
                    Container(height: 2,
                      color: const DigitColors().quillGray,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(left: 10, right: 10,),
                    ) // Divider after each option
                  ],
                );
              },
            ),
          );
        }
      }
    }

    // Add a message if no options are available
    if (groupedItems.isEmpty) {
      groupedItems.add(
        const Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("No Options available"),
          ),
        ),
      );
    }

    return groupedItems;
  }

  void _toggleDropdown({bool close = false}) async {
    if (_isOpen || close) {
      await _animationController.reverse();
      _overlayEntry?.remove();
      setState(() {
        _isOpen = false;
      });
    } else {
      setState(() {
        _currentIndex = -1; // Reset the index when opening the dropdown
        _overlayEntry = _createOverlayEntry();
      });
      Overlay.of(context).insert(_overlayEntry!);
      setState(() => _isOpen = true);
      _animationController.forward();
    }
    if (_currentIndex != -1) {
      setState(() {
        widget.textEditingController.text =
            filteredItems[_currentIndex].value;
      });
    }else if(widget.dropdownType == DropdownType.nestedSelect){
      setState(() {
        widget.textEditingController.text = _nestedSelected;
      });
    }
  }
}

/// DropdownItem is just a wrapper for each child in the dropdown list.\n
/// It holds the value of the item.
class DropdownItem<String> extends StatelessWidget {
  final String value;
  final String? type;
  final Widget child;

  const DropdownItem({Key? key, required this.value, this.type, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class DropdownButtonStyle {
  final MainAxisAlignment? mainAxisAlignment;
  final ShapeBorder? shape;
  final double elevation;
  final Color backgroundColor;
  final EdgeInsets? padding;
  final BoxConstraints? constraints;
  final double? width;
  final double? height;
  final Color primaryColor;
  const DropdownButtonStyle({
    this.mainAxisAlignment,
    this.backgroundColor=Colors.white,
    this.primaryColor = Colors.black87,
    this.constraints,
    this.height = 40,
    this.width,
    this.elevation = 1,
    this.padding,
    this.shape,
  });
}

class DropdownStyle {
  final BorderRadius borderRadius;
  final double? elevation;
  final Color? color;
  final EdgeInsets? padding;
  final BoxConstraints? constraints;

  /// position of the top left of the dropdown relative to the top left of the button
  final Offset? offset;

  ///button width must be set for this to take effect
  final double? width;

  const DropdownStyle({
    this.constraints,
    this.offset,
    this.width,
    this.elevation,
    this.color,
    this.padding,
    this.borderRadius = BorderRadius.zero,
  });
}

enum DropdownType{
  singleSelect,
  nestedSelect,
}

