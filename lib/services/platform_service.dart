import 'package:flutter/services.dart';

class PlatformService {
  static const MethodChannel _channel =
      MethodChannel('com.example.pokedexapp/platform');

  Future<String> getPlatformVersion() async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
