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
  static const String dynamicActionListService = 'salesman/dynamic-action/list-page/';
  static const String reasonService = 'extra-data/';
  static const String storeService = 'salesman/territory_stores/';
  static const String pricingListService = 'portal/api/pricing-list/';
  static const String salesHistoryService = 'portal/api/sales/history/';
  static const String nearbyStoreService = 'salesman/nearby_stores/';
  static const String myReportService = 'reports/my_report/';

  static String getMyReportService(String? fromDate,String? toDate){
    String path = myReportService;
    String queries = '';

    if(fromDate!=null){
      queries = '$queries${getSeperator(queries)}from_date=$fromDate';
    }

    if(toDate!=null){
      queries = '$queries${getSeperator(queries)}to_date=$toDate';
    }

    return '$path$queries';
  }

  static String getNearbyStoresService(double? latitude,double? longitude,int? limit,int? radius){
    String path = nearbyStoreService;
    String queries = '';

    if(latitude!=null){
      queries = '$queries${getSeperator(queries)}latitude=$latitude';
    }
    if(longitude!=null){
      queries = '$queries${getSeperator(queries)}longitude=$longitude';
    }
    if(limit!=null){
      queries = '$queries${getSeperator(queries)}limit=$limit';
    }
    if(radius!=null){
      queries = '$queries${getSeperator(queries)}radius=$radius';
    }

    return '$path$queries';
  }

  static String getSalesHistoryService(String? series,String? fromDate,String? toDate,String? salesman,String? includeFields1,String? includeFields2,String? includeFields3){
    String path = salesHistoryService;
    String queries = '';
    if(series!=null){
      queries = '$queries${getSeperator(queries)}series=$series';
    }
    if(fromDate!=null){
      queries = '$queries${getSeperator(queries)}from_date=$fromDate';
    }
    if(toDate!=null){
      queries = '$queries${getSeperator(queries)}to_date=$toDate';
    }
    if(salesman!=null){
      queries = '$queries${getSeperator(queries)}salesman=$salesman';
    }
    if(includeFields1!=null){
      queries = '$queries${getSeperator(queries)}include_fields=$includeFields1';
    }
    if(includeFields2!=null){
      queries = '$queries${getSeperator(queries)}include_fields=$includeFields2';
    }
    if(includeFields3!=null){
      queries = '$queries${getSeperator(queries)}include_fields=$includeFields3';
    }

    return '$path$queries';
  }

  static String getPricingListService(bool? includeProducts, bool? noPage, List<int>? pricingIds){
    String path = pricingListService;
    String queries = '';
    if(includeProducts!=null){
      queries = '$queries${getSeperator(queries)}include_products=$includeProducts';
    }
    if(noPage!=null){
      queries = '$queries${getSeperator(queries)}no_page=$noPage';
    }
    if(pricingIds!=null){
      for(int id in pricingIds) {
        queries = '$queries${getSeperator(queries)}pricing=$id';
      }
    }

    

    return '$path$queries';
  }

  static String getStoreService(int? salesmanId){
    String path = storeService;
    String queries = '';
    if(salesmanId != null){
      queries = '$queries${getSeperator(queries)}salesman_id=$salesmanId';
    }
    

    return '$path$queries';
  }

  static String getReasonsService(String? groupName){
    String path = reasonService;
    String queries = '';
    if(groupName != null){
      queries = '$queries${getSeperator(queries)}group_name=$groupName';
    }
    

    return '$path$queries';
  }

  static String getTaskService(String? status,int? page,String? storeId,bool? fetchActivity){
    String path = tasksServices;
    String queries = '';
    if(status != null){
      queries = '$queries${getSeperator(queries)}status=$status';
    }
    if(page != null){
      queries = '$queries${getSeperator(queries)}page=$page';
    }
    if(storeId != null){
      queries = '$queries${getSeperator(queries)}storeId=$storeId';
    }
    if(fetchActivity != null){
      queries = '$queries${getSeperator(queries)}fetch_activity=$fetchActivity';
    }
    

    return '$path$queries';
  }

  static String getChannelServices(int? pageSize,int? page,String? search,int? orgNode){
    String path = channelServices;
    String queries = '';
    if(pageSize != null){
      queries = '$queries${getSeperator(queries)}page_size=$pageSize';
    }
    if(page != null){
      queries = '$queries${getSeperator(queries)}page=$page';
    }
    if(search != null){
      queries = '$queries${getSeperator(queries)}search=$search';
    }
    if(orgNode != null){
      queries = '$queries${getSeperator(queries)}org_node=$orgNode';
    }

    

    return '$path$queries';
  }

  static String getSeperator(String queries){
    return queries.isEmpty?'?':'&';
  }

}
