plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.ders_app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    defaultConfig {
        applicationId = "com.example.ders_app"
        minSdk = 23
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

// Burada dependencies bloğu doğru yerde, android bloğunun dışında
dependencies {
    // core library desugaring için ekleme
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")
    
    // Flutter projesinde genelde ek kütüphane yoksa bu blok boş olabilir
    // Başka bağımlılıklar varsa buraya ekle
}

flutter {
    source = "../.."
}
