import java.util.Properties

plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("dev.flutter.flutter-gradle-plugin")
}

fun localProperties(key: String, file: File = rootProject.file("local.properties")): String {
    return if (file.exists()) {
        val properties = Properties()
        file.inputStream().use { properties.load(it) }
        properties.getProperty(key) ?: ""
    } else {
        ""
    }
}

android {
    namespace = "com.example.grateful_app"
    compileSdk = 35 // Updated from 34 to 35

    ndkVersion = "27.0.12077973"

    compileOptions {
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = "1.8"
    }

    sourceSets {
        getByName("main").java.srcDirs("src/main/kotlin")
    }

    defaultConfig {
        applicationId = "com.example.grateful_app"
        minSdk = 21
        targetSdk = 34 // You can keep this at 34 or update to 35
        versionCode = localProperties("flutter.versionCode").takeIf { it.isNotEmpty() }?.toInt() ?: 1
        versionName = localProperties("flutter.versionName").takeIf { it.isNotEmpty() } ?: "1.0"
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Updated desugar_jdk_libs version from 2.0.4 to 2.1.4
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}