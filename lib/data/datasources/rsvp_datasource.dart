import 'package:wedding_web/config/app_config.dart';
import 'package:wedding_web/data/datasources/google_apps_script_client.dart';

abstract class RSVPDataSource {
  Future<void> submitRSVP(Map<String, dynamic> data);
}

class RSVPDataSourceImpl implements RSVPDataSource {
  @override
  Future<void> submitRSVP(Map<String, dynamic> data) async {
    final dataWithTimestamp = {
      ...data,
      'timestamp': DateTime.now().toIso8601String(),
    };

    await GoogleAppsScriptClient.submitViaHiddenForm(
      url: AppConfig.scriptUrl,
      data: dataWithTimestamp,
      label: 'RSVP',
    );
  }
}
