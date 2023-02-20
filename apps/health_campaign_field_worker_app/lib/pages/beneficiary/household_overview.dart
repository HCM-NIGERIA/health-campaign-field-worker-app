import 'package:digit_components/digit_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../blocs/household_overview/household_overview.dart';
import '../../models/data_model.dart';
import '../../router/app_router.dart';
import '../../utils/environment_config.dart';
import '../../utils/i18_key_constants.dart' as i18;
import '../../utils/utils.dart';
import '../../widgets/action_card/action_card.dart';
import '../../widgets/header/back_navigation_help_header.dart';
import '../../widgets/localized.dart';
import '../../widgets/member_card/member_card.dart';

class HouseholdOverviewPage extends LocalizedStatefulWidget {
  const HouseholdOverviewPage({super.key, super.appLocalizations});

  @override
  State<HouseholdOverviewPage> createState() => _HouseholdOverviewPageState();
}

class _HouseholdOverviewPageState
    extends LocalizedState<HouseholdOverviewPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<HouseholdOverviewBloc, HouseholdOverviewState>(
      builder: (ctx, state) {
        return Scaffold(
          body: state.loading
              ? const Center(child: CircularProgressIndicator())
              : BlocBuilder<HouseholdOverviewBloc, HouseholdOverviewState>(
                  builder: (ctx, state) {
                    if (state.loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return ScrollableContent(
                      header: Column(children: const [
                        BackNavigationHelpHeaderWidget(),
                      ]),
                      children: [
                        DigitCard(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      localizations.translate(
                                        i18.householdOverView
                                            .householdOverViewLabel,
                                      ),
                                      style: theme.textTheme.displayMedium,
                                      overflow: TextOverflow.ellipsis,
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
                                              i18.householdOverView
                                                  .householdOverViewEditLabel,
                                            ),
                                            action: () async {
                                              final bloc = context.read<
                                                  HouseholdOverviewBloc>();
                                              Navigator.of(
                                                context,
                                                rootNavigator: true,
                                              ).pop();
                                              await context.router.root.push(
                                                BeneficiaryRegistrationWrapperRoute(
                                                  isEditing: true,
                                                  householdMemberWrapper: state
                                                      .householdMemberWrapper,
                                                  children: [
                                                    HouseholdLocationRoute(),
                                                  ],
                                                ),
                                              );

                                              bloc.add(
                                                const HouseholdOverviewReloadEvent(),
                                              );
                                            },
                                          ),
                                          ActionCardModel(
                                            icon: Icons.delete,
                                            label: localizations.translate(i18
                                                .householdOverView
                                                .householdOverViewDeleteLabel),
                                            action: () => DigitDialog.show(
                                              context,
                                              options: DigitDialogOptions(
                                                titleText:
                                                    localizations.translate(i18
                                                        .householdOverView
                                                        .householdOverViewActionCardTitle),
                                                primaryAction:
                                                    DigitDialogActions(
                                                  label: localizations.translate(i18
                                                      .householdOverView
                                                      .householdOverViewPrimaryActionLabel),
                                                  action: (context) {
                                                    Navigator.of(
                                                      context,
                                                      rootNavigator: true,
                                                    ).pop();
                                                    Navigator.of(
                                                      context,
                                                      rootNavigator: true,
                                                    ).pop();
                                                  },
                                                ),
                                                secondaryAction:
                                                    DigitDialogActions(
                                                  label: localizations.translate(i18
                                                      .householdOverView
                                                      .householdOverViewSecondaryActionLabel),
                                                  action: (context) {
                                                    Navigator.of(
                                                      context,
                                                      rootNavigator: true,
                                                    ).pop();
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    iconText: localizations.translate(
                                      i18.householdOverView
                                          .householdOverViewEditIconText,
                                    ),
                                    icon: Icons.edit,
                                  ),
                                ],
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: DigitIconButton(
                                  icon: Icons.check_circle,
                                  iconText: localizations.translate(
                                    i18.householdOverView
                                        .householdOverViewDeliveredIconLabel,
                                  ),
                                  iconTextColor: DigitTheme
                                      .instance.colorScheme.onSurfaceVariant,
                                  iconColor: DigitTheme
                                      .instance.colorScheme.onSurfaceVariant,
                                ),
                              ),
                              DigitTableCard(
                                element: {
                                  localizations.translate(i18.householdOverView
                                          .householdOverViewHouseholdHeadNameLabel):
                                      state.householdMemberWrapper
                                          .headOfHousehold.name?.givenName,
                                  localizations.translate(
                                    i18.householdLocation
                                        .administrationAreaFormLabel,
                                  ): 'Solimbo',
                                  localizations.translate(
                                    i18.deliverIntervention.memberCountText,
                                  ): state.householdMemberWrapper.household
                                      .memberCount,
                                },
                              ),
                              Column(
                                children: state.householdMemberWrapper.members
                                    .map(
                                      (e) => MemberCard(
                                        secondaryAction: () async {
                                          final bloc =
                                              ctx.read<HouseholdOverviewBloc>();

                                          Navigator.of(
                                            context,
                                            rootNavigator: true,
                                          ).pop();

                                          await context.router.root.push(
                                            BeneficiaryRegistrationWrapperRoute(
                                              children: [
                                                IndividualDetailsRoute(
                                                  isHeadOfHousehold: false,
                                                ),
                                              ],
                                              householdMemberWrapper:
                                                  state.householdMemberWrapper,
                                              isEditing: true,
                                            ),
                                          );

                                          bloc.add(
                                            const HouseholdOverviewReloadEvent(),
                                          );
                                        },
                                        primaryAction: () {
                                          ctx.read<HouseholdOverviewBloc>().add(
                                                HouseholdOverviewSetAsHeadEvent(
                                                  individualModel: e,
                                                  householdModel: state
                                                      .householdMemberWrapper
                                                      .household,
                                                ),
                                              );

                                          Navigator.of(
                                            context,
                                            rootNavigator: true,
                                          ).pop();
                                        },
                                        name: e.name?.givenName ?? ' - ',
                                        age: (e.dateOfBirth == null
                                                ? null
                                                : DateFormat('dd/MM/yyyy')
                                                    .parse(e.dateOfBirth!)
                                                    .age) ??
                                            0,
                                        gender: e.gender?.name ?? ' - ',
                                        isDelivered: false,
                                        localizations: localizations,
                                      ),
                                    )
                                    .toList(),
                              ),
                              Center(
                                child: DigitIconButton(
                                  onPressed: () async {
                                    final bloc =
                                        context.read<HouseholdOverviewBloc>();

                                    await context.router.push(
                                      BeneficiaryRegistrationWrapperRoute(
                                        householdMemberWrapper: state
                                            .householdMemberWrapper
                                            .copyWith(
                                          members: [],
                                          headOfHousehold: IndividualModel(
                                            clientReferenceId:
                                                IdGen.i.identifier,
                                            tenantId:
                                                envConfig.variables.tenantId,
                                            rowVersion: 1,
                                          ),
                                        ),
                                        isEditing: true,
                                        children: [
                                          IndividualDetailsRoute(),
                                        ],
                                      ),
                                    );

                                    if (bloc.isClosed) return;

                                    bloc.add(
                                      const HouseholdOverviewReloadEvent(),
                                    );
                                  },
                                  iconText: localizations.translate(
                                    i18.householdOverView
                                        .householdOverViewAddActionText,
                                  ),
                                  icon: Icons.add,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
          bottomNavigationBar: SizedBox(
            height: 90,
            child: DigitCard(
              child: DigitElevatedButton(
                onPressed: () async {
                  final bloc = ctx.read<HouseholdOverviewBloc>();
                  await context.router.push(DeliverInterventionRoute());

                  bloc.add(const HouseholdOverviewReloadEvent());
                },
                child: Center(
                  child: Text(
                    localizations.translate(
                      i18.householdOverView.householdOverViewActionText,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
