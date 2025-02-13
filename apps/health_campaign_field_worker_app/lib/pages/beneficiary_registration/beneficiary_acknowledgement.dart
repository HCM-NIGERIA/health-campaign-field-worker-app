import 'package:collection/collection.dart';
import 'package:digit_components/digit_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../router/app_router.dart';
import '../../../utils/i18_key_constants.dart' as i18;
import '../../../widgets/localized.dart';
import '../../blocs/search_households/search_households.dart';
import '../../models/entities/identifier_types.dart';

class BeneficiaryAcknowledgementPage extends LocalizedStatefulWidget {
  final bool? enableViewHousehold;

  const BeneficiaryAcknowledgementPage({
    super.key,
    super.appLocalizations,
    this.enableViewHousehold,
  });

  @override
  State<BeneficiaryAcknowledgementPage> createState() =>
      _BeneficiaryAcknowledgementPageState();
}

class _BeneficiaryAcknowledgementPageState
    extends LocalizedState<BeneficiaryAcknowledgementPage> {
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
          final searchBloc = context.read<SearchHouseholdsBloc>();
          searchBloc.add(
            const SearchHouseholdsClearEvent(),
          );
          context.router.pop();
        },
        secondaryAction: () {
          final bloc = context.read<SearchHouseholdsBloc>();
          if (bloc.state.householdMembers.isEmpty) {
            context.router.pop();
          } else {
            context.router.popAndPush(
              BeneficiaryWrapperRoute(
                wrapper: bloc.state.householdMembers.first,
              ),
            );
          }
        },
        enableViewHousehold: widget.enableViewHousehold ?? false,
        secondaryLabel: localizations.translate(
          i18.householdDetails.viewHouseHoldDetailsAction,
        ),
        actionLabel:
            localizations.translate(i18.acknowledgementSuccess.actionLabelText),
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
