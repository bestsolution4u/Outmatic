import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outmatic/api/api.dart';
import 'package:outmatic/bloc/bloc.dart';
import 'package:outmatic/model/item_model.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  ItemBloc() : super(ItemInitialState());

  @override
  Stream<ItemState> mapEventToState(ItemEvent event) async* {
    if (event is ItemFetchEvent) {
      yield* _mapItemFetchEventToState(event);
    } else if (event is ItemSearchEvent) {
      yield* _mapItemSearchEventToState(event);
    } else if (event is ItemScanEvent) {
      yield* _mapItemScanEventToState(event);
    }
  }

  Stream<ItemState> _mapItemFetchEventToState(ItemFetchEvent event) async* {
    yield ItemLoadingState();
    final result = await Api.getItems(event.page);
    if (!(result is Map)) {
      List<dynamic> dataList = result;
      if (dataList.length > 0) {
        int total = dataList[0]['artikel_counter'];
        List<ItemModel> items = dataList.map((e) => ItemModel.fromJson(e)).toList();
        yield ItemFetchedState(items: items, totalItemCount: total);
      } else {
        yield ItemFetchedState(items: [], totalItemCount: 0);
      }
    } else {
      yield ItemErrorState(code: result['status_code'], message: result['message']);
    }
  }

  Stream<ItemState> _mapItemSearchEventToState(ItemSearchEvent event) async* {
    yield ItemLoadingState();
    final result = await Api.getItemDetails(event.query);
    if (!(result is Map)) {
      List<dynamic> dataList = result;
      if (dataList.length > 0) {
        List<ItemModel> items = dataList.map((e) => ItemModel.fromJson(e)).toList();
        yield ItemSearchResultState(items: items);
      } else {
        yield ItemSearchResultState(items: []);
      }
    } else {
      yield ItemSearchResultState(items: []);
      //yield ItemErrorState(code: result['status_code'], message: result['message']);
    }
  }

  Stream<ItemState> _mapItemScanEventToState(ItemScanEvent event) async* {
    yield ItemLoadingState();
    final result = await Api.getItemListByTag(event.rfid);
    if (!(result is Map)) {
      List<dynamic> dataList = result;
      if (dataList.length > 0) {
        List<ItemModel> items = dataList.map((e) => ItemModel.fromScanResult(e)).toList();
        yield ItemScanResultState(items: items);
      } else {
        yield ItemScanResultState(items: []);
      }
    } else {
      yield ItemScanResultState(items: []);
      //yield ItemErrorState(code: result['status_code'], message: result['message']);
    }
  }
}