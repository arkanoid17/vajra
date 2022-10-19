import 'package:json_annotation/json_annotation.dart';
import 'package:vajra/models/pending_tasks_data/pending_task.dart';

import '../links/links.dart';
import '../pages/pages.dart';

part 'pending_task_response.g.dart';

@JsonSerializable()
class PendingTaskResponse{
  @JsonKey(name: 'page')
  Page? page;

  @JsonKey(name: 'links')
  Link? links;

  @JsonKey(name: 'results')
  List<PendingTask>? results;

  PendingTaskResponse(this.page, this.links, this.results);

  factory PendingTaskResponse.fromJson(Map<String, dynamic> json) => _$PendingTaskResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PendingTaskResponseToJson(this);
}