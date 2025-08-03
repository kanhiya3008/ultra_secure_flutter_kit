package com.example.ultra_secure_flutter_kit_example

import io.flutter.embedding.android.FlutterActivity
import android.os.Bundle
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.hardware.usb.UsbManager
import android.util.Log
import com.example.ultra_secure_flutter_kit.UltraSecureFlutterKitPlugin

class MainActivity: FlutterActivity() {
    private lateinit var usbReceiver: BroadcastReceiver
    
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // Set the current activity reference for the plugin
        UltraSecureFlutterKitPlugin.setCurrentActivity(this)
        
        // Register USB connection receiver
        registerUsbReceiver()
    }
    
    override fun onDestroy() {
        super.onDestroy()
        // Clear the activity reference
        UltraSecureFlutterKitPlugin.setCurrentActivity(null)
        
        // Unregister USB receiver
        try {
            unregisterReceiver(usbReceiver)
        } catch (e: Exception) {
            Log.w("MainActivity", "Failed to unregister USB receiver: $e")
        }
    }
    
    private fun registerUsbReceiver() {
        usbReceiver = object : BroadcastReceiver() {
            override fun onReceive(context: Context?, intent: Intent?) {
                when (intent?.action) {
                    UsbManager.ACTION_USB_DEVICE_ATTACHED -> {
                        Log.i("MainActivity", "USB device attached")
                        // Notify the plugin about USB connection
                        UltraSecureFlutterKitPlugin.onUsbDeviceAttached()
                    }
                    UsbManager.ACTION_USB_DEVICE_DETACHED -> {
                        Log.i("MainActivity", "USB device detached")
                        // Notify the plugin about USB disconnection
                        UltraSecureFlutterKitPlugin.onUsbDeviceDetached()
                    }
                }
            }
        }
        
        val filter = IntentFilter().apply {
            addAction(UsbManager.ACTION_USB_DEVICE_ATTACHED)
            addAction(UsbManager.ACTION_USB_DEVICE_DETACHED)
        }
        
        registerReceiver(usbReceiver, filter)
    }
}
