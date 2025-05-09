# ===== Flutter =====
-keep class io.flutter.** { *; }
-dontwarn io.flutter.**

# ===== Dio & Network (Retrofit-style) =====
-keep class okhttp3.** { *; }
-dontwarn okhttp3.**
-keep class okio.** { *; }
-dontwarn okio.**

# Jika menggunakan JSON serializable atau Gson:
-keep class com.google.gson.** { *; }
-dontwarn com.google.gson.**

# ===== Firebase =====
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.android.gms.**
-keepattributes SourceFile,LineNumberTable,*Annotation*
-keep class com.google.firebase.crashlytics.** { *; }
-dontwarn com.google.firebase.crashlytics.**

# ===== Google Maps =====
-keep class com.google.android.gms.maps.** { *; }
-dontwarn com.google.android.gms.maps.**

# ===== Geolocation & Geocoding =====
-dontwarn com.google.android.gms.location.**
-keep class com.google.android.gms.location.** { *; }

# ===== Secure Storage (uses Keystore) =====
-dontwarn androidx.security.**

# ===== Image Picker, File Picker, Path Provider =====
-dontwarn androidx.core.content.FileProvider
-keep class androidx.core.content.FileProvider { *; }

# ===== WebView =====
-keepclassmembers class * {
    @android.webkit.JavascriptInterface <methods>;
}
-keep public class * extends android.webkit.WebViewClient
-keep public class * extends android.webkit.WebChromeClient

# ===== Flutter Plugins General =====
-keep public class * extends android.app.Service
-keep public class * extends android.content.BroadcastReceiver
-keep public class * extends android.app.Activity
-keep public class * extends android.content.ContentProvider

# ===== Local Notifications =====
-keep class com.dexterous.flutterlocalnotifications.** { *; }

# ===== GetX (Minimal Rules) =====
-keep class ** extends GetxController
-keep class ** extends Bindings
-keep class ** extends GetView
-dontwarn **.GetxController

# ===== Lottie Animation =====
-keep class com.airbnb.lottie.** { *; }
-dontwarn com.airbnb.lottie.**

# ===== Barcode, PDF, Printing =====
-keep class com.itextpdf.** { *; }
-dontwarn com.itextpdf.**
-dontwarn org.apache.pdfbox.**

# ===== Shared Libraries & Debug Info =====
-keepclassmembers class * {
    native <methods>;
}
-keepattributes InnerClasses, EnclosingMethod

# ===== Optional: Logging (logger) =====
-dontwarn org.slf4j.**

# ===== OPTIONAL: For reflection-heavy libs =====
# Only if reflection is heavily used in some plugins (e.g., JSON serializable or dynamic map objects)
-keepclassmembers class * {
    *;
}
