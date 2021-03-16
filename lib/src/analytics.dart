import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

///
class Analytics {
  const Analytics._();

  static const MethodChannel _channel = MethodChannel('v7lin.github.io/analytics_kit');

  ///
  static Future<void> init({
    @required String appKey,
    String channelId,
    bool debugEnabled = false,
  }) {
    assert(appKey?.isNotEmpty ?? false);
    return _channel.invokeMethod<void>('init', <String, dynamic>{
      'app_key': appKey,
      if (channelId?.isNotEmpty ?? false) 'channel_id': channelId,
      'debug_enabled': debugEnabled,
    });
  }

  ///
  static Future<String> getTestDeviceId() {
    return _channel.invokeMethod<String>('getTestDeviceId');
  }

  ///
  static Future<void> startPageTracking({@required String pageName}) {
    assert(pageName?.isNotEmpty ?? false);
    return _channel.invokeMethod<void>('startPageTracking', <String, dynamic>{
      'page_name': pageName,
    });
  }

  ///
  static Future<void> stopPageTracking({@required String pageName}) {
    assert(pageName?.isNotEmpty ?? false);
    return _channel.invokeMethod<void>('stopPageTracking', <String, dynamic>{
      'page_name': pageName,
    });
  }

  ///
  static Future<void> trackEvent({
    @required String eventId,
    String eventLabel,
    Map<String, String > eventParams,
  }) {
    assert(eventId?.isNotEmpty ?? false);
    return _channel.invokeMethod<void>('trackEvent', <String, dynamic>{
      'event_id': eventId,
      if (eventLabel?.isNotEmpty ?? false) 'event_label': eventLabel,
      if (eventParams?.isNotEmpty ?? false) 'event_params': eventParams,
    });
  }
}
