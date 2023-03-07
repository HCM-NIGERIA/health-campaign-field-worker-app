import 'package:digit_components/digit_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/service_definition/service_definition.dart';
import '../../utils/i18_key_constants.dart' as i18;
import '../../widgets/header/back_navigation_help_header.dart';
import '../../widgets/localized.dart';
import '../../router/app_router.dart';
import 'package:digit_components/widgets/digit_project_cell.dart';

class ChecklistPage extends LocalizedStatefulWidget {
  const ChecklistPage({
    Key? key,
    super.appLocalizations,
  }) : super(key: key);

  @override
  State<ChecklistPage> createState() => _ChecklistPageState();
}

class _ChecklistPageState extends LocalizedState<ChecklistPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: ScrollableContent(
        header: Column(children: const [
          BackNavigationHelpHeaderWidget(),
        ]),
        children: [
          BlocBuilder<ServiceDefinitionBloc, ServiceDefinitionState>(
            builder: (context, state) {
              return state.map(
                empty: (value) => const Text('No Checklist'),
                isloading: (value) => const Center(
                  child: CircularProgressIndicator(),
                ),
                serviceDefinitionFetch:
                    (ServiceDefinitionServiceFetchedState value) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        localizations.translate(
                          i18.checklist.checklistlabel,
                        ),
                        style: theme.textTheme.displayMedium,
                      ),
                    ),
                    Column(
                      children: value.serviceDefinitionList
                          .map((e) => DigitProjectCell(
                                projectText: '${e.code}',
                                // ignore: no-empty-block
                                onTap: () {
                                  context.read<ServiceDefinitionBloc>().add(
                                        ServiceDefinitionSelectionEvent(
                                          serviceDefinition: e,
                                        ),
                                      );
                                  context.router.push(ChecklistViewRoute());
                                },
                              ))
                          .toList(),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}