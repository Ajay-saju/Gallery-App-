import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

Directory? directory;

Future<bool> requstPermission() async {
  var storagePermission = Permission.manageExternalStorage.status;
  var mediaPermission = Permission.accessMediaLocation.status;

  if (await storagePermission.isGranted && await mediaPermission.isGranted) {
    return true;
  } else {
    var storagePermissionReq = await Permission.manageExternalStorage.request();
    var mediaPermissionReq = await Permission.accessMediaLocation.request();
    if (storagePermissionReq == PermissionStatus.granted &&
        mediaPermissionReq == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }
}

Future<bool> createPath() async {
  print('Create path called');
  if (await requstPermission()) {
    directory = await getExternalStorageDirectory();
    String newPath = '';
    List<String> folders = directory!.path.split("/");
    for (var i = 1; i < folders.length; i++) {
      String folder = folders[i];
      if (folder != 'Android') {
        newPath += "/" + folder;
        print('folder Created ');
      } else {
        break;
      }
    }

    newPath = newPath + "/My Gallery";
    print(newPath);
    directory = (Directory(newPath));
    if (!await directory!.exists()) {
      await directory!.create(recursive: true);
    }
    return true;
  } else {
    return false;
  }
}
