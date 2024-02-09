import 'package:flutter_flavor/flutter_flavor.dart';

class AppConst {
  static final String baseUrl = FlavorConfig.instance.variables["base_url"];
  static final String tarifUrl = FlavorConfig.instance.variables['tarif_url'];
  static final String tracingUrl = FlavorConfig.instance.variables['tracing_url'];
  static final String referenceUrl = FlavorConfig.instance.variables['reference_url'];
}
