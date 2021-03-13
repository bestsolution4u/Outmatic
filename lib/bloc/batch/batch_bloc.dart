import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outmatic/api/api.dart';
import 'package:outmatic/model/batch_project_model.dart';
import 'package:outmatic/model/med_model.dart';
import 'package:outmatic/model/tag_item_detail_model.dart';

import 'bloc.dart';

class BatchBloc extends Bloc<BatchEvent, BatchState> {
  BatchBloc() : super(BatchInitialState());

  @override
  Stream<BatchState> mapEventToState(BatchEvent event) async* {
    if (event is BatchItemDetailEvent) {
      yield* _mapBatchItemDetailEventToState(event);
    } else if (event is BatchUpdateEvent) {
      yield* _mapBatchUpdateEventToState(event);
    } else if (event is BatchMedSearchEvent) {
      yield* _mapBatchMedSearchEventToState(event);
    } else if (event is BatchPrdSearchEvent) {
      yield* _mapBatchPrdSearchEventToState(event);
    }
  }

  Stream<BatchState> _mapBatchItemDetailEventToState(BatchItemDetailEvent event) async* {
    yield BatchLoadingState();
    final result = await Api.getItemsByTag(event.rfid);
    if (!(result is Map)) {
      List<dynamic> dataList = result;
      if (dataList.length > 0) {
        List<TagItemDetailModel> items = dataList.map((e) => TagItemDetailModel.fromJson(e)).toList();
        yield BatchItemFetchedState(items: items);
      } else {
        yield BatchItemFetchedState(items: []);
      }
    } else {
      yield BatchErrorState(code: result['status_code'], message: result['message']);
    }
  }

  Stream<BatchState> _mapBatchMedSearchEventToState(BatchMedSearchEvent event) async* {
    yield BatchLoadingState();
    final result = await Api.searchUser(event.query);
    if (!(result is Map)) {
      List<dynamic> dataList = result;
      if (dataList.length > 0) {
        List<MedModel> users = dataList.map((e) => MedModel.fromJson(e)).toList();
        yield BatchMEDFetchedState(users: users);
      } else {
        yield BatchMEDFetchedState(users: null);
      }
    } else {
      yield BatchErrorState(code: result['status_code'], message: result['message']);
    }
  }

  Stream<BatchState> _mapBatchPrdSearchEventToState(BatchPrdSearchEvent event) async* {
    yield BatchLoadingState();
    final result = await Api.searchProject(event.query);
    if (!(result is Map)) {
      List<dynamic> dataList = result;
      if (dataList.length > 0) {
        List<BatchProjectModel> projects = dataList.map((e) => BatchProjectModel.fromJson(e)).toList();
        yield BatchPRDFetchedState(projects: projects);
      } else {
        yield BatchPRDFetchedState(projects: null);
      }
    } else {
      yield BatchErrorState(code: result['status_code'], message: result['message']);
    }
  }

  Stream<BatchState> _mapBatchUpdateEventToState(BatchUpdateEvent event) async* {
    yield BatchLoadingState();
    final result = await Api.updateBatchItems(event.nodeDetails, event.projectID, event.uid);

    if (result["status"] == "UPDATE-Success") {
      yield BatchUpdatedState();
    } else {
      yield BatchErrorState(code: result['status_code'], message: result['message']);
    }
  }
}