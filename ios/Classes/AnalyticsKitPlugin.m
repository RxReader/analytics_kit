#import "AnalyticsKitPlugin.h"
#import <BaiduMobStatCodeless/BaiduMobStat.h>

@implementation AnalyticsKitPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
    FlutterMethodChannel *channel = [FlutterMethodChannel
        methodChannelWithName:@"v7lin.github.io/analytics_kit"
              binaryMessenger:[registrar messenger]];
    AnalyticsKitPlugin *instance = [[AnalyticsKitPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    if ([@"init" isEqualToString:call.method]) {
        NSString *appKey = call.arguments[@"app_key"];
        NSString *channelId = call.arguments[@"channel_id"];
        NSNumber *debugEnabled = call.arguments[@"debug_enabled"];
        [[BaiduMobStat defaultStat] setEnableDebugOn:debugEnabled.boolValue];
        [[BaiduMobStat defaultStat] setChannelId:channelId];
        [[BaiduMobStat defaultStat] setEnableExceptionLog:YES];
        [[BaiduMobStat defaultStat] startWithAppId:appKey];
        result(nil);
    } else if ([@"setAdid" isEqualToString:call.method]) {
        NSString *adid = call.arguments[@"adid"];
        [[BaiduMobStat defaultStat] setAdid:adid];
        result(nil);
    } else if ([@"getTestDeviceId" isEqualToString:call.method]) {
        result([[BaiduMobStat defaultStat] getTestDeviceId]);
    } else if ([@"startPageTracking" isEqualToString:call.method]) {
        NSString *pageName = call.arguments[@"page_name"];
        [[BaiduMobStat defaultStat] pageviewStartWithName:pageName];
        result(nil);
    } else if ([@"stopPageTracking" isEqualToString:call.method]) {
        NSString *pageName = call.arguments[@"page_name"];
        [[BaiduMobStat defaultStat] pageviewEndWithName:pageName];
        result(nil);
    } else if ([@"trackEvent" isEqualToString:call.method]) {
        NSString *eventId = call.arguments[@"event_id"];
        NSDictionary *eventParams = call.arguments[@"event_params"];
        [[BaiduMobStat defaultStat] logEvent:eventId attributes:eventParams];
        result(nil);
    } else {
        result(FlutterMethodNotImplemented);
    }
}

@end
