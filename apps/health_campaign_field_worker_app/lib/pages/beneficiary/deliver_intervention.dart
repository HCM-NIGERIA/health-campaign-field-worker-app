import 'package:collection/collection.dart';
import 'package:digit_components/digit_components.dart';
import 'package:digit_components/utils/date_utils.dart';
import 'package:digit_components/widgets/atoms/digit_stepper.dart';
import 'package:digit_components/widgets/atoms/digit_toaster.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../blocs/delivery_intervention/deliver_intervention.dart';
import '../../blocs/household_overview/household_overview.dart';
import '../../blocs/product_variant/product_variant.dart';
import '../../blocs/project/project.dart';
import '../../blocs/search_households/search_households.dart';
import '../../models/data_model.dart';
import '../../models/project_type/project_type_model.dart';
import '../../router/app_router.dart';
import '../../utils/environment_config.dart';
import '../../utils/i18_key_constants.dart' as i18;
import '../../utils/utils.dart';
import '../../widgets/beneficiary/resource_beneficiary_card.dart';
import '../../widgets/component_wrapper/product_variant_bloc_wrapper.dart';
import '../../widgets/header/back_navigation_help_header.dart';
import '../../widgets/localized.dart';

class DeliverInterventionPage extends LocalizedStatefulWidget {
  final bool isEditing;

  const DeliverInterventionPage({
    super.key,
    super.appLocalizations,
    this.isEditing = false,
  });

  @override
  State<DeliverInterventionPage> createState() =>
      _DeliverInterventionPageState();
}

class _DeliverInterventionPageState
    extends LocalizedState<DeliverInterventionPage> {
  // Constants for form control keys
  static const _resourceDeliveredKey = 'resourceDelivered';
  static const _quantityDistributedKey = 'quantityDistributed';
  static const _quantityWastedKey = 'quantityWasted';
  static const _deliveryCommentKey = 'deliveryComment';
  static const _doseAdministrationKey = 'doseAdministered';
  static const _dateOfAdministrationKey = 'dateOfAdministration';
  static const _quantityWastedRadioKey = 'quantityWastedRadio';
  static const _bloodInUrineRadioKey = 'bloodInUrineRadio';

  final clickedStatus = ValueNotifier<bool>(false);
  // Variable to track dose administration status
  bool doseAdministered = false;

  bool isCommentRequired = false;

  // List of controllers for form elements
  final List _controllers = [];

  Map<String?, List<double?>> idVsSuggestedAndDistributedQuantity = {};

// Initialize the currentStep variable to keep track of the current step in a process.
  int currentStep = 0;

  bool interventionSubmitted = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final router = context.router;
    final reloadState = context.read<HouseholdOverviewBloc>();

    List<StepsModel> generateSteps(int numberOfDoses) {
      return List.generate(numberOfDoses, (index) {
        return StepsModel(
          title:
              '${localizations.translate(i18.deliverIntervention.dose)}${index + 1}',
          number: (index + 1).toString(),
        );
      });
    }

    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, locationState) {
        return ProductVariantBlocWrapper(
          child: BlocBuilder<HouseholdOverviewBloc, HouseholdOverviewState>(
            builder: (context, state) {
              final householdMemberWrapper = state.householdMemberWrapper;

              final projectBeneficiary =
                  context.beneficiaryType != BeneficiaryType.individual
                      ? [householdMemberWrapper.projectBeneficiaries.first]
                      : householdMemberWrapper.projectBeneficiaries
                          .where(
                            (element) =>
                                element.beneficiaryClientReferenceId ==
                                state.selectedIndividual?.clientReferenceId,
                          )
                          .toList();

              final projectState = context.read<ProjectBloc>().state;

              return Scaffold(
                body: state.loading
                    ? const Center(child: CircularProgressIndicator())
                    : BlocBuilder<DeliverInterventionBloc,
                        DeliverInterventionState>(
                        builder: (context, deliveryInterventionstate) {
                          List<ProductVariantsModel>? productVariants =
                              projectState.projectType?.cycles?.isNotEmpty ==
                                      true
                                  ? (fetchProductVariant(
                                      projectState
                                              .projectType!
                                              .cycles![deliveryInterventionstate
                                                      .cycle -
                                                  1]
                                              .deliveries?[
                                          deliveryInterventionstate.dose - 1],
                                      state.selectedIndividual,
                                    )?.productVariants)
                                  : projectState.projectType?.resources;
                          final int numberOfDoses = (projectState
                                      .projectType?.cycles?.isNotEmpty ==
                                  true)
                              ? (projectState
                                      .projectType
                                      ?.cycles?[
                                          deliveryInterventionstate.cycle - 1]
                                      .deliveries
                                      ?.length) ??
                                  0
                              : 0;

                          final steps = generateSteps(numberOfDoses);
                          if ((productVariants ?? []).isEmpty) {
                            DigitToast.show(
                              context,
                              options: DigitToastOptions(
                                localizations.translate(
                                  i18.deliverIntervention
                                      .checkForProductVariantsConfig,
                                ),
                                true,
                                theme,
                              ),
                            );
                          }

                          return BlocBuilder<ProductVariantBloc,
                              ProductVariantState>(
                            builder: (context, productState) {
                              return productState.maybeWhen(
                                orElse: () => const Offstage(),
                                fetched: (productVariantsvalue) {
                                  final variant = productState.whenOrNull(
                                    fetched: (productVariants) {
                                      return productVariants;
                                    },
                                  );

                                  return ReactiveFormBuilder(
                                    form: () => buildForm(
                                      context,
                                      productVariants,
                                      variant,
                                    ),
                                    builder: (context, form, child) {
                                      return ScrollableContent(
                                        enableFixedButton: true,
                                        footer: BlocBuilder<
                                            DeliverInterventionBloc,
                                            DeliverInterventionState>(
                                          builder: (context, state) {
                                            return DigitCard(
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, kPadding, 0, 0),
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                kPadding,
                                                0,
                                                kPadding,
                                                0,
                                              ),
                                              child: ValueListenableBuilder(
                                                valueListenable: clickedStatus,
                                                builder: (context,
                                                    bool isClicked, _) {
                                                  return DigitElevatedButton(
                                                    onPressed: isClicked
                                                        ? null
                                                        : () async {
                                                            if (((form.control(
                                                              _resourceDeliveredKey,
                                                            ) as FormArray)
                                                                        .value
                                                                    as List<
                                                                        ProductVariantModel?>)
                                                                .any((ele) =>
                                                                    ele?.productId ==
                                                                    null)) {
                                                              await DigitToast
                                                                  .show(
                                                                context,
                                                                options:
                                                                    DigitToastOptions(
                                                                  localizations
                                                                      .translate(i18
                                                                          .deliverIntervention
                                                                          .resourceDeliveredValidation),
                                                                  true,
                                                                  theme,
                                                                ),
                                                              );
                                                            } else if ((((form
                                                                            .control(
                                                                      _quantityDistributedKey,
                                                                    ) as FormArray)
                                                                        .value) ??
                                                                    [])
                                                                .any((e) => e == 0)) {
                                                              await DigitToast
                                                                  .show(
                                                                context,
                                                                options:
                                                                    DigitToastOptions(
                                                                  localizations
                                                                      .translate(i18
                                                                          .deliverIntervention
                                                                          .resourceCannotBeZero),
                                                                  true,
                                                                  theme,
                                                                ),
                                                              );
                                                            } else {
                                                              final lat =
                                                                  locationState
                                                                      .latitude;
                                                              final long =
                                                                  locationState
                                                                      .longitude;

                                                              List<TaskModel>
                                                                  taskData = [];
                                                              taskData.add(
                                                                _getTaskModel(
                                                                  context,
                                                                  form: form,
                                                                  oldTask: null,
                                                                  projectBeneficiaryClientReferenceId:
                                                                      projectBeneficiary
                                                                          .first
                                                                          .clientReferenceId,
                                                                  dose:
                                                                      deliveryInterventionstate
                                                                          .dose,
                                                                  cycle:
                                                                      deliveryInterventionstate
                                                                          .cycle,
                                                                  deliveryStrategy:
                                                                      DeliverStrategyType
                                                                          .direct
                                                                          .toValue(),
                                                                  address: householdMemberWrapper
                                                                      .members
                                                                      .first
                                                                      .address
                                                                      ?.first,
                                                                  latitude: lat,
                                                                  longitude:
                                                                      long,
                                                                  wrapper:
                                                                      householdMemberWrapper,
                                                                ),
                                                              );

                                                              final shouldSubmit =
                                                                  await DigitDialog
                                                                      .show<
                                                                          bool>(
                                                                context,
                                                                options:
                                                                    DigitDialogOptions(
                                                                  titleText:
                                                                      localizations
                                                                          .translate(
                                                                    i18.deliverIntervention
                                                                        .dialogTitle,
                                                                  ),
                                                                  contentText:
                                                                      localizations
                                                                          .translate(
                                                                    i18.deliverIntervention
                                                                        .dialogContent,
                                                                  ),
                                                                  primaryAction:
                                                                      DigitDialogActions(
                                                                    label: localizations
                                                                        .translate(
                                                                      i18.common
                                                                          .coreCommonSubmit,
                                                                    ),
                                                                    action:
                                                                        (ctx) {
                                                                      clickedStatus
                                                                              .value =
                                                                          true;

                                                                      if (!interventionSubmitted) {
                                                                        interventionSubmitted =
                                                                            true;
                                                                        context
                                                                            .read<DeliverInterventionBloc>()
                                                                            .add(
                                                                              DeliverInterventionSubmitEvent(
                                                                                taskData.first,
                                                                                false,
                                                                                context.boundary,
                                                                              ),
                                                                            );
                                                                        Future
                                                                            .delayed(
                                                                          const Duration(
                                                                            milliseconds:
                                                                                1000,
                                                                          ),
                                                                          () {
                                                                            reloadState.add(
                                                                              HouseholdOverviewReloadEvent(
                                                                                projectId: context.projectId,
                                                                                projectBeneficiaryType: context.beneficiaryType,
                                                                              ),
                                                                            );
                                                                          },
                                                                        ).then(
                                                                          (value) {
                                                                            !isHouseHoldSchool(reloadState.state.householdMemberWrapper)
                                                                                ? context.router.popAndPush(
                                                                                    HouseholdAcknowledgementRoute(
                                                                                      enableViewHousehold: true,
                                                                                    ),
                                                                                  )
                                                                                : context.router.popAndPush(
                                                                                    SchoolAcknowledgementRoute(
                                                                                      enableViewSchool: true,
                                                                                    ),
                                                                                  );
                                                                            Navigator.pop(ctx);
                                                                          },
                                                                        );
                                                                      }
                                                                    },
                                                                  ),
                                                                  secondaryAction:
                                                                      DigitDialogActions(
                                                                    label: localizations
                                                                        .translate(
                                                                      i18.common
                                                                          .coreCommonCancel,
                                                                    ),
                                                                    action: (context) =>
                                                                        Navigator
                                                                            .of(
                                                                      context,
                                                                      rootNavigator:
                                                                          true,
                                                                    ).pop(false),
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                          },
                                                    child: Center(
                                                      child: Text(
                                                        localizations.translate(
                                                          i18.common
                                                              .coreCommonSubmit,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                        header: const Column(children: [
                                          BackNavigationHelpHeaderWidget(
                                            showHelp: false,
                                          ),
                                        ]),
                                        children: [
                                          Column(
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: DigitCard(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        localizations.translate(
                                                          i18.deliverIntervention
                                                              .deliverInterventionLabel,
                                                        ),
                                                        style: theme.textTheme
                                                            .displayMedium,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              DigitCard(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      localizations.translate(
                                                        i18.deliverIntervention
                                                            .deliverInterventionResourceLabel,
                                                      ),
                                                      style: theme.textTheme
                                                          .headlineLarge,
                                                    ),
                                                    ..._controllers
                                                        .map((e) =>
                                                            ResourceBeneficiaryCard(
                                                              form: form,
                                                              cardIndex:
                                                                  _controllers
                                                                      .indexOf(
                                                                          e),
                                                              totalItems:
                                                                  _controllers
                                                                      .length,
                                                              onDelete:
                                                                  (index) {
                                                                (form.control(
                                                                  _resourceDeliveredKey,
                                                                ) as FormArray)
                                                                    .removeAt(
                                                                  index,
                                                                );
                                                                (form.control(
                                                                  _quantityDistributedKey,
                                                                ) as FormArray)
                                                                    .removeAt(
                                                                  index,
                                                                );
                                                                _controllers
                                                                    .removeAt(
                                                                  index,
                                                                );
                                                                setState(() {
                                                                  _controllers;
                                                                });
                                                              },
                                                            ))
                                                        .toList(),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
              );
            },
          ),
        );
      },
    );
  }

  addController(FormGroup form) {
    (form.control(_resourceDeliveredKey) as FormArray)
        .add(FormControl<ProductVariantModel>());
    (form.control(_quantityDistributedKey) as FormArray)
        .add(FormControl<String>(validators: [Validators.required]));
    (form.control(_quantityWastedKey) as FormArray)
        .add(FormControl<String>(validators: [Validators.required]));
  }

  // ignore: long-parameter-list
  TaskModel _getTaskModel(
    BuildContext context, {
    required FormGroup form,
    TaskModel? oldTask,
    int? cycle,
    int? dose,
    String? deliveryStrategy,
    String? projectBeneficiaryClientReferenceId,
    AddressModel? address,
    double? latitude,
    double? longitude,
    HouseholdMemberWrapper? wrapper,
  }) {
    // Initialize task with oldTask if available, or create a new one
    var task = oldTask;
    var clientReferenceId = task?.clientReferenceId ?? IdGen.i.identifier;
    task ??= TaskModel(
      projectBeneficiaryClientReferenceId: projectBeneficiaryClientReferenceId,
      clientReferenceId: clientReferenceId,
      tenantId: envConfig.variables.tenantId,
      rowVersion: 1,
      auditDetails: AuditDetails(
        createdBy: context.loggedInUserUuid,
        createdTime: context.millisecondsSinceEpoch(),
      ),
      clientAuditDetails: ClientAuditDetails(
        createdBy: context.loggedInUserUuid,
        createdTime: context.millisecondsSinceEpoch(),
      ),
    );

    // Extract productvariantList from the form
    final productvariantList =
        ((form.control(_resourceDeliveredKey) as FormArray).value
            as List<ProductVariantModel?>);
    final deliveryComment = form.control(_deliveryCommentKey).value as String?;

    final projectBeneficiary = wrapper?.projectBeneficiaries
        .where((element) =>
            element.clientReferenceId == projectBeneficiaryClientReferenceId)
        .firstOrNull;
    final individual = wrapper?.members
        .where((element) =>
            element.clientReferenceId ==
            projectBeneficiary?.beneficiaryClientReferenceId)
        .firstOrNull;

    DigitDOBAge? age = individual != null && individual.dateOfBirth != null
        ? DigitDateUtils.calculateAge(
            DigitDateUtils.getFormattedDateToDateTime(
                  individual.dateOfBirth!,
                ) ??
                DateTime.now(),
          )
        : null;

    final disabilityType =
        individual?.additionalFields?.fields.firstWhereOrNull(
      (element) => element.key == Constants.disabilityTypeKey,
    );

    final height = individual?.additionalFields?.fields.firstWhereOrNull(
      (element) => element.key == Constants.heightKey,
    );

    // Update the task with information from the form and other context
    task = task.copyWith(
      projectId: context.projectId,
      resources: productvariantList
          .map((e) => TaskResourceModel(
                taskclientReferenceId: clientReferenceId,
                clientReferenceId: IdGen.i.identifier,
                productVariantId: e?.id,
                isDelivered: true,
                taskId: task?.id,
                tenantId: envConfig.variables.tenantId,
                rowVersion: oldTask?.rowVersion ?? 1,
                quantity: (((form.control(_quantityDistributedKey) as FormArray)
                        .value)?[productvariantList.indexOf(e)])
                    .toString(),
                clientAuditDetails: ClientAuditDetails(
                  createdBy: context.loggedInUserUuid,
                  createdTime: context.millisecondsSinceEpoch(),
                ),
                auditDetails: AuditDetails(
                  createdBy: context.loggedInUserUuid,
                  createdTime: context.millisecondsSinceEpoch(),
                ),
                additionalFields:
                    TaskResourceAdditionalFields(version: 1, fields: [
                  AdditionalField(
                    _quantityWastedKey,
                    ((form.control(_quantityWastedRadioKey) as FormArray)
                                    .value)?[productvariantList.indexOf(e)]
                                .key ==
                            false
                        ? 0.0
                        : (((form.control(_quantityWastedKey) as FormArray)
                                .value)?[productvariantList.indexOf(e)])
                            .toString(),
                  ),
                  AdditionalField(
                    _bloodInUrineRadioKey,
                    ((form.control(_bloodInUrineRadioKey) as FormArray)
                            .value)?[productvariantList.indexOf(e)]
                        .key,
                  ),
                ]),
              ))
          .toList(),
      address: address?.copyWith(
        latitude: latitude ?? address.latitude,
        longitude: longitude ?? address.longitude,
        relatedClientReferenceId: clientReferenceId,
        id: null,
      ),
      status: Status.administeredSuccess.toValue(),
      additionalFields: TaskAdditionalFields(
        version: task.additionalFields?.version ?? 1,
        fields: [
          AdditionalField(
            AdditionalFieldsType.dateOfDelivery.toValue(),
            DateTime.now().millisecondsSinceEpoch.toString(),
          ),
          AdditionalField(
            AdditionalFieldsType.dateOfAdministration.toValue(),
            DateTime.now().millisecondsSinceEpoch.toString(),
          ),
          AdditionalField(
            AdditionalFieldsType.dateOfVerification.toValue(),
            DateTime.now().millisecondsSinceEpoch.toString(),
          ),
          AdditionalField(
            AdditionalFieldsType.cycleIndex.toValue(),
            "0${cycle ?? 1}",
          ),
          AdditionalField(
            AdditionalFieldsType.doseIndex.toValue(),
            "0${dose ?? 1}",
          ),
          AdditionalField(
            AdditionalFieldsType.deliveryStrategy.toValue(),
            deliveryStrategy,
          ),
          if (latitude != null)
            AdditionalField(
              AdditionalFieldsType.latitude.toValue(),
              latitude,
            ),
          if (longitude != null)
            AdditionalField(
              AdditionalFieldsType.longitude.toValue(),
              longitude,
            ),
          if (deliveryComment != null)
            AdditionalField(
              AdditionalFieldsType.deliveryComment.toValue(),
              deliveryComment,
            ),
          if (individual != null)
            AdditionalField(
              AdditionalFieldsType.individualClientreferenceId.toValue(),
              individual.clientReferenceId,
            ),
          if (individual?.gender != null)
            AdditionalField(
              AdditionalFieldsType.gender.toValue(),
              individual!.gender!.name,
            ),
          if (age != null)
            AdditionalField(
              AdditionalFieldsType.age.toValue(),
              "0${age.years * 12 + age.months}",
            ),
          if (age != null)
            AdditionalField(
              Constants.dob,
              DigitDateUtils.getFormattedDateToDateTime(
                    individual!.dateOfBirth!,
                  )?.millisecondsSinceEpoch ??
                  DateTime.now().microsecondsSinceEpoch,
            ),
          if (disabilityType != null) disabilityType,
          if (height != null) height,
          isHouseHoldSchool(wrapper!)
              ? addSchoolAdditionalType()
              : addHouseHoldAdditionalType(),
          if (isHouseHoldSchool(wrapper)) addSchoolName(wrapper),
        ],
      ),
    );

    return task;
  }

// This method builds a form used for delivering interventions.

  FormGroup buildForm(
    BuildContext context,
    List<ProductVariantsModel>? productVariants,
    List<ProductVariantModel>? variants,
  ) {
    final bloc = context.read<DeliverInterventionBloc>().state;

    // Add controllers for each product variant to the _controllers list.

    _controllers
        .addAll(productVariants!.map((e) => productVariants.indexOf(e)));

    return fb.group(<String, Object>{
      _doseAdministrationKey: FormControl<String>(
        value:
            '${localizations.translate(i18.deliverIntervention.cycle)} ${bloc.cycle == 0 ? (bloc.cycle + 1) : bloc.cycle}'
                .toString(),
        validators: [],
      ),
      _deliveryCommentKey: FormControl<String>(
        validators: [],
      ),
      _dateOfAdministrationKey:
          FormControl<DateTime>(value: DateTime.now(), validators: []),
      _resourceDeliveredKey: FormArray<ProductVariantModel>(
        [
          ..._controllers.map((e) => FormControl<ProductVariantModel>(
                value: variants != null &&
                        _controllers.indexOf(e) < variants.length
                    ? variants.firstWhereOrNull(
                        (element) =>
                            element.id ==
                            productVariants
                                .elementAt(_controllers.indexOf(e))
                                .productVariantId,
                      )
                    : null,
              )),
        ],
      ),
      _quantityDistributedKey: FormArray<double>([
        ..._controllers.map(
          (e) => FormControl<double>(
            value: _controllers.indexOf(e) < productVariants.length
                ? productVariants
                    .elementAt(_controllers.indexOf(e))
                    .quantity!
                    .toDouble()
                : 0,
            validators: [Validators.min(1)],
          ),
        ),
      ]),
      _quantityWastedKey: FormArray<double>([
        ..._controllers.map(
          (e) => FormControl<double>(value: 1),
        ),
      ]),
      _quantityWastedRadioKey: FormArray<KeyValue>([
        ..._controllers.map(
          (e) => FormControl<KeyValue>(value: Constants.yesNo[1]),
        ),
      ]),
      _bloodInUrineRadioKey: FormArray<KeyValue>([
        ..._controllers.map(
          (e) => FormControl<KeyValue>(value: Constants.yesNo[1]),
        ),
      ]),
    });
  }
}
