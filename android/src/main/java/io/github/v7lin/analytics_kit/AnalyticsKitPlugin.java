package io.github.v7lin.analytics_kit;

import android.content.Context;

import androidx.annotation.NonNull;

import com.baidu.mobstat.StatService;

import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/**
 * AnalyticsKitPlugin
 */
public class AnalyticsKitPlugin implements FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private MethodChannel channel;
    private Context applicationContext;

    // --- FlutterPlugin

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        channel = new MethodChannel(binding.getBinaryMessenger(), "v7lin.github.io/analytics_kit");
        channel.setMethodCallHandler(this);
        applicationContext = binding.getApplicationContext();
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
        applicationContext = null;
    }

    // --- MethodCallHandler

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        if ("init".equals(call.method)) {
            String appKey = call.argument("app_key");
            String channelId = call.argument("channel_id");
            boolean debugEnabled = call.argument("debug_enabled");
            StatService.setDebugOn(debugEnabled);
            StatService.setAppKey(appKey);
            StatService.setAppChannel(applicationContext, channelId, false);
            StatService.setOn(applicationContext, StatService.JAVA_EXCEPTION_LOG);
            StatService.enableDeviceMac(applicationContext, true);
            StatService.setAuthorizedState(applicationContext, false);
            StatService.start(applicationContext);
            result.success(null);
        } else if ("setOaid".equals(call.method)) {
            String oaid = call.argument("oaid");
            StatService.setOaid(applicationContext, oaid);
            result.success(null);
        } else if ("setAuthorizedState".equals(call.method)) {
            boolean enabled = call.argument("enabled");
            StatService.setAuthorizedState(applicationContext, enabled);
            result.success(null);
        } else if ("getTestDeviceId".equals(call.method)) {
            result.success(StatService.getTestDeviceId(applicationContext));
        } else if ("startPageTracking".equals(call.method)) {
            String pageName = call.argument("page_name");
            StatService.onPageStart(applicationContext, pageName);
            result.success(null);
        } else if ("stopPageTracking".equals(call.method)) {
            String pageName = call.argument("page_name");
            StatService.onPageEnd(applicationContext, pageName);
            result.success(null);
        } else if ("trackEvent".equals(call.method)) {
            String eventId = call.argument("event_id");
            Map<String, String> eventParams = call.argument("event_params");
            StatService.onEvent(applicationContext, eventId, null, 1, eventParams);
            result.success(null);
        } else {
            result.notImplemented();
        }
    }
}
