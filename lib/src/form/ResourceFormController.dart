import 'package:softi_common/core.dart';
import 'package:softi_common/resource.dart';
import 'package:softi_common/src/form/FormControllerMixin.dart';

abstract class ResourceFormController<T extends IResourceData> extends BaseViewController with FormControllerMixin<T> {
  final IResourceBase db;
  final T record;
  final bool refreshRecord;

  ResourceFormController(this.record, {required this.db, this.refreshRecord = true});

  T? _editingRecord;

  @override
  Future<void> onViewInit() async {
    if (refreshRecord && record.isValid()) {
      _editingRecord = (await db.api<T>().get(record.getId(), reactive: false).first);
    } else {
      _editingRecord = record;
    }

    initForm(_editingRecord);
  }

  @override
  Map<String, dynamic> buildInitialValue(T? record) => record?.toJson() ?? {};

  @override
  Future<T> beforSave(Map<String, dynamic> formData) async {
    var record = db.resource<T>().deserializer(formData);
    return await beforeResourceSave(record);
  }

  @override
  Future<void> afterSave(T record) async {
    var result = await db.api<T>().save(record);
    await afterResourceSave(result);
  }

  Future<T> beforeResourceSave(T record) async => record;
  Future<void> afterResourceSave(T? record);
}
