import 'package:glinkwok_provider/src/common/bloc/base_cubit.dart';
import 'package:glinkwok_provider/src/model/summary_response.dart';
import 'package:simplest/simplest.dart';

part 'summary_state.dart';

class SummaryCubit extends BaseCubit<SummaryState> {
  SummaryCubit() : super(SummaryInitial());

  getSummary() async {
    DateFormat dateFormat = DateFormat.M();
    DateTime date = DateTime.now();
    String data = dateFormat.format(date);
    try {
      emit(state.copyWith(isLoading: true));
      final summaryResponse = await dataRepository.getSummary(data: data);
      emit(GetSummarySuccessState(summaryResponse, state));
    } catch (e) {
      handleAppError(e);
      logger.e(e);
    }
    emit(state.copyWith(isLoading: false));
  }
}
