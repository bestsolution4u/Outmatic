import 'package:outmatic/api/http_manager.dart';
import 'package:outmatic/config/application.dart';

class Api {
  static Future<dynamic> login(params) async {
    return await httpManager.post(url: "userlogin", data: params);
  }

  static Future<dynamic> getProjects(page) async {
    return await httpManager.post(url: "projecten_list?page=$page", data: {"api_token": Application.user.apiToken});
  }

  static Future<dynamic> searchProjects(query) async {
    return await httpManager.post(url: "projectsearch", data: {"api_token": Application.user.apiToken, "projectID": query});
  }

  static Future<dynamic> getItems(page) async {
    return await httpManager.post(url: "jansma_artikel_listing", data: {"api_token": Application.user.apiToken, "page": page});
  }

  static Future<dynamic> getCountProjectItems(projectID) async {
    return await httpManager.post(url: "projectitems", data: {"api_token": Application.user.apiToken, "projectID": projectID});
  }

  static Future<dynamic> getProjectItems(projectID, page) async {
    return await httpManager.post(url: "projectitemsartikels", data: {"api_token": Application.user.apiToken, "projectID": projectID, "page": page});
  }

  static Future<dynamic> getItemDetails(nodeTitle) async {
    return await httpManager.post(url: "jansma_project_item_details", data: {"api_token": Application.user.apiToken, "nodeTitle": nodeTitle});
  }

  static Future<dynamic> getItemsByTag(tagId) async {
    return await httpManager.post(url: "jansma_batchscan_item", data: {"api_token": Application.user.apiToken, "rfid": tagId});
  }

  static Future<dynamic> getItemListByTag(tagId) async {
    return await httpManager.post(url: "jansma_batchscan_item_list", data: {"api_token": Application.user.apiToken, "rfid": tagId});
  }

  static Future<dynamic> assignTagToItem(title, rfid) async {
    return await httpManager.post(url: "jansma_assign_rfid", data: {"api_token": Application.user.apiToken, "rfid": rfid, "title": title});
  }

  static Future<dynamic> updateVCAItems(nodeTitle) async {
    return await httpManager.post(url: "jansma_vca_item_update", data: {"api_token": Application.user.apiToken, "nodeTitle": nodeTitle});
  }

  static Future<dynamic> searchUser(search) async {
    return await httpManager.post(url: "jansma_user_search", data: {"api_token": Application.user.apiToken, "uname": search});
  }

  static Future<dynamic> searchProject(search) async {
    return await httpManager.post(url: "projectsearch", data: {"api_token": Application.user.apiToken, "projectID": search});
  }

  static Future<dynamic> updateReturnItems(nodeTitle) async {
    return await httpManager.post(url: "jansma_return_item_update", data: {"api_token": Application.user.apiToken, "nodeTitle": nodeTitle, "logged_uid": Application.user.id});
  }

  static Future<dynamic> updateBatchItems(nodeDetails, projectID, uid) async {
    return await httpManager.post(url: "jansma_batchscan_update", data: {"api_token": Application.user.apiToken, "node_details": nodeDetails, "projectID": projectID, "uid": uid, "logged_uid": Application.user.id});
  }
}