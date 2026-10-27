import java.util.Properties

plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// Release signing. android/key.properties and the keystore it names are
// git-ignored and never leave the machine that builds releases.
val keystoreProperties: Properties? =
    rootProject.file("key.properties").takeIf { it.exists() }?.let { f ->
        Properties().apply { f.inputStream().use { load(it) } }
    }

android {
    namespace = "uz.transkriptor.transkriptor_uz"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "uz.transkriptor.transkriptor_uz"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        // Uses the version code from pubspec.yaml. When using split APKs, 1000 * ABI_VERSION
        // is added automatically by Flutter. (https://developer.android.com/studio/build/configure-apk-splits#configure-APK-versions)
        // You can force using the value of versionCode by specifying the `-P force-version-code-ignoring-abi=true`
        // flag during build.
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        keystoreProperties?.let { props ->
            create("release") {
                keyAlias = props.getProperty("keyAlias")
                keyPassword = props.getProperty("keyPassword")
                storeFile = file(props.getProperty("storeFile"))
                storePassword = props.getProperty("storePassword")
            }
        }
    }

    buildTypes {
        release {
            // Never the debug key: an APK signed with it cannot be updated
            // by one signed with the real key later, so every install would
            // have to be removed first. Without key.properties the release
            // build stops instead (see the taskGraph check below).
            signingConfig = signingConfigs.findByName("release")
        }
    }
}

// Fails only release builds; debug and profile need no keystore.
gradle.taskGraph.whenReady {
    val wantsRelease = allTasks.any { task ->
        task.project == project && task.name.contains("Release")
    }
    if (wantsRelease && keystoreProperties == null) {
        throw GradleException(
            "android/key.properties is missing: a release build must be " +
                "signed with the upload keystore (README §4.2).",
        )
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}
