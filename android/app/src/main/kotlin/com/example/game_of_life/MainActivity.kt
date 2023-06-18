package com.example.game_of_life

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import com.yandex.mapkit.MapKitFactory

/*
class MainActivity: FlutterActivity() {
    MapKitFactory.setApiKey("cec3e781-ac9e-4688-8122-88e997234b06")
}
*/
class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        // MapKitFactory.setLocale("YOUR_LOCALE") // Your preferred language. Not required, defaults to system language
        MapKitFactory.setApiKey("cec3e781-ac9e-4688-8122-88e997234b06") // Your generated API key
        super.configureFlutterEngine(flutterEngine)
    }
}
