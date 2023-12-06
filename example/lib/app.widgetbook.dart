import 'package:digit_components/utils/validators/validator.dart';
import 'package:digit_components/widgets/atoms/digit_date_form_input.dart';
import 'package:digit_components/widgets/atoms/digit_dropdown_input.dart';
import 'package:digit_components/widgets/atoms/digit_location_form_input.dart';
import 'package:digit_components/widgets/atoms/digit_numeric_form_input.dart';
import 'package:digit_components/widgets/atoms/digit_password_form_input.dart';
import 'package:digit_components/widgets/atoms/digit_radio_list.dart';
import 'package:digit_components/widgets/atoms/digit_search_form_input.dart';
import 'package:digit_components/widgets/atoms/digit_text_area_form_input.dart';
import 'package:digit_components/widgets/atoms/digit_text_form_input.dart';
import 'package:digit_components/widgets/atoms/digit_time_form_input.dart';
import 'package:digit_components/widgets/atoms/digit_toggle.dart';
import 'package:digit_components/widgets/atoms/digit_toggle_list.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  runApp(const HotReload());
}

class HotReload extends StatelessWidget {
  const HotReload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      addons: [

        DeviceFrameAddon(
          devices: [
            Devices.ios.iPhoneSE,
            Devices.ios.iPhone13,
            DeviceInfo.genericPhone(
              id: 'android-device',
              name: 'Android Device',
              platform: TargetPlatform.android,
              screenSize: const Size(412, 732),
            )
          ],
          initialDevice: Devices.ios.iPhone13,
        ),

      ],
      directories: [
        WidgetbookFolder(
          name: 'input text component',
          children: [
            WidgetbookComponent(
              name: 'text',
              useCases: [
                WidgetbookUseCase(
                  name: 'default',
                  builder: (context) => DigitTextFormInput(
                    label: context.knobs.string(
                      label: 'Title',
                      initialValue: '',
                    ),
                    helpText: context.knobs.string(
                      label: 'help text',
                      initialValue: '',
                    ),
                    charCount: context.knobs.boolean(
                      label: 'char count',
                      initialValue: false,
                    ),
                    innerLabel: context.knobs.string(
                      label: 'inner label',
                      initialValue: '',
                    ),
                    info: context.knobs.boolean(
                      label: 'info',
                      initialValue: false,
                    ),
                    infoText: context.knobs.string(
                      label: 'infoText',
                      initialValue: 'this is info',
                    ),
                    controller: TextEditingController(),
                    validations: [
                      Validator(ValidatorType.maxLength, 10,
                          errorMessage: 'Maximum length is 10.'),
                      Validator(ValidatorType.pattern, r'^[a-zA-Z0-9]+$',
                          errorMessage: 'Invalid format.'),
                    ],
                  ),
                ),
                WidgetbookUseCase(
                  name: 'filled',
                  builder: (context) => DigitTextFormInput(
                    label: context.knobs.string(
                      label: 'Title',
                      initialValue: '',
                    ),
                    initialValue: 'sdfjsdjf',
                    helpText: context.knobs.string(
                      label: 'help text',
                      initialValue: '',
                    ),
                    charCount: context.knobs.boolean(
                      label: 'char count',
                      initialValue: false,
                    ),
                    innerLabel: context.knobs.string(
                      label: 'inner label',
                      initialValue: '',
                    ),
                    info: context.knobs.boolean(
                      label: 'info',
                      initialValue: false,
                    ),
                    infoText: context.knobs.string(
                      label: 'infoText',
                      initialValue: 'this is info',
                    ),
                    controller: TextEditingController(),
                    validations: [
                      Validator(ValidatorType.maxLength, 10,
                          errorMessage: 'Maximum length is 10.'),
                      Validator(ValidatorType.pattern, r'^[a-zA-Z0-9]+$',
                          errorMessage: 'Invalid format.'),
                    ],
                  ),
                ),
                WidgetbookUseCase(
                  name: 'disabled',
                  builder: (context) => DigitTextFormInput(
                    controller: TextEditingController(),
                    isDisabled: true,
                    label: context.knobs.string(
                      label: 'Title',
                      initialValue: '',
                    ),
                    helpText: context.knobs.string(
                      label: 'help text',
                      initialValue: '',
                    ),
                    charCount: context.knobs.boolean(
                      label: 'char count',
                      initialValue: false,
                    ),
                    innerLabel: context.knobs.string(
                      label: 'inner label',
                      initialValue: '',
                    ),
                    info: context.knobs.boolean(
                      label: 'info',
                      initialValue: false,
                    ),
                    infoText: context.knobs.string(
                      label: 'infoText',
                      initialValue: 'this is info',
                    ),
                    validations: [
                      Validator(ValidatorType.maxLength, 10,
                          errorMessage: 'Maximum length is 10.'),
                      Validator(ValidatorType.pattern, r'^[a-zA-Z0-9]+$',
                          errorMessage: 'Invalid format.'),
                    ],
                  ),
                ),
                WidgetbookUseCase(
                  name: 'non Editable',
                  builder: (context) => DigitTextFormInput(
                    controller: TextEditingController(),
                    readOnly: true,
                    label: context.knobs.string(
                      label: 'Title',
                      initialValue: '',
                    ),
                    helpText: context.knobs.string(
                      label: 'help text',
                      initialValue: '',
                    ),
                    charCount: context.knobs.boolean(
                      label: 'char count',
                      initialValue: false,
                    ),
                    innerLabel: context.knobs.string(
                      label: 'inner label',
                      initialValue: '',
                    ),
                    info: context.knobs.boolean(
                      label: 'info',
                      initialValue: false,
                    ),
                    infoText: context.knobs.string(
                      label: 'infoText',
                      initialValue: 'this is info',
                    ),
                    validations: [
                      Validator(ValidatorType.maxLength, 10,
                          errorMessage: 'Maximum length is 10.'),
                      Validator(ValidatorType.pattern, r'^[a-zA-Z0-9]+$',
                          errorMessage: 'Invalid format.'),
                    ],
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'date',
              useCases: [
                WidgetbookUseCase(
                  name: 'default',
                  builder: (context) => DigitDateFormInput(
                    controller: TextEditingController(),
                    label: context.knobs.string(
                      label: 'Title',
                      initialValue: '',
                    ),
                    helpText: context.knobs.string(
                      label: 'help text',
                      initialValue: '',
                    ),
                    charCount: context.knobs.boolean(
                      label: 'char count',
                      initialValue: false,
                    ),
                    innerLabel: context.knobs.string(
                      label: 'inner label',
                      initialValue: '',
                    ),
                    info: context.knobs.boolean(
                      label: 'info',
                      initialValue: false,
                    ),
                    infoText: context.knobs.string(
                      label: 'infoText',
                      initialValue: 'this is info',
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'filled',
                  builder: (context) => DigitDateFormInput(
                    controller: TextEditingController(),
                    label: context.knobs.string(
                      label: 'Title',
                      initialValue: '',
                    ),
                    helpText: context.knobs.string(
                      label: 'help text',
                      initialValue: '',
                    ),
                    charCount: context.knobs.boolean(
                      label: 'char count',
                      initialValue: false,
                    ),
                    innerLabel: context.knobs.string(
                      label: 'inner label',
                      initialValue: '',
                    ),
                    info: context.knobs.boolean(
                      label: 'info',
                      initialValue: false,
                    ),
                    infoText: context.knobs.string(
                      label: 'infoText',
                      initialValue: 'this is info',
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'disabled',
                  builder: (context) => DigitDateFormInput(
                    controller: TextEditingController(),
                    isDisabled: true,
                    label: context.knobs.string(
                      label: 'Title',
                      initialValue: '',
                    ),
                    helpText: context.knobs.string(
                      label: 'help text',
                      initialValue: '',
                    ),
                    charCount: context.knobs.boolean(
                      label: 'char count',
                      initialValue: false,
                    ),
                    innerLabel: context.knobs.string(
                      label: 'inner label',
                      initialValue: '',
                    ),
                    info: context.knobs.boolean(
                      label: 'info',
                      initialValue: false,
                    ),
                    infoText: context.knobs.string(
                      label: 'infoText',
                      initialValue: 'this is info',
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'non Editable',
                  builder: (context) => DigitDateFormInput(
                    controller: TextEditingController(),
                    readOnly: true,
                    label: context.knobs.string(
                      label: 'Title',
                      initialValue: '',
                    ),
                    helpText: context.knobs.string(
                      label: 'help text',
                      initialValue: '',
                    ),
                    charCount: context.knobs.boolean(
                      label: 'char count',
                      initialValue: false,
                    ),
                    innerLabel: context.knobs.string(
                      label: 'inner label',
                      initialValue: '',
                    ),
                    info: context.knobs.boolean(
                      label: 'info',
                      initialValue: false,
                    ),
                    infoText: context.knobs.string(
                      label: 'infoText',
                      initialValue: 'this is info',
                    ),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'time',
              useCases: [
                WidgetbookUseCase(
                  name: 'default',
                  builder: (context) => DigitTimeFormInput(
                    controller: TextEditingController(),
                    label: context.knobs.string(
                      label: 'Title',
                      initialValue: '',
                    ),
                    helpText: context.knobs.string(
                      label: 'help text',
                      initialValue: '',
                    ),
                    charCount: context.knobs.boolean(
                      label: 'char count',
                      initialValue: false,
                    ),
                    innerLabel: context.knobs.string(
                      label: 'inner label',
                      initialValue: '',
                    ),
                    info: context.knobs.boolean(
                      label: 'info',
                      initialValue: false,
                    ),
                    infoText: context.knobs.string(
                      label: 'infoText',
                      initialValue: 'this is info',
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'filled',
                  builder: (context) => DigitTimeFormInput(
                    controller: TextEditingController(),
                    label: context.knobs.string(
                      label: 'Title',
                      initialValue: '',
                    ),
                    helpText: context.knobs.string(
                      label: 'help text',
                      initialValue: '',
                    ),
                    charCount: context.knobs.boolean(
                      label: 'char count',
                      initialValue: false,
                    ),
                    innerLabel: context.knobs.string(
                      label: 'inner label',
                      initialValue: '',
                    ),
                    info: context.knobs.boolean(
                      label: 'info',
                      initialValue: false,
                    ),
                    infoText: context.knobs.string(
                      label: 'infoText',
                      initialValue: 'this is info',
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'disabled',
                  builder: (context) => DigitTimeFormInput(
                    isDisabled: true,
                    controller: TextEditingController(),
                    label: context.knobs.string(
                      label: 'Title',
                      initialValue: '',
                    ),
                    helpText: context.knobs.string(
                      label: 'help text',
                      initialValue: '',
                    ),
                    charCount: context.knobs.boolean(
                      label: 'char count',
                      initialValue: false,
                    ),
                    innerLabel: context.knobs.string(
                      label: 'inner label',
                      initialValue: '',
                    ),
                    info: context.knobs.boolean(
                      label: 'info',
                      initialValue: false,
                    ),
                    infoText: context.knobs.string(
                      label: 'infoText',
                      initialValue: 'this is info',
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'non Editable',
                  builder: (context) => DigitTimeFormInput(
                    controller: TextEditingController(),
                    readOnly: true,
                    label: context.knobs.string(
                      label: 'Title',
                      initialValue: '',
                    ),
                    helpText: context.knobs.string(
                      label: 'help text',
                      initialValue: '',
                    ),
                    charCount: context.knobs.boolean(
                      label: 'char count',
                      initialValue: false,
                    ),
                    innerLabel: context.knobs.string(
                      label: 'inner label',
                      initialValue: '',
                    ),
                    info: context.knobs.boolean(
                      label: 'info',
                      initialValue: false,
                    ),
                    infoText: context.knobs.string(
                      label: 'infoText',
                      initialValue: 'this is info',
                    ),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'Search',
              useCases: [
                WidgetbookUseCase(
                  name: 'default',
                  builder: (context) => DigitSearchFormInput(
                    controller: TextEditingController(),
                    label: context.knobs.string(
                      label: 'Title',
                      initialValue: '',
                    ),
                    helpText: context.knobs.string(
                      label: 'help text',
                      initialValue: '',
                    ),
                    charCount: context.knobs.boolean(
                      label: 'char count',
                      initialValue: false,
                    ),
                    innerLabel: context.knobs.string(
                      label: 'inner label',
                      initialValue: '',
                    ),
                    info: context.knobs.boolean(
                      label: 'info',
                      initialValue: false,
                    ),
                    infoText: context.knobs.string(
                      label: 'infoText',
                      initialValue: 'this is info',
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'filled',
                  builder: (context) => DigitSearchFormInput(
                    controller: TextEditingController(),
                    label: context.knobs.string(
                      label: 'Title',
                      initialValue: '',
                    ),
                    helpText: context.knobs.string(
                      label: 'help text',
                      initialValue: '',
                    ),
                    charCount: context.knobs.boolean(
                      label: 'char count',
                      initialValue: false,
                    ),
                    innerLabel: context.knobs.string(
                      label: 'inner label',
                      initialValue: '',
                    ),
                    info: context.knobs.boolean(
                      label: 'info',
                      initialValue: false,
                    ),
                    infoText: context.knobs.string(
                      label: 'infoText',
                      initialValue: 'this is info',
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'disabled',
                  builder: (context) => DigitSearchFormInput(
                    isDisabled: true,
                    controller: TextEditingController(),
                    label: context.knobs.string(
                      label: 'Title',
                      initialValue: '',
                    ),
                    helpText: context.knobs.string(
                      label: 'help text',
                      initialValue: '',
                    ),
                    charCount: context.knobs.boolean(
                      label: 'char count',
                      initialValue: false,
                    ),
                    innerLabel: context.knobs.string(
                      label: 'inner label',
                      initialValue: '',
                    ),
                    info: context.knobs.boolean(
                      label: 'info',
                      initialValue: false,
                    ),
                    infoText: context.knobs.string(
                      label: 'infoText',
                      initialValue: 'this is info',
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'non Editable',
                  builder: (context) => DigitSearchFormInput(
                    readOnly: true,
                    controller: TextEditingController(),
                    label: context.knobs.string(
                      label: 'Title',
                      initialValue: '',
                    ),
                    helpText: context.knobs.string(
                      label: 'help text',
                      initialValue: '',
                    ),
                    charCount: context.knobs.boolean(
                      label: 'char count',
                      initialValue: false,
                    ),
                    innerLabel: context.knobs.string(
                      label: 'inner label',
                      initialValue: '',
                    ),
                    info: context.knobs.boolean(
                      label: 'info',
                      initialValue: false,
                    ),
                    infoText: context.knobs.string(
                      label: 'infoText',
                      initialValue: 'this is info',
                    ),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'Password',
              useCases: [
                WidgetbookUseCase(
                  name: 'default',
                  builder: (context) => DigitPasswordFormInput(
                    controller: TextEditingController(),
                    label: context.knobs.string(
                      label: 'Title',
                      initialValue: '',
                    ),
                    helpText: context.knobs.string(
                      label: 'help text',
                      initialValue: '',
                    ),
                    charCount: context.knobs.boolean(
                      label: 'char count',
                      initialValue: false,
                    ),
                    innerLabel: context.knobs.string(
                      label: 'inner label',
                      initialValue: '',
                    ),
                    info: context.knobs.boolean(
                      label: 'info',
                      initialValue: false,
                    ),
                    infoText: context.knobs.string(
                      label: 'infoText',
                      initialValue: 'this is info',
                    ),
                    validations: [
                      Validator(ValidatorType.minLength, 6, errorMessage: 'Password must be at least 6 characters.'),
                    ],
                  ),
                ),
                WidgetbookUseCase(
                  name: 'filled',
                  builder: (context) => DigitPasswordFormInput(
                    controller: TextEditingController(),
                    label: context.knobs.string(
                      label: 'Title',
                      initialValue: '',
                    ),
                    helpText: context.knobs.string(
                      label: 'help text',
                      initialValue: '',
                    ),
                    charCount: context.knobs.boolean(
                      label: 'char count',
                      initialValue: false,
                    ),
                    innerLabel: context.knobs.string(
                      label: 'inner label',
                      initialValue: '',
                    ),
                    info: context.knobs.boolean(
                      label: 'info',
                      initialValue: false,
                    ),
                    infoText: context.knobs.string(
                      label: 'infoText',
                      initialValue: 'this is info',
                    ),
                    validations: [
                      Validator(ValidatorType.minLength, 6, errorMessage: 'Password must be at least 6 characters.'),
                    ],
                  ),
                ),
                WidgetbookUseCase(
                  name: 'disabled',
                  builder: (context) => DigitPasswordFormInput(
                    isDisabled: true,
                    controller: TextEditingController(),
                    label: context.knobs.string(
                      label: 'Title',
                      initialValue: '',
                    ),
                    helpText: context.knobs.string(
                      label: 'help text',
                      initialValue: '',
                    ),
                    charCount: context.knobs.boolean(
                      label: 'char count',
                      initialValue: false,
                    ),
                    innerLabel: context.knobs.string(
                      label: 'inner label',
                      initialValue: '',
                    ),
                    info: context.knobs.boolean(
                      label: 'info',
                      initialValue: false,
                    ),
                    infoText: context.knobs.string(
                      label: 'infoText',
                      initialValue: 'this is info',
                    ),
                    validations: [
                      Validator(ValidatorType.minLength, 6, errorMessage: 'Password must be at least 6 characters.'),
                    ],
                  ),
                ),
                WidgetbookUseCase(
                  name: 'non Editable',
                  builder: (context) => DigitPasswordFormInput(
                    readOnly: true,
                    controller: TextEditingController(),
                    label: context.knobs.string(
                      label: 'Title',
                      initialValue: '',
                    ),
                    helpText: context.knobs.string(
                      label: 'help text',
                      initialValue: '',
                    ),
                    charCount: context.knobs.boolean(
                      label: 'char count',
                      initialValue: false,
                    ),
                    innerLabel: context.knobs.string(
                      label: 'inner label',
                      initialValue: '',
                    ),
                    info: context.knobs.boolean(
                      label: 'info',
                      initialValue: false,
                    ),
                    infoText: context.knobs.string(
                      label: 'infoText',
                      initialValue: 'this is info',
                    ),
                    validations: [
                      Validator(ValidatorType.minLength, 6, errorMessage: 'Password must be at least 6 characters.'),
                    ],
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'Numeric',
              useCases: [
                WidgetbookUseCase(
                  name: 'default',
                  builder: (context) => DigitNumericFormInput(
                    controller: TextEditingController(),
                    label: context.knobs.string(
                      label: 'Title',
                      initialValue: '',
                    ),
                    helpText: context.knobs.string(
                      label: 'help text',
                      initialValue: '',
                    ),
                    charCount: context.knobs.boolean(
                      label: 'char count',
                      initialValue: false,
                    ),
                    innerLabel: context.knobs.string(
                      label: 'inner label',
                      initialValue: '',
                    ),
                    info: context.knobs.boolean(
                      label: 'info',
                      initialValue: false,
                    ),
                    infoText: context.knobs.string(
                      label: 'infoText',
                      initialValue: 'this is info',
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'filled',
                  builder: (context) => DigitNumericFormInput(
                    controller: TextEditingController(),
                    label: context.knobs.string(
                      label: 'Title',
                      initialValue: '',
                    ),
                    helpText: context.knobs.string(
                      label: 'help text',
                      initialValue: '',
                    ),
                    charCount: context.knobs.boolean(
                      label: 'char count',
                      initialValue: false,
                    ),
                    innerLabel: context.knobs.string(
                      label: 'inner label',
                      initialValue: '',
                    ),
                    info: context.knobs.boolean(
                      label: 'info',
                      initialValue: false,
                    ),
                    infoText: context.knobs.string(
                      label: 'infoText',
                      initialValue: 'this is info',
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'disabled',
                  builder: (context) => DigitNumericFormInput(
                    isDisabled: true,
                    controller: TextEditingController(),
                    label: context.knobs.string(
                      label: 'Title',
                      initialValue: '',
                    ),
                    helpText: context.knobs.string(
                      label: 'help text',
                      initialValue: '',
                    ),
                    charCount: context.knobs.boolean(
                      label: 'char count',
                      initialValue: false,
                    ),
                    innerLabel: context.knobs.string(
                      label: 'inner label',
                      initialValue: '',
                    ),
                    info: context.knobs.boolean(
                      label: 'info',
                      initialValue: false,
                    ),
                    infoText: context.knobs.string(
                      label: 'infoText',
                      initialValue: 'this is info',
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'non Editable',
                  builder: (context) => DigitNumericFormInput(
                    readOnly: true,
                    controller: TextEditingController(),
                    label: context.knobs.string(
                      label: 'Title',
                      initialValue: '',
                    ),
                    helpText: context.knobs.string(
                      label: 'help text',
                      initialValue: '',
                    ),
                    charCount: context.knobs.boolean(
                      label: 'char count',
                      initialValue: false,
                    ),
                    innerLabel: context.knobs.string(
                      label: 'inner label',
                      initialValue: '',
                    ),
                    info: context.knobs.boolean(
                      label: 'info',
                      initialValue: false,
                    ),
                    infoText: context.knobs.string(
                      label: 'infoText',
                      initialValue: 'this is info',
                    ),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'Location',
              useCases: [
                WidgetbookUseCase(
                  name: 'default',
                  builder: (context) => DigitLocationFormInput(
                    controller: TextEditingController(),
                    label: context.knobs.string(
                      label: 'Title',
                      initialValue: '',
                    ),
                    helpText: context.knobs.string(
                      label: 'help text',
                      initialValue: '',
                    ),
                    charCount: context.knobs.boolean(
                      label: 'char count',
                      initialValue: false,
                    ),
                    innerLabel: context.knobs.string(
                      label: 'inner label',
                      initialValue: '',
                    ),
                    info: context.knobs.boolean(
                      label: 'info',
                      initialValue: false,
                    ),
                    infoText: context.knobs.string(
                      label: 'infoText',
                      initialValue: 'this is info',
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'filled',
                  builder: (context) => DigitLocationFormInput(
                    controller: TextEditingController(),
                    label: context.knobs.string(
                      label: 'Title',
                      initialValue: '',
                    ),
                    helpText: context.knobs.string(
                      label: 'help text',
                      initialValue: '',
                    ),
                    charCount: context.knobs.boolean(
                      label: 'char count',
                      initialValue: false,
                    ),
                    innerLabel: context.knobs.string(
                      label: 'inner label',
                      initialValue: '',
                    ),
                    info: context.knobs.boolean(
                      label: 'info',
                      initialValue: false,
                    ),
                    infoText: context.knobs.string(
                      label: 'infoText',
                      initialValue: 'this is info',
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'disabled',
                  builder: (context) => DigitLocationFormInput(
                    controller: TextEditingController(),
                    isDisabled: true,
                    label: context.knobs.string(
                      label: 'Title',
                      initialValue: '',
                    ),
                    helpText: context.knobs.string(
                      label: 'help text',
                      initialValue: '',
                    ),
                    charCount: context.knobs.boolean(
                      label: 'char count',
                      initialValue: false,
                    ),
                    innerLabel: context.knobs.string(
                      label: 'inner label',
                      initialValue: '',
                    ),
                    info: context.knobs.boolean(
                      label: 'info',
                      initialValue: false,
                    ),
                    infoText: context.knobs.string(
                      label: 'infoText',
                      initialValue: 'this is info',
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'non Editable',
                  builder: (context) => DigitLocationFormInput(
                    controller: TextEditingController(),
                    readOnly: true,
                    label: context.knobs.string(
                      label: 'Title',
                      initialValue: '',
                    ),
                    helpText: context.knobs.string(
                      label: 'help text',
                      initialValue: '',
                    ),
                    charCount: context.knobs.boolean(
                      label: 'char count',
                      initialValue: false,
                    ),
                    innerLabel: context.knobs.string(
                      label: 'inner label',
                      initialValue: '',
                    ),
                    info: context.knobs.boolean(
                      label: 'info',
                      initialValue: false,
                    ),
                    infoText: context.knobs.string(
                      label: 'infoText',
                      initialValue: 'this is info',
                    ),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'Text Area',
              useCases: [
                WidgetbookUseCase(
                  name: 'default',
                  builder: (context) => DigitTextAreaFormInput(
                    controller: TextEditingController(),
                    label: context.knobs.string(
                      label: 'Title',
                      initialValue: '',
                    ),
                    helpText: context.knobs.string(
                      label: 'help text',
                      initialValue: '',
                    ),
                    charCount: context.knobs.boolean(
                      label: 'char count',
                      initialValue: false,
                    ),
                    innerLabel: context.knobs.string(
                      label: 'inner label',
                      initialValue: '',
                    ),
                    info: context.knobs.boolean(
                      label: 'info',
                      initialValue: false,
                    ),
                    infoText: context.knobs.string(
                      label: 'infoText',
                      initialValue: 'this is info',
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'filled',
                  builder: (context) => DigitTextAreaFormInput(
                    controller: TextEditingController(),
                    label: context.knobs.string(
                      label: 'Title',
                      initialValue: '',
                    ),
                    helpText: context.knobs.string(
                      label: 'help text',
                      initialValue: '',
                    ),
                    charCount: context.knobs.boolean(
                      label: 'char count',
                      initialValue: false,
                    ),
                    innerLabel: context.knobs.string(
                      label: 'inner label',
                      initialValue: '',
                    ),
                    info: context.knobs.boolean(
                      label: 'info',
                      initialValue: false,
                    ),
                    infoText: context.knobs.string(
                      label: 'infoText',
                      initialValue: 'this is info',
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'disabled',
                  builder: (context) => DigitTextAreaFormInput(
                    controller: TextEditingController(),
                    isDisabled: true,
                    label: context.knobs.string(
                      label: 'Title',
                      initialValue: '',
                    ),
                    helpText: context.knobs.string(
                      label: 'help text',
                      initialValue: '',
                    ),
                    charCount: context.knobs.boolean(
                      label: 'char count',
                      initialValue: false,
                    ),
                    innerLabel: context.knobs.string(
                      label: 'inner label',
                      initialValue: '',
                    ),
                    info: context.knobs.boolean(
                      label: 'info',
                      initialValue: false,
                    ),
                    infoText: context.knobs.string(
                      label: 'infoText',
                      initialValue: 'this is info',
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'non Editable',
                  builder: (context) => DigitTextAreaFormInput(
                    controller: TextEditingController(),
                    readOnly: true,
                    label: context.knobs.string(
                      label: 'Title',
                      initialValue: '',
                    ),
                    helpText: context.knobs.string(
                      label: 'help text',
                      initialValue: '',
                    ),
                    charCount: context.knobs.boolean(
                      label: 'char count',
                      initialValue: false,
                    ),
                    innerLabel: context.knobs.string(
                      label: 'inner label',
                      initialValue: '',
                    ),
                    info: context.knobs.boolean(
                      label: 'info',
                      initialValue: false,
                    ),
                    infoText: context.knobs.string(
                      label: 'infoText',
                      initialValue: 'this is info',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        WidgetbookFolder(
          name: 'Radio',
          children: [
            WidgetbookComponent(
              name: 'Radio Selection',
              useCases: [
                WidgetbookUseCase(
                  name: 'default',
                  builder: (context) => DigitRadioList(
                    onChanged: (value) {
                      // print(value);
                    },
                    isDisabled: context.knobs.boolean(
                      label: 'disabled',
                      initialValue: false,
                    ),
                    radioButtons: [
                      RadioButtonModel(
                        code: '1',
                        name: 'One',
                      ),
                      RadioButtonModel(code: '2', name: 'Two'),
                      RadioButtonModel(code: '3', name: 'Three'),
                      // Add more radio buttons as needed
                    ],
                  ),
                ),
                WidgetbookUseCase(
                  name: 'filled',
                  builder: (context) => DigitRadioList(
                    onChanged: (value) {
                      // print(value);
                    },

                    radioButtons: [
                      RadioButtonModel(
                        code: '',
                        name: 'One',
                      ),
                      RadioButtonModel(code: '2', name: 'Two'),
                      RadioButtonModel(code: '3', name: 'Three'),
                      // Add more radio buttons as needed
                    ],
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'Toggle',
              useCases: [
                WidgetbookUseCase(
                  name: 'default',
                  builder: (context) => DigitToggle(
                    onChanged: (value) {
                      // print(value);
                    },
                    label: 'Toggle',
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'Toggle Group',
              useCases: [
                WidgetbookUseCase(
                  name: 'default',
                  builder: (context) => DigitToggleList(
                    toggleButtons: [
                      ToggleButtonModel(name: 'Toggle 1', key: 'key1', onSelected: () {
                      }),
                      ToggleButtonModel(name: 'Toggle 2', key: 'key2', onSelected: () {
                      }),
                      ToggleButtonModel(name: 'Toggle 3', key: 'key3', onSelected: () {
                      }),
                    ],
                    onChanged: (selectedValues) {},
                  ),
                ),
              ],
            ),
          ],
        ),
        WidgetbookFolder(
          name: 'dropdown',
          children: [
            WidgetbookComponent(
              name: 'dropdown',
              useCases: [
                WidgetbookUseCase(
                  name: 'default',
                  builder: (context) => DigitDropdown<int>(
                    onChange: (String value, int index) => print(value),
                    dropdownStyle: const DropdownStyle(
                      elevation: 6,
                      padding: EdgeInsets.all(5),
                    ),
                    textEditingController: TextEditingController(),
                    items: [
                      'apple',
                      'banana',
                      'orange',
                      'grapes',
                    ]
                        .asMap()
                        .entries
                        .map(
                          (item) => DropdownItem<String>(
                        value: item.value,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(item.value),
                        ),
                      ),
                    )
                        .toList(),
                    child: const Text(
                      'dropdown',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}