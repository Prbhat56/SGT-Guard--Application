import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'report_type_state.dart';

class ReportTypeCubit extends Cubit<ReportTypeState> {
  ReportTypeCubit() : super(ReportTypeState.initial());

  void clickGreport() {
    emit(state.copyWith(isgeneralReport: true));
  }

  void clickMreport() {
    emit(state.copyWith(ismaintenanceReport: true));
  }

  void clickEreport() {
    emit(state.copyWith(isemergencyReport: true));
  }

  void clickPreport() {
    emit(state.copyWith(isparkingReport: true));
  }
}
