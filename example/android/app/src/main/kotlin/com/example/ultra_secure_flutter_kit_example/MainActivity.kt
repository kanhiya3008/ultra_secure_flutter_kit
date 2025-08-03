package com.example.ultra_secure_flutter_kit_example

import io.flutter.embedding.android.FlutterActivity
import android.os.Bundle
import com.example.ultra_secure_flutter_kit.UltraSecureFlutterKitPlugin

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // Set the current activity reference for the plugin
        UltraSecureFlutterKitPlugin.setCurrentActivity(this)
    }
    
    override fun onDestroy() {
        super.onDestroy()
        // Clear the activity reference
        UltraSecureFlutterKitPlugin.setCurrentActivity(null)
    }
}
