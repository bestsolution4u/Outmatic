import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outmatic/api/api.dart';
import 'package:outmatic/bloc/bloc.dart';
import 'package:outmatic/model/project_model.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {

  ProjectBloc() : super(ProjectInitialState());

  @override
  Stream<ProjectState> mapEventToState(ProjectEvent event) async* {
    if (event is ProjectFetchEvent) {
      yield* _mapProjectFetchEventToState(event);
    } else if (event is ProjectSearchEvent) {
      yield* _mapProjectSearchEventToState(event);
    }
  }

  Stream<ProjectState> _mapProjectFetchEventToState(ProjectFetchEvent event) async* {
    yield ProjectLoadingState();
    final result = await Api.getProjects(event.page);
    if (result['data'] != null) {
      List<dynamic> dataList = result['data'];
      List<ProjectModel> projects = dataList.map((e) => ProjectModel.fromJson(e)).toList();
      yield ProjectFetchedState(projects: projects, currentPage: result['current_page'], lastPage: result['last_page']);
    } else {
      yield ProjectErrorState(code: result['status_code'], message: result['message']);
    }
  }

  Stream<ProjectState> _mapProjectSearchEventToState(ProjectSearchEvent event) async* {
    yield ProjectLoadingState();
    final result = await Api.searchProject(event.query);
    if (!(result is Map)) {
      List<dynamic> dataList = result;
      if (dataList.length > 0) {
        List<ProjectModel> projects = dataList.map((e) => ProjectModel.fromJsonSearch(e)).toList();
        yield ProjectSearchResultState(projects: projects.where((element) => element != null && element.id.isNotEmpty).toList());
      } else {
        yield ProjectSearchResultState(projects: []);
      }
    } else {
      yield ProjectErrorState(code: result['status_code'], message: result['message']);
    }
  }
}