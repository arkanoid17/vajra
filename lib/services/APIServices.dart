class APIServices {
  static const String login = 'employee/mobile/login/';
  static const String userHierarchy = 'salesman/user-hierarchy/';
  static const String userData = 'salesman/get_user_data/';
  static const String products = 'get_products/';
  static const String schemeServices = 'salesman/common-schemes/';
  static const String channelServices = 'salesman/common-schemes/';
  static const String placeServices = 'place/?page_size=10000';
  static const String tasksServices = 'process/user-tasks/';
  static const String activityService = 'salesman/activities/';
  static const String userStatsService = 'salesman/get_user_stats/';
  static const String storeTypesService = 'get_outlet_types/';
  static const String dynamicUserActionsService = 'salesman/dynamic-action/user-actions/';


  static String getTaskService(String? status,int? page,String? storeId,bool? fetchActivity){
    String path = tasksServices;
    String queries = '';
    if(status != null){
      queries = '$queries&status=$status';
    }
    if(page != null){
      queries = '$queries&page=$page';
    }
    if(storeId != null){
      queries = '$queries&storeId=$storeId';
    }
    if(fetchActivity != null){
      queries = '$queries&fetch_activity=$fetchActivity';
    }

    return '$path$queries';
  }

  static String getChannelServices(int? pageSize,int? page,String? search,int? orgNode){
    String path = channelServices;
    String queries = '';
    if(pageSize != null){
      queries = '$queries&page_size=$pageSize';
    }
    if(page != null){
      queries = '$queries&page=$page';
    }
    if(search != null){
      queries = '$queries&search=$search';
    }
    if(orgNode != null){
      queries = '$queries&org_node=$orgNode';
    }

    if(queries.isNotEmpty){
      queries.replaceFirst('&', '?');
    }

    return '$path$queries';
  }
}
