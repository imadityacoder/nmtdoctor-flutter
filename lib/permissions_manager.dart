import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  // Request multiple permissions
  Future<bool> requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.locationWhenInUse,
      Permission.camera,
      Permission.storage,
    ].request();

    // Check if all permissions are granted
    return statuses.values.every((status) => status.isGranted);
  }

  // Check individual permissions
  Future<bool> checkPermission(Permission permission) async {
    return await permission.status.isGranted;
  }
}
