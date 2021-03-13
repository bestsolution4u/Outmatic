import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outmatic/api/api.dart';
import 'package:outmatic/bloc/return_item/bloc.dart';
import 'package:outmatic/model/tag_item_detail_model.dart';

class ReturnItemBloc extends Bloc<ReturnItemEvent, ReturnItemState> {
  ReturnItemBloc() : super(ReturnItemInitialState());

  @override
  Stream<ReturnItemState> mapEventToState(ReturnItemEvent event) async* {
    if (event is ReturnItemDetailEvent) {
      yield* _mapReturnItemDetailEventToState(event);
    } else if (event is ReturnItemUpdateEvent) {
      yield* _mapReturnItemUpdateEventToState(event);
    }
  }

  Stream<ReturnItemState> _mapReturnItemDetailEventToState(ReturnItemDetailEvent event) async* {
    yield ReturnItemLoadingState();
    final result = await Api.getItemsByTag(event.rfid);
    if (!(result is Map)) {
      List<dynamic> dataList = result;
      if (dataList.length > 0) {
        yield ReturnItemFetchedState(item: TagItemDetailModel.fromJson(dataList[dataList.length - 1]));
      } else {
        yield ReturnItemFetchedState(item: null);
      }
    } else {
      yield ReturnItemErrorState(code: result['status_code'], message: result['message']);
    }
  }

  Stream<ReturnItemState> _mapReturnItemUpdateEventToState(ReturnItemUpdateEvent event) async* {
    yield ReturnItemLoadingState();
    final result = await Api.updateReturnItems(event.nodeTitle);
    if (!(result is Map)) {
      List<dynamic> dataList = result;
      if (dataList.length > 0) {
        yield ReturnItemUpdatedState(items: dataList.map((e) => TagItemDetailModel.fromJson(e)).toList());
      } else {
        yield ReturnItemUpdatedState(items: null);
      }
    } else {
      yield ReturnItemErrorState(code: result['status_code'], message: result['message']);
    }
  }
}