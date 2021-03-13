import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outmatic/api/api.dart';
import 'package:outmatic/bloc/vca/bloc.dart';
import 'package:outmatic/model/tag_item_detail_model.dart';

class VCABloc extends Bloc<VCAEvent, VCAState> {
  VCABloc() : super(VCAInitialState());

  @override
  Stream<VCAState> mapEventToState(VCAEvent event) async* {
    if (event is VCADetailEvent) {
      yield* _mapVCADetailEventToState(event);
    } else if (event is VCAUpdateEvent) {
      yield* _mapVCAUpdateEventToState(event);
    }
  }

  Stream<VCAState> _mapVCADetailEventToState(VCADetailEvent event) async* {
    yield VCALoadingState();
    final result = await Api.getItemsByTag(event.rfid);
    if (!(result is Map)) {
      List<dynamic> dataList = result;
      if (dataList.length > 0) {
        yield VCAItemFetchedState(item: TagItemDetailModel.fromJson(dataList[dataList.length - 1]));
      } else {
        yield VCAItemFetchedState(item: null);
      }
    } else {
      yield VCAErrorState(code: result['status_code'], message: result['message']);
    }
  }

  Stream<VCAState> _mapVCAUpdateEventToState(VCAUpdateEvent event) async* {
    yield VCALoadingState();
    final result = await Api.updateVCAItems(event.title);

    if (result["status"] == "UPDATE-Success") {
      yield VCAUpdatedState();
    } else {
      yield VCAErrorState(code: result['status_code'], message: result['message']);
    }
  }
}