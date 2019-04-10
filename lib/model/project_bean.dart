import 'package:json_annotation/json_annotation.dart';

part 'project_bean.g.dart';

///项目实体
@JsonSerializable()
class ProjectBean {
  @JsonKey(name: 'data')
  List<ProjectData> data;

  @JsonKey(name: 'errorCode')
  int errorCode;

  @JsonKey(name: 'errorMsg')
  String errorMsg;

  ProjectBean(
    this.data,
    this.errorCode,
    this.errorMsg,
  );

  factory ProjectBean.fromJson(Map<String, dynamic> srcJson) =>
      _$ProjectBeanFromJson(srcJson);
}

@JsonSerializable()
class ProjectData {
  @JsonKey(name: 'children')
  List<dynamic> children;

  @JsonKey(name: 'courseId')
  int courseId;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'order')
  int order;

  @JsonKey(name: 'parentChapterId')
  int parentChapterId;

  @JsonKey(name: 'userControlSetTop')
  bool userControlSetTop;

  @JsonKey(name: 'visible')
  int visible;

  ProjectData(
    this.children,
    this.courseId,
    this.id,
    this.name,
    this.order,
    this.parentChapterId,
    this.userControlSetTop,
    this.visible,
  );

  factory ProjectData.fromJson(Map<String, dynamic> srcJson) =>
      _$ProjectDataFromJson(srcJson);
}
