import 'package:collection/collection.dart';
import 'package:digit_components/digit_components.dart';
import 'package:digit_components/widgets/atoms/digit_checkbox.dart';
import 'package:digit_components/widgets/digit_dob_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:intl/intl.dart';
import '../../blocs/app_initialization/app_initialization.dart';
import '../../blocs/beneficiary_registration/beneficiary_registration.dart';
import '../../data/local_store/no_sql/schema/app_configuration.dart';
import '../../models/data_model.dart';
import '../../router/app_router.dart';
import '../../utils/environment_config.dart';
import '../../utils/i18_key_constants.dart' as i18;
import '../../utils/utils.dart';
import '../../widgets/header/back_navigation_help_header.dart';
import '../../widgets/localized.dart';

class IndividualDetailsPage extends LocalizedStatefulWidget {
  const IndividualDetailsPage({
    super.key,
    super.appLocalizations,
  });

  @override
  State<IndividualDetailsPage> createState() => _IndividualDetailsPageState();
}

class _IndividualDetailsPageState
    extends LocalizedState<IndividualDetailsPage> {
  static const _individualNameKey = 'individualName';
  static const _idTypeKey = 'idType';
  static const _idNumberKey = 'idNumber';
  static const _dobKey = 'dob';
  static const _ageKey = 'age';
  static const _genderKey = 'gender';
  static const _mobileNumberKey = 'mobileNumber';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: ReactiveFormBuilder(
        form: buildForm,
        builder: (context, form, child) {
          return ScrollableContent(
            header: Column(children: const [
              BackNavigationHelpHeaderWidget(),
            ]),
            footer: Offstage(
              offstage: false,
              child: SizedBox(
                height: 90,
                child: DigitCard(
                  child: DigitElevatedButton(
                    onPressed: () async {
                      form.markAllAsTouched();
                      if (!form.valid) return;

                      final router = context.router;
                      final bloc = BlocProvider.of<BeneficiaryRegistrationBloc>(
                        context,
                      );

                      // final age = form.control(_ageKey).value as int?;
                      final dob = form.control(_dobKey).value as DateTime?;

                      bloc.add(
                        BeneficiaryRegistrationSaveIndividualDetailsEvent(
                          IndividualModel(
                            tenantId: envConfig.variables.tenantId,
                            rowVersion: 1,
                            clientReferenceId: IdGen.i.identifier,
                            dateOfBirth: DateFormat('dd/MM/yyyy')
                                .format(dob!)
                                .toString(),
                            mobileNumber: form.control(_mobileNumberKey).value,
                            name: NameModel(
                              rowVersion: 1,
                              tenantId: envConfig.variables.tenantId,
                              clientReferenceId: IdGen.i.identifier,
                              givenName: form.control(_individualNameKey).value,
                            ),
                            gender: form.control(_genderKey).value == null
                                ? null
                                : Gender.values.byName(form
                                    .control(_genderKey)
                                    .value
                                    .toString()
                                    .toLowerCase()),
                            identifiers: [
                              if (form.control(_idTypeKey).value != null)
                                IdentifierModel(
                                  tenantId: envConfig.variables.tenantId,
                                  identifierType:
                                      form.control(_idTypeKey).value,
                                  identifierId:
                                      form.control(_idTypeKey).value ==
                                              'DEFAULT'
                                          ? IdGen.i.identifier
                                          : form.control(_idNumberKey).value,
                                  clientReferenceId: IdGen.i.identifier,
                                  rowVersion: 1,
                                ),
                            ],
                          ),
                        ),
                      );

                      final isSuccess = await DigitDialog.show<bool>(
                        context,
                        options: DigitDialogOptions(
                          titleText: localizations
                              .translate(i18.deliverIntervention.dialogTitle),
                          contentText: localizations.translate(
                            i18.deliverIntervention.dialogContent,
                          ),
                          primaryAction: DigitDialogActions(
                            label: localizations
                                .translate(i18.common.coreCommonSubmit),
                            action: (context) {
                              Navigator.of(context, rootNavigator: true)
                                  .pop(true);
                            },
                          ),
                          secondaryAction: DigitDialogActions(
                            label: localizations
                                .translate(i18.common.coreCommonCancel),
                            action: (context) =>
                                Navigator.of(context, rootNavigator: true)
                                    .pop(false),
                          ),
                        ),
                      );

                      if (isSuccess ?? false) {
                        bloc.add(const BeneficiaryRegistrationSubmitEvent());
                        router.push(AcknowledgementRoute());
                      }
                    },
                    child: Center(
                      child: Text(
                        localizations.translate(i18.common.coreCommonSubmit),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            children: [
              DigitCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      localizations.translate(
                        i18.individualDetails.individualsDetailsLabelText,
                      ),
                      style: theme.textTheme.displayMedium,
                    ),
                    Column(
                      children: [
                        DigitTextFormField(
                          formControlName: 'individualName',
                          label: localizations.translate(
                            i18.individualDetails.nameLabelText,
                          ),
                          isRequired: true,
                          validationMessages: {
                            'required': (object) => 'Name is required',
                          },
                        ),
                        DigitCheckbox(
                          label: localizations.translate(
                            i18.individualDetails.checkboxLabelText,
                          ),
                          value: true,
                        ),
                        BlocBuilder<AppInitializationBloc,
                            AppInitializationState>(
                          builder: (context, state) => state.maybeWhen(
                            orElse: () => const Offstage(),
                            initialized: (appConfiguration, _) {
                              final idTypeOptions =
                                  appConfiguration.idTypeOptions ??
                                      <IdTypeOptions>[];

                              return DigitDropdown(
                                isRequired: true,
                                label: localizations.translate(
                                  i18.individualDetails.idTypeLabelText,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    form.control(_idNumberKey).setValidators(
                                      [
                                        if (value == 'DEFAULT')
                                          Validators.required,
                                      ],
                                    );
                                  });
                                },
                                initialValue: idTypeOptions.firstOrNull?.name,
                                menuItems: idTypeOptions
                                    .map((e) => MenuItemModel(
                                          e.code,
                                          localizations.translate(e.name),
                                        ))
                                    .toList(),
                                formControlName: _idTypeKey,
                                validationMessages: {
                                  'required': (object) => 'ID Type is required',
                                },
                              );
                            },
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReactiveFormConsumer(
                              builder: (context, formGroup, child) {
                                return DigitTextFormField(
                                  isRequired:
                                      formGroup.control(_idTypeKey).value !=
                                          'DEFAULT',
                                  formControlName: _idNumberKey,
                                  label: localizations.translate(
                                    i18.individualDetails.idNumberLabelText,
                                  ),
                                  validationMessages: {
                                    'required': (object) =>
                                        'ID Number is required',
                                  },
                                );
                              },
                            ),
                            const SizedBox(height: 4),
                            Text(
                              localizations.translate(
                                i18.individualDetails.idNumberSuggestionText,
                              ),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                        DigitDobPicker(
                          datePickerFormControl: _dobKey,
                          ageInputFormControl: _ageKey,
                          datePickerLabel: localizations
                              .translate(i18.individualDetails.dobLabelText),
                          ageFieldLabel: localizations
                              .translate(i18.individualDetails.ageLabelText),
                          separatorLabel: localizations.translate(
                            i18.individualDetails.separatorLabelText,
                          ),
                        ),
                        BlocBuilder<AppInitializationBloc,
                            AppInitializationState>(
                          builder: (context, state) {
                            if (state is! AppInitialized) {
                              return const Offstage();
                            }

                            return state.maybeWhen(
                              orElse: () => const Offstage(),
                              initialized: (appConfiguration, _) {
                                final genderOptions =
                                    state.appConfiguration.genderOptions ??
                                        <GenderOptions>[];

                                return DigitDropdown(
                                  label: localizations.translate(
                                    i18.individualDetails.genderLabelText,
                                  ),
                                  initialValue: genderOptions.firstOrNull?.name,
                                  menuItems: genderOptions
                                      .map((e) => MenuItemModel(
                                            e.code,
                                            localizations.translate(e.name),
                                          ))
                                      .toList(),
                                  formControlName: _genderKey,
                                );
                              },
                            );
                          },
                        ),
                        DigitTextFormField(
                          formControlName: _mobileNumberKey,
                          label: localizations.translate(
                            i18.individualDetails.mobileNumberLabelText,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  FormGroup buildForm() => fb.group(<String, Object>{
        _individualNameKey: FormControl<String>(
          validators: [Validators.required],
        ),
        _idTypeKey: FormControl<String>(
          validators: [Validators.required],
        ),
        _idNumberKey: FormControl<String>(),
        _dobKey: FormControl<DateTime>(),
        _genderKey: FormControl<String>(),
        _mobileNumberKey: FormControl<String>(),
      });
}
