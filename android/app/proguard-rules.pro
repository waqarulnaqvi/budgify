##############################################
# FLUTTER
##############################################

# Keep Flutter embedding and engine classes
-keep class io.flutter.** { *; }
-dontwarn io.flutter.**


##############################################
# ANDROIDX / MATERIAL
##############################################

# AndroidX Core
-keep class androidx.core.** { *; }
-dontwarn androidx.core.**

# AndroidX Media3
-keep class androidx.media3.** { *; }
-dontwarn androidx.media3.**

# Material Components
-keep class com.google.android.material.** { *; }
-dontwarn com.google.android.material.**


##############################################
# FIREBASE
##############################################

# Firebase
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**


##############################################
# FLUTTER DEFERRED COMPONENTS
##############################################

-keep class io.flutter.embedding.engine.deferredcomponents.** { *; }
-dontwarn io.flutter.embedding.engine.deferredcomponents.**


##############################################
# GSON / JSON (IF USED)
##############################################

# Uncomment these only if your project uses Gson
# -keep class com.google.gson.** { *; }
# -keepattributes Signature
# -keepattributes *Annotation*


##############################################
# GENERAL R8 ATTRIBUTES
##############################################

-keepattributes *Annotation*
-keepattributes Signature
-keepattributes InnerClasses
-keepattributes EnclosingMethod