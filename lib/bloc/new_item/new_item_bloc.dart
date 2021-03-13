import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outmatic/api/api.dart';
import 'package:outmatic/bloc/new_item/bloc.dart';
import 'package:outmatic/model/item_detail_model.dart';

class NewItemBloc extends Bloc<NewItemEvent, NewItemState> {
  NewItemBloc() : super(NewItemInitialState());

  @override
  Stream<NewItemState> mapEventToState(NewItemEvent event) async* {
    if (event is NewItemSearchEvent) {
      yield* _mapNewItemSearchEventToState(event);
    } else if (event is NewItemRFIDScannedEvent) {
      yield* _mapNewItemRFIDScannedEventToState(event);
    } else if (event is NewItemAssignEvent) {
      yield* _mapNewItemAssignEventToState(event);
    }
  }

  Stream<NewItemState> _mapNewItemSearchEventToState(NewItemSearchEvent event) async* {
    yield NewItemLoadingState();
    final result = await Api.getItemDetails(event.query);
    if (!(result is Map)) {
      List<dynamic> dataList = result;
      if (dataList.length > 0) {
        yield NewItemSearchResultState(item: ItemDetailModel.fromJson(dataList[dataList.length - 1]));
      } else {
        yield NewItemSearchResultState(item: null);
      }
    } else {
      yield NewItemErrorState(code: result['status_code'], message: result['message']);
    }
  }

  Stream<NewItemState> _mapNewItemRFIDScannedEventToState(NewItemRFIDScannedEvent event) async* {
    yield NewItemLoadingState();
    final result = await Api.getItemsByTag(event.rfid);
    if (!(result is Map)) {
      List<dynamic> dataList = result;
      if (dataList.length > 0) {
        yield NewItemRFIDItemDetailFetchedState(item: dataList[dataList.length - 1]);
      } else {
        yield NewItemRFIDItemDetailFetchedState(item: null);
      }
    } else {
      yield NewItemErrorState(code: result['status_code'], message: result['message']);
    }
  }

  Stream<NewItemState> _mapNewItemAssignEventToState(NewItemAssignEvent event) async* {
    yield NewItemLoadingState();
    final result = await Api.assignTagToItem(event.title, event.rfid);
    if (result['status'] == 'UPDATE-Success') {
      yield NewItemUpdatedState();
    } else if (result['status'] == 'Input Error') {
      yield NewItemErrorState(code: 503, message: "Input Error");
    } else {
      yield NewItemErrorState(code: result['status_code'], message: result['message']);
    }
  }
}