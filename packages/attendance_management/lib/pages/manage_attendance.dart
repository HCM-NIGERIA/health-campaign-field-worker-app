import 'package:attendance_management/attendance_management.dart';
import 'package:attendance_management/widgets/attendance_acknowledgement.dart';
import 'package:digit_components/digit_components.dart';
import '../../utils/i18_key_constants.dart' as i18;
import 'package:digit_components/utils/date_utils.dart';
import 'package:digit_components/widgets/atoms/digit_toaster.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/localized.dart';

class ManageAttendancePage extends LocalizedStatefulWidget {
  final AttendanceListeners attendanceListeners;
  final String projectId;
  final String userId;
  const ManageAttendancePage({
    required this.attendanceListeners,
    required this.projectId,
    required this.userId,
    super.key,
  });

  @override
  State<ManageAttendancePage> createState() => _ManageAttendancePageState();
}

class _ManageAttendancePageState extends State<ManageAttendancePage> {
  List<AttendancePackageRegisterModel> attendanceRegisters = [];

  bool empty = false;
  AttendanceBloc attendanceBloc = AttendanceBloc(const RegisterLoading());
  List<Widget> list = [];

  @override
  void initState() {
    AttendanceSingleton().setAttendanceListeners(
        attendanceListeners: widget.attendanceListeners,
        projectId: widget.projectId,
        userId: widget.userId);
    AttendanceSingleton().onHcmLocalizationChanged((locales) {
      AppLogger.instance.info('attendance locales: $locales');
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AttendanceBloc>(
      create: (context) =>
          attendanceBloc..add(const AttendanceEvents.initial()),
      child: BlocListener<AttendanceBloc, AttendanceStates>(
        listener: (ctx, states) {
          if (states is RegisterLoaded) {
            attendanceRegisters = states.registers;
            for (int i = 0; i < attendanceRegisters.length; i++) {
              final register = attendanceRegisters[i];
              list.add(RegisterCard(
                  data: {
                    'Campaign Type':
                        register.additionalDetails?['campaignName'],
                    'Event Type': register.additionalDetails?['eventType'],
                    'Staff Count': register.staff?.length ?? 0,
                    'Start Date': register.startDate != null
                        ? DigitDateUtils.getDateFromTimestamp(
                            register.startDate!)
                        : 'N/A',
                    'End Date': register.endDate != null
                        ? DigitDateUtils.getDateFromTimestamp(register.endDate!)
                        : 'N/A',
                    'Status': register.status,
                    'Attendance Completion': 'N/A'
                  },
                  regisId: register.id,
                  tenantId: register.tenantId!,
                  show: true,
                  startDate: DateTime.fromMillisecondsSinceEpoch(
                    register.startDate!,
                  ),
                  endDate: DateTime.fromMillisecondsSinceEpoch(
                    register.endDate!,
                  )));
            }
          }
        },
        child: Scaffold(
          body: SingleChildScrollView(child:
              BlocBuilder<AttendanceBloc, AttendanceStates>(
                  builder: (context, blocState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Manage Attendance",
                    style: DigitTheme
                        .instance.mobileTheme.textTheme.headlineLarge
                        ?.apply(color: const DigitColors().black),
                    textAlign: TextAlign.left,
                  ),
                ),
                empty
                    ? const Center(
                        child: Card(
                          child: SizedBox(
                            height: 60,
                            width: 200,
                            child: Center(child: Text("No Data Found")),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                blocState.maybeWhen(
                  orElse: () => const SizedBox.shrink(),
                  registerLoaded: (registers) => Column(
                    children: [
                      ...list,
                    ],
                  ),
                  registerLoading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  registerError: (message) => Center(
                    child: Card(
                      child: SizedBox(
                        height: 60,
                        width: 200,
                        child: Center(child: Text(message)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: PoweredByDigit(
                    version: '1.2.0',
                  ),
                ),
              ],
            );
          })),
        ),
      ),
    );
  }
}

class RegisterCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final String tenantId;
  final String regisId;
  final bool show;
  final DateTime startDate;
  final DateTime endDate;

  const RegisterCard({
    super.key,
    required this.data,
    required this.tenantId,
    required this.regisId,
    this.show = false,
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    DateTime s = DateTime.now();

    return DigitCard(
      child: Column(
        children: [
          DigitTableCard(
            element: data,
          ),
          show
              ? DigitElevatedButton(
                  child: Text(
                    ((s.isAfter(startDate) || s.isAtSameMomentAs(startDate)) &&
                            (s.isBefore(endDate) ||
                                s.isAtSameMomentAs(endDate)))
                        ? 'Mark Attendance'
                        : 'View Attendance',
                  ),
                  onPressed: () {
                    // DigitToast.show(
                    //   context,
                    //   options: DigitToastOptions(
                    //     'No Attendee registered for this register',
                    //     true,
                    //     DigitTheme.instance.mobileTheme,
                    //   ),
                    // );
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            AttendanceAcknowledgementPage(label: 'Success')));
                  },
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
