import 'package:hive/hive.dart';
part 'gallery_model.g.dart';

@HiveType(typeId: 0)
class Gallery_Model extends HiveObject {
  @HiveField(0)
late  String photo;

  Gallery_Model({required this.photo});
}
