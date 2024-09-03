import 'package:hive/hive.dart';
import 'package:vajra_test/features/sync/model/models/userhierarchy/user_hierarchy.dart';
import 'package:vajra_test/features/sync/model/models/userhierarchy/user_hierarchy_beats.dart';
import 'package:vajra_test/features/sync/model/models/userhierarchy/user_hierarchy_beats_calendar.dart';
import 'package:vajra_test/init_dependencies.dart';
import 'package:vajra_test/cores/utils/date_utils.dart' as dateUtils;

class UserHierarchyLocalRepository {
  Box<UserHierarchy> hierarchyBox = serviceLocator();

  void addAllUsers(List<UserHierarchy> users) async {
    final val = await hierarchyBox.clear();

    Map<String, UserHierarchy> map = {};

    for (int i = 0; i < users.length; i++) {
      map[i.toString()] = users[i];
    }

    hierarchyBox.putAll(map);
  }

  UserHierarchy getUser(int salesmanId) {
    UserHierarchy? user;
    Box<UserHierarchy> hierarchyBox = serviceLocator();
    for (int i = 0; i < hierarchyBox.length; i++) {
      if (hierarchyBox.get(i.toString())!.id! == salesmanId) {
        user = hierarchyBox.get(i.toString())!;
        break;
      }
    }

    return user!;
  }

  List<UserHierarchyBeats> getUserBeats(int salesmanId) {
    UserHierarchy user = getUser(salesmanId);
    return user.beats ?? [];
  }

  List<UserHierarchyBeats> filterBeatsByDateAndUser(
      String date, int salesmanId) {
    List<UserHierarchyBeats> selectedBeats = [];

    List<UserHierarchyBeats> userBeats =
        UserHierarchyLocalRepository().getUserBeats(salesmanId);
    int weekOfMonth = dateUtils.DateUtils.getWeekOfMonth(date);
    String dayOfWeek = dateUtils.DateUtils.getDayOfWeek(date);

    for (UserHierarchyBeats beat in userBeats) {
      for (UserHierarchyBeatCalendar calendar in beat.calendar ?? []) {
        if (calendar.dayName!.toLowerCase() == dayOfWeek.toLowerCase() &&
            calendar.weekNo == weekOfMonth) {
          selectedBeats.add(beat);
        }
      }
    }

    return selectedBeats;
  }
}
