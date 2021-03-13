import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outmatic/api/api.dart';
import 'package:outmatic/bloc/item_detail/bloc.dart';
import 'package:outmatic/model/item_detail_model.dart';

class ItemDetailBloc extends Bloc<ItemDetailEvent, ItemDetailState> {
  ItemDetailBloc() : super(ItemDetailInitialState());

  @override
  Stream<ItemDetailState> mapEventToState(ItemDetailEvent event) async* {
    if (event is ItemDetailFetchEvent) {
      yield* _mapItemDetailFetchEventToState(event);
    }
  }

  Stream<ItemDetailState> _mapItemDetailFetchEventToState(ItemDetailFetchEvent event) async* {
    yield ItemDetailLoadingState();
    final result = await Api.getItemDetails(event.nodeTitle);
    if (!(result is Map)) {
      List<dynamic> dataList = result;
      if (dataList.length > 0) {
        yield ItemDetailFetchedState(item: ItemDetailModel.fromJson(dataList[0]));
      } else {
        yield ItemDetailFetchedState(item: null);
      }
    } else {
      yield ItemDetailErrorState(code: result['status_code'], message: result['message']);
    }
  }
}