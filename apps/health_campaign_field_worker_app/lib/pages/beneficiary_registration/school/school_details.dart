import 'package:digit_components/digit_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../blocs/beneficiary_registration/beneficiary_registration.dart';
import '../../../models/data_model.dart';
import '../../../router/app_router.dart';
import '../../../utils/environment_config.dart';
import '../../../utils/i18_key_constants.dart' as i18;
import '../../../utils/utils.dart';
import '../../../widgets/header/back_navigation_help_header.dart';
import '../../../widgets/localized.dart';
import '../../../widgets/showcase/config/showcase_constants.dart';
import '../../../widgets/showcase/showcase_button.dart';

class SchoolDetailsPage extends LocalizedStatefulWidget {
  const SchoolDetailsPage({
    super.key,
    super.appLocalizations,
  });

  @override
  State<SchoolDetailsPage> createState() => _HouseHoldDetailsPageState();
}

class _HouseHoldDetailsPageState extends LocalizedState<SchoolDetailsPage> {
  static const _dateOfRegistrationKey = 'dateOfRegistration';
  static const _studentCountKey = 'studentCount';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bloc = context.read<BeneficiaryRegistrationBloc>();
    final router = context.router;

    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, locationState) {
          return ReactiveFormBuilder(
            form: () => buildForm(bloc.state),
            builder: (context, form, child) => BlocBuilder<
                BeneficiaryRegistrationBloc, BeneficiaryRegistrationState>(
              builder: (context, registrationState) {
                return ScrollableContent(
                  header: const Column(children: [
                    BackNavigationHelpHeaderWidget(
                      showHelp: false,
                      showcaseButton: ShowcaseButton(),
                    ),
                  ]),
                  footer: DigitCard(
                    margin: const EdgeInsets.fromLTRB(0, kPadding, 0, 0),
                    padding:
                        const EdgeInsets.fromLTRB(kPadding, 0, kPadding, 0),
                    child: DigitElevatedButton(
                      onPressed: () {
                        form.markAllAsTouched();
                        if (!form.valid) return;

                        createAddress(
                          bloc: bloc,
                          locationState: locationState,
                        );

                        createHouseHold(
                          form,
                          bloc,
                          registrationState,
                          locationState,
                        );
                      },
                      child: Center(
                        child: Text(
                          registrationState.mapOrNull(
                                editHousehold: (value) => localizations
                                    .translate(i18.common.coreCommonSave),
                              ) ??
                              localizations
                                  .translate(i18.householdDetails.actionLabel),
                        ),
                      ),
                    ),
                  ),
                  slivers: [
                    SliverToBoxAdapter(
                      child: DigitCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: kPadding),
                              child: Text(
                                localizations.translate(
                                  i18.householdDetails.schoolDetailsLabel,
                                ),
                                style: theme.textTheme.displayMedium,
                              ),
                            ),
                            Column(children: [
                              householdDetailsShowcaseData.dateOfRegistration
                                  .buildWith(
                                child: DigitDateFormPicker(
                                  isEnabled: false,
                                  formControlName: _dateOfRegistrationKey,
                                  label: localizations.translate(
                                    i18.householdDetails
                                        .dateOfRegistrationLabel,
                                  ),
                                  isRequired: false,
                                  confirmText: localizations.translate(
                                    i18.common.coreCommonOk,
                                  ),
                                  cancelText: localizations.translate(
                                    i18.common.coreCommonCancel,
                                  ),
                                ),
                              ),
                              householdDetailsShowcaseData
                                  .numberOfStudentsLivingInHousehold
                                  .buildWith(
                                child: DigitTextFormField(
                                  keyboardType: TextInputType.number,
                                  minLength: 1,
                                  maxLength: 5,

                                  // form: form,
                                  formControlName: _studentCountKey,
                                  label: localizations.translate(
                                    i18.householdDetails.noOfStudentsCountLabel,
                                  ),
                                  isRequired: true,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp(
                                      "[0-9]",
                                    )),
                                  ],
                                  validationMessages: {
                                    'required': (object) =>
                                        localizations.translate(
                                          i18.schoolDetails
                                              .errorNoOfStudentsCountLabel,
                                        ),
                                    'min1': (object) => localizations.translate(
                                          i18.schoolDetails
                                              .errorNoOfStudentsCountZeroLabel,
                                        ),
                                    'max10000': (object) =>
                                        localizations.translate(
                                          i18.schoolDetails
                                              .errorNoOfStudentsCountMaximumLabel,
                                        ),
                                  },
                                ),
                              ),
                            ]),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }

  FormGroup buildForm(BeneficiaryRegistrationState state) {
    final household = state.mapOrNull(
      editHousehold: (value) {
        return value.householdModel;
      },
    );

    final registrationDate = state.mapOrNull(
      editHousehold: (value) {
        return value.registrationDate;
      },
      create: (value) => DateTime.now(),
    );

    return fb.group(<String, Object>{
      _dateOfRegistrationKey:
          FormControl<DateTime>(value: registrationDate, validators: []),
      _studentCountKey: FormControl<int>(
        value: household?.memberCount ?? 1,
        validators: [
          Validators.required,
          CustomValidator.requiredMinStudentCount,
          CustomValidator.requiredMaxStudentCount,
        ],
      ),
    });
  }

  void createAddress({
    required BeneficiaryRegistrationBloc bloc,
    required LocationState locationState,
  }) {
    var addressModel = AddressModel(
      addressLine1: context.boundary.name,
      type: AddressType.correspondence,
      latitude: locationState.latitude,
      longitude: locationState.longitude,
      locationAccuracy: locationState.accuracy,
      locality: LocalityModel(
        code: context.boundary.code!,
        name: context.boundary.name,
      ),
      tenantId: envConfig.variables.tenantId,
      rowVersion: 1,
      auditDetails: AuditDetails(
        createdBy: context.loggedInUserUuid,
        createdTime: context.millisecondsSinceEpoch(),
      ),
      clientAuditDetails: ClientAuditDetails(
        createdBy: context.loggedInUserUuid,
        createdTime: context.millisecondsSinceEpoch(),
        lastModifiedBy: context.loggedInUserUuid,
        lastModifiedTime: context.millisecondsSinceEpoch(),
      ),
    );

    bloc.add(
      BeneficiaryRegistrationSaveAddressEvent(
        addressModel,
      ),
    );
  }

  void createHouseHold(
    FormGroup form,
    BeneficiaryRegistrationBloc bloc,
    BeneficiaryRegistrationState registrationState,
    LocationState locationState,
  ) {
    form.markAllAsTouched();
    if (!form.valid) return;

    final studentCount = form.control(_studentCountKey).value as int;

    final dateOfRegistration =
        form.control(_dateOfRegistrationKey).value as DateTime;

    final projectTypeId = context.selectedProjectType == null
        ? ""
        : context.selectedProjectType!.id;
    final cycleIndex =
        context.selectedCycle.id == 0 ? "" : "0${context.selectedCycle.id}";

    registrationState.maybeWhen(
      orElse: () {
        return;
      },
      create: (
        addressModel,
        householdModel,
        individualModel,
        registrationDate,
        searchQuery,
        loading,
        isHeadOfHousehold,
      ) {
        var household = householdModel;
        household ??= HouseholdModel(
          tenantId: envConfig.variables.tenantId,
          clientReferenceId: IdGen.i.identifier,
          rowVersion: 1,
          clientAuditDetails: ClientAuditDetails(
            createdBy: context.loggedInUserUuid,
            createdTime: context.millisecondsSinceEpoch(),
            lastModifiedBy: context.loggedInUserUuid,
            lastModifiedTime: context.millisecondsSinceEpoch(),
          ),
          auditDetails: AuditDetails(
            createdBy: context.loggedInUserUuid,
            createdTime: context.millisecondsSinceEpoch(),
            lastModifiedBy: context.loggedInUserUuid,
            lastModifiedTime: context.millisecondsSinceEpoch(),
          ),
          additionalFields: HouseholdAdditionalFields(
            version: 1,
            fields: [
              if (cycleIndex.isNotEmpty)
                AdditionalField(
                  'cycleIndex',
                  cycleIndex,
                ),
              if (projectTypeId.isNotEmpty)
                AdditionalField(
                  'projectTypeId',
                  projectTypeId,
                ),
              AdditionalField(
                'projectId',
                context.projectId,
              ),
              AdditionalField(
                Constants.schoolNameKey,
                searchQuery,
              ),
              addSchoolAdditionalType(),
            ],
          ),
        );
        addressModel?.copyWith(
          latitude: locationState.latitude,
          longitude: locationState.longitude,
          locationAccuracy: locationState.accuracy,
        );
        household = household.copyWith(
          memberCount: studentCount,
          address: addressModel,
        );

        bloc.add(
          BeneficiaryRegistrationSaveHouseholdDetailsEvent(
            household: household,
            registrationDate: dateOfRegistration,
          ),
        );
        context.router.push(
          SchoolIndividualDetailsRoute(isHeadOfHousehold: true),
        );
      },
      editHousehold: (
        addressModel,
        householdModel,
        individuals,
        registrationDate,
        projectBeneficiaryModel,
        loading,
      ) async {
        var household = householdModel.copyWith(
          memberCount: studentCount,
          address: addressModel,
          clientAuditDetails: (householdModel.clientAuditDetails?.createdBy !=
                      null &&
                  householdModel.clientAuditDetails?.createdTime != null)
              ? ClientAuditDetails(
                  createdBy: householdModel.clientAuditDetails!.createdBy,
                  createdTime: householdModel.clientAuditDetails!.createdTime,
                  lastModifiedBy:
                      householdModel.clientAuditDetails!.lastModifiedBy,
                  lastModifiedTime: DateTime.now().millisecondsSinceEpoch,
                )
              : null,
          rowVersion: householdModel.rowVersion,
        );

        bloc.add(
          BeneficiaryRegistrationUpdateHouseholdDetailsEvent(
            household: household.copyWith(
              clientAuditDetails: (addressModel.clientAuditDetails?.createdBy !=
                          null &&
                      addressModel.clientAuditDetails?.createdTime != null)
                  ? ClientAuditDetails(
                      createdBy: addressModel.clientAuditDetails!.createdBy,
                      createdTime: addressModel.clientAuditDetails!.createdTime,
                      lastModifiedBy: context.loggedInUserUuid,
                      lastModifiedTime: context.millisecondsSinceEpoch(),
                    )
                  : null,
            ),
            addressModel: addressModel.copyWith(
              latitude: locationState.latitude,
              longitude: locationState.longitude,
              locationAccuracy: locationState.accuracy,
              clientAuditDetails: (addressModel.clientAuditDetails?.createdBy !=
                          null &&
                      addressModel.clientAuditDetails?.createdTime != null)
                  ? ClientAuditDetails(
                      createdBy: addressModel.clientAuditDetails!.createdBy,
                      createdTime: addressModel.clientAuditDetails!.createdTime,
                      lastModifiedBy: context.loggedInUserUuid,
                      lastModifiedTime: context.millisecondsSinceEpoch(),
                    )
                  : null,
            ),
          ),
        );

        await Future.delayed(const Duration(microseconds: 200), () async {
          (context.router.parent() as StackRouter).pop();
        });
      },
    );
  }
}
