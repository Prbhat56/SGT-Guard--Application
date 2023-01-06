// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'report_type_cubit.dart';

class ReportTypeState extends Equatable {
  final bool isgeneralReport;
  final bool ismaintenanceReport;
  final bool isemergencyReport;
  final bool isparkingReport;
  ReportTypeState({
    required this.isgeneralReport,
    required this.ismaintenanceReport,
    required this.isemergencyReport,
    required this.isparkingReport,
  });

  factory ReportTypeState.initial() {
    return ReportTypeState(
        isgeneralReport: false,
        ismaintenanceReport: false,
        isemergencyReport: false,
        isparkingReport: false);
  }
  @override
  List<Object> get props => [
        isgeneralReport,
        ismaintenanceReport,
        isemergencyReport,
        isparkingReport
      ];

  ReportTypeState copyWith({
    bool? isgeneralReport,
    bool? ismaintenanceReport,
    bool? isemergencyReport,
    bool? isparkingReport,
  }) {
    return ReportTypeState(
      isgeneralReport: isgeneralReport ?? this.isgeneralReport,
      ismaintenanceReport: ismaintenanceReport ?? this.ismaintenanceReport,
      isemergencyReport: isemergencyReport ?? this.isemergencyReport,
      isparkingReport: isparkingReport ?? this.isparkingReport,
    );
  }
}
