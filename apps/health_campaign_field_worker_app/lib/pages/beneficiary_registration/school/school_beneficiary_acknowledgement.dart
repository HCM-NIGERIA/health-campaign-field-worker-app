import 'package:collection/collection.dart';
import 'package:digit_components/digit_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/household_overview/household_overview.dart';
import '../../../blocs/search_households/search_bloc_common_wrapper.dart';
import '../../../blocs/search_households/search_households.dart';
import '../../../models/entities/identifier_types.dart';
import '../../../router/app_router.dart';
import '../../../utils/i18_key_constants.dart' as i18;
import '../../../widgets/localized.dart';

class SchoolBeneficiaryAcknowledgementPage extends LocalizedStatefulWidget {
  final bool? enableViewSchool;

  const SchoolBeneficiaryAcknowledgementPage({
    super.key,
    super.appLocalizations,
    this.enableViewSchool,
  });

  @override
  State<SchoolBeneficiaryAcknowledgementPage> createState() =>
      _BeneficiaryAcknowledgementPageState();
}

class _BeneficiaryAcknowledgementPageState
    extends LocalizedState<SchoolBeneficiaryAcknowledgementPage> {
  late final HouseholdMemberWrapper? wrapper;

  @override
  void initState() {
    final bloc = context.read<SearchHouseholdsBloc>();
    wrapper = bloc.state.householdMembers.lastOrNull;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DigitAcknowledgement.success(
        action: () {
          context.router.pop();
        },
        secondaryAction: () {
          final bloc = context.read<SearchBlocWrapper>();

          context.router.popAndPush(
            BeneficiaryWrapperRoute(
              wrapper: bloc.state.householdMembers.firstOrNull!,
              children: [SchoolOverviewRoute()],
            ),
          );
        },
        enableViewHousehold: widget.enableViewSchool ?? false,
        secondaryLabel: localizations.translate(
          i18.schoolDetails.viewSchoolDetailsAction,
        ),
        actionLabel:
            localizations.translate(i18.schoolDetails.schoolActionLabelText),
        description: localizations.translate(
          i18.acknowledgementSuccess.acknowledgementDescriptionText,
        ),
        subLabel: getSubText(wrapper),
        label: localizations
            .translate(i18.acknowledgementSuccess.acknowledgementLabelText),
      ),
    );
  }

  getSubText(HouseholdMemberWrapper? wrapper) {
    return wrapper != null
        ? '${localizations.translate(i18.beneficiaryDetails.beneficiaryId)}\n'
            '${wrapper.members.lastOrNull!.name!.givenName} - '
            '${wrapper.members.lastOrNull!.identifiers!.lastWhereOrNull(
                  (e) =>
                      e.identifierType ==
                      IdentifierTypes.uniqueBeneficiaryID.toValue(),
                )!.identifierId ?? localizations.translate(i18.common.noResultsFound)}'
        : '';
  }
}
