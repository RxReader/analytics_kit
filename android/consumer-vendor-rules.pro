# 百度

-keep class com.baidu.bottom.** { *; }
-keep class com.baidu.mobstat.** { *; }

# msa

-keep class com.bun.** {*;}
-keep class com.asus.msa.** {*;}
-keep class com.heytap.openid.** {*;}
-keep class com.huawei.android.hms.pps.** {*;}
-keep class com.huawei.hms.ads.** {*; }
-keep interface com.huawei.hms.ads.** {*; }
-keep class com.meizu.flyme.openidsdk.** {*;}
-keep class com.samsung.android.deviceidservice.** {*;}
-keep class com.zui.** {*;}

-keepattributes *Annotation*
-keep @android.support.annotation.Keep class **{
    @android.support.annotation.Keep <fields>;
    @android.support.annotation.Keep <methods>;
}
