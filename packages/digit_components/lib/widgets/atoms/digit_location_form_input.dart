import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'digit_base_form_input.dart';

class DigitLocationFormInput extends BaseDigitFormInput {
  DigitLocationFormInput({
    Key? key,
    required TextEditingController controller,
    String? label,
    String? info,
    String? initialValue,
    bool charCount = false,
    String? innerLabel,
    String? helpText,
    TooltipTriggerMode triggerMode = TooltipTriggerMode.tap,
    bool preferToolTipBelow = false,
    IconData suffix = Icons.my_location,
    String? Function(String?)? validator,
    void Function(String?)? onError,
  }) : super(
    key: key,
    controller: controller,
    label: label,
    info: info,
    charCount: charCount,
    innerLabel: innerLabel,
    helpText: helpText,
    triggerMode: triggerMode,
    preferToolTipBelow: preferToolTipBelow,
    suffix: suffix,
    validator: validator,
    onError: onError,
    initialValue: initialValue,
  );

  @override
  _DigitLocationFormInputState createState() => _DigitLocationFormInputState();
}

class _DigitLocationFormInputState extends BaseDigitFormInputState {

  @override
  void onSuffixIconClick({void Function()? customFunction}) async{

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Request location permission
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      // Get the current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Update the text field with the current location's latitude and longitude
      String location = "${position.latitude}, ${position.longitude}";
      widget.controller.text = location;
    }
  }

  @override
  Widget build(BuildContext context) {
    // You can customize the appearance or behavior specific to the TextFormInput here
    return super.build(context);
  }
}
