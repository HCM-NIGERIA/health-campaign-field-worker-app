import 'dart:convert';

import 'package:digit_components/digit_components.dart';
import 'package:digit_components/models/digit_table_model.dart';
import 'package:digit_components/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:recase/recase.dart';

import '../../blocs/household_overview/household_overview.dart';
import '../../blocs/localization/app_localization.dart';
import '../../blocs/search_households/search_households.dart';
import '../../models/data_model.dart';
import '../../router/app_router.dart';
import '../../utils/utils.dart';
import '../../widgets/action_card/action_card.dart';
import '../../widgets/component_wrapper/product_variant_bloc_wrapper.dart';
import '../../widgets/header/back_navigation_help_header.dart';
import '../beneficiary_registration/household_details.dart';
import '../../utils/i18_key_constants.dart' as i18;
import '../../widgets/localized.dart';

class BeneficiaryDetailsPage extends LocalizedStatefulWidget {
  const BeneficiaryDetailsPage({
    super.key,
    super.appLocalizations,
  });

  @override
  State<BeneficiaryDetailsPage> createState() => _BeneficiaryDetailsPageState();
}

class _BeneficiaryDetailsPageState
    extends LocalizedState<BeneficiaryDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context);
    final router = context.router;

    const String jsonData = '''
  {
    "id": "40a528a0-4e0e-11ee-be56-0242ac120002",
    "name": "configuration for Multi Round Campaigns",
    "code": "MR-DN",
    "group": "MALARIA",
    "beneficiaryType": "HOUSEHOLD",
    "eligibilityCriteria": [
      "All households having members under the age of 18 are eligible.",
      "Prison inmates are eligible."
    ],
    "taskProcedure": [
      "1 bednet is to be distributed per 2 household members.",
      "If there are 4 household members, 2 bednets should be distributed.",
      "If there are 5 household members, 3 bednets should be distributed."
    ],
    "resources": [
      {
        "productVariantId": "PVAR-2022-12-20-000036",
        "isBaseUnitVariant": false
      },
      {
        "productVariantId": "PVAR-2022-12-20-000037",
        "isBaseUnitVariant": true
      }
    ],
    "observationStrategy": "DOT1",
    "cycles": [
      {
        "mandatoryWaitSinceLastCycleInDays": null,
        "deliveries": [
          {
            "mandatoryWaitSinceLastDeliveryInDays": null,
            "ProductVariants": {
              "SP500": "1",
              "AQ500": "1"
            },
            "deliveryStrategy": "DIRECT"
          },
          {
            "mandatoryWaitSinceLastDeliveryInDays": "10",
            "ProductVariants": {
              "sp500": "1"
            },
            "deliveryStrategy": "INDIRECT"
          },
          {
            "mandatoryWaitSinceLastDeliveryInDays": "20",
            "ProductVariants": {
              "pvid2": "2"
            },
            "deliveryStrategy": "INDIRECT"
          }
        ]
      },
      {
        "mandatoryWaitSinceLastCycleInDays": "30",
        "deliveries": [
          {
            "mandatoryWaitSinceLastDeliveryInDays": "15",
            "ProductVariants": {
              "SP500": "1",
              "AQ500": "1"
            },
            "deliveryStrategy": "DIRECT"
          },
          {
            "mandatoryWaitSinceLastDeliveryInDays": "10",
            "ProductVariants": {
              "AQ500": "1"
            },
            "deliveryStrategy": "INDIRECT"
          },
          {
            "mandatoryWaitSinceLastDeliveryInDays": "20",
            "ProductVariants": {
              "SP500": "1"
            },
            "deliveryStrategy": "INDIRECT"
          }
        ]
      }
    ]
  }
  '''; // code to be deleted jsonData once setup done

    final Map<String, dynamic> jsonDataMap = jsonDecode(jsonData);
    final List<dynamic> cycles = jsonDataMap['cycles'];

    final headerList = [
      TableHeader(
        'Dose',
        cellKey: 'dose',
      ),
      TableHeader(
        'Completed on',
        cellKey: 'completedOn',
      ),
      TableHeader(
        'Status',
        cellKey: 'Status',
      ),
      TableHeader(
        'Resources',
        cellKey: 'resources',
      ),
      TableHeader(
        'Quantity',
        cellKey: 'quantity',
      ),
    ];

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

          final taskData = state.householdMemberWrapper.tasks
              ?.where((element) =>
                  element.projectBeneficiaryClientReferenceId ==
                  projectBeneficiary.first.clientReferenceId)
              .toList();

          return Scaffold(
            body: ReactiveFormBuilder(
              form: buildForm,
              builder: (context, formGroup, child) => ScrollableContent(
                header: const Column(children: [
                  BackNavigationHelpHeaderWidget(),
                ]),
                footer: SizedBox(
                  height: 85,
                  child: DigitCard(
                    margin: const EdgeInsets.only(left: 0, right: 0, top: 10),
                    child: DigitElevatedButton(
                      onPressed: () {
                        router.push(DeliverInterventionRoute());
                      },
                      child: Center(
                        child: Text(
                          localizations.translate(i18.common.coreCommonNext),
                        ),
                      ),
                    ),
                  ),
                ),
                children: [
                  DigitCard(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                localizations.translate(i18.beneficiaryDetails
                                    .beneficiarysDetailsLabelText),
                                style: theme.textTheme.displayMedium,
                              ),
                            ),
                            DigitIconButton(
                              onPressed: () => DigitActionDialog.show(
                                context,
                                widget: ActionCard(
                                  items: [
                                    ActionCardModel(
                                      icon: Icons.edit,
                                      label: localizations.translate(
                                        i18.beneficiaryDetails
                                            .beneficiarysDetailsEditIconLabel,
                                      ),
                                      action: () async {},
                                    ),
                                    ActionCardModel(
                                      icon: Icons.delete,
                                      label: localizations.translate(i18
                                          .beneficiaryDetails
                                          .beneficiarysDetailsDeleteIconLabel),
                                      action: () => null,
                                      // action: () => DigitDialog.show(
                                      //   context,
                                      //   options: DigitDialogOptions(
                                      //     titleText: localizations.translate(i18
                                      //         .householdOverView
                                      //         .householdOverViewActionCardTitle),
                                      //     primaryAction: DigitDialogActions(
                                      //       label: localizations.translate(i18
                                      //           .householdOverView
                                      //           .householdOverViewPrimaryActionLabel),
                                      //       action: (ctx) {
                                      //         Navigator.of(
                                      //           ctx,
                                      //           rootNavigator: true,
                                      //         )
                                      //           ..pop()
                                      //           ..pop();
                                      //         context.router.push(
                                      //           ReasonForDeletionRoute(
                                      //             isHousholdDelete: true,
                                      //           ),
                                      //         );
                                      //       },
                                      //     ),
                                      //     secondaryAction: DigitDialogActions(
                                      //       label: localizations.translate(i18
                                      //           .householdOverView
                                      //           .householdOverViewSecondaryActionLabel),
                                      //       action: (context) {
                                      //         Navigator.of(
                                      //           context,
                                      //           rootNavigator: true,
                                      //         ).pop();
                                      //       },
                                      //     ),
                                      //   ),
                                      // ),
                                    ),
                                  ],
                                ),
                              ),
                              iconText: localizations.translate(
                                i18.beneficiaryDetails
                                    .beneficiarysDetailsEditIconLabelText,
                              ),
                              icon: Icons.edit,
                            ),
                          ],
                        ),
                        DigitTableCard(
                          element: {
                            localizations.translate(i18.householdOverView
                                    .householdOverViewHouseholdHeadLabel):
                                householdMemberWrapper
                                        .headOfHousehold.name?.givenName ??
                                    '',
                            localizations.translate(
                              i18.deliverIntervention.idTypeText,
                            ): () {
                              final identifiers = householdMemberWrapper
                                  .headOfHousehold.identifiers;
                              if (identifiers == null || identifiers.isEmpty) {
                                return '';
                              }

                              return identifiers.first.identifierType ?? '';
                            }(),
                            localizations.translate(
                              i18.deliverIntervention.idNumberText,
                            ): () {
                              final identifiers = householdMemberWrapper
                                  .headOfHousehold.identifiers;
                              if (identifiers == null || identifiers.isEmpty) {
                                return '';
                              }

                              return identifiers.first.identifierId ?? '';
                            }(),
                            localizations.translate(
                              i18.common.coreCommonAge,
                            ): () {
                              final dob = householdMemberWrapper
                                  .headOfHousehold.dateOfBirth;
                              if (dob == null || dob.isEmpty) {
                                return '';
                              }

                              final int years = DigitDateUtils.calculateAge(
                                DigitDateUtils.getFormattedDateToDateTime(
                                      dob,
                                    ) ??
                                    DateTime.now(),
                              ).years;
                              final int months = DigitDateUtils.calculateAge(
                                DigitDateUtils.getFormattedDateToDateTime(
                                      dob,
                                    ) ??
                                    DateTime.now(),
                              ).months;

                              return "$years ${localizations.translate(i18.memberCard.deliverDetailsYearText)} $months ${localizations.translate(i18.memberCard.deliverDetailsMonthsText)}";
                            }(),
                            localizations.translate(
                              i18.common.coreCommonGender,
                            ): householdMemberWrapper.headOfHousehold.gender
                                    ?.name.sentenceCase ??
                                '',
                            localizations.translate(
                              i18.common.coreCommonMobileNumber,
                            ): householdMemberWrapper
                                    .headOfHousehold.mobileNumber ??
                                '',
                            localizations.translate(i18.deliverIntervention
                                .dateOfRegistrationLabel): () {
                              final date =
                                  projectBeneficiary.first.dateOfRegistration;

                              final registrationDate =
                                  DateTime.fromMillisecondsSinceEpoch(
                                date,
                              );

                              return DateFormat('dd MMMM yyyy')
                                  .format(registrationDate);
                            }(),
                          },
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: List<Widget>.generate(cycles.length, (int i) {
                      final cycleName = 'Cycle ${i + 1}';

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DigitCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cycleName,
                                  style: theme.textTheme.headlineMedium,
                                  textAlign: TextAlign.left,
                                ),
                                DigitTable(
                                  headerList: headerList,
                                  tableData: const [], // You can replace this with actual data for each cycle
                                  leftColumnWidth: 130,
                                  rightColumnWidth: headerList.length * 17 * 6,
                                  height: 6 * 57,
                                ),
                                // Add other widgets or components to display cycle-specific data here
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  FormGroup buildForm() {
    return fb.group(<String, Object>{});
  }
}
