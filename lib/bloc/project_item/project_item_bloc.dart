import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outmatic/api/api.dart';
import 'package:outmatic/bloc/bloc.dart';
import 'package:outmatic/model/project_item_model.dart';

class ProjectItemBloc extends Bloc<ProjectItemEvent, ProjectItemState> {
  ProjectItemBloc() : super(ProjectItemInitialState());

  @override
  Stream<ProjectItemState> mapEventToState(ProjectItemEvent event) async* {
    if (event is ProjectItemCountEvent) {
      yield* _mapProjectItemCountEventToState(event);
    } else if (event is ProjectItemFetchEvent) {
      yield* _mapProjectItemFetchEventToState(event);
    }
  }

  Stream<ProjectItemState> _mapProjectItemCountEventToState(ProjectItemCountEvent event) async* {
    final result = await Api.getCountProjectItems(event.projectID);
    if (!(result is Map)) {
      List<dynamic> dataList = result;
      if (dataList.length > 0) {
        int total = dataList[0]['item_list_counter'];
        yield ProjectItemCountState(count: total);
      } else {
        yield ProjectItemCountState(count: 0);
      }
    } else {
      yield ProjectItemErrorState(code: result['status_code'], message: result['message']);
    }
  }

  Stream<ProjectItemState> _mapProjectItemFetchEventToState(ProjectItemFetchEvent event) async* {
    yield ProjectItemLoadingState();
    final result = await Api.getProjectItems(event.projectID, event.page);
    if (!(result is Map)) {
      List<dynamic> dataList = result;
      if (dataList.length > 0) {
        List<ProjectItemModel> items = dataList.map((e) => ProjectItemModel.fromJson(e)).toList();
        yield ProjectItemFetchedState(items: items);
      } else {
        yield ProjectItemFetchedState(items: []);
      }
    } else {
      yield ProjectItemErrorState(code: result['status_code'], message: result['message']);
    }
  }

}