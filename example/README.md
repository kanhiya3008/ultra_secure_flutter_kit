# Ultra Secure Flutter Kit - Example App

This example app demonstrates all the security features available in the Ultra Secure Flutter Kit plugin.

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>=3.3.0)
- Dart SDK (>=3.8.1)
- Android Studio / VS Code
- Android device/emulator or iOS device/simulator

### Installation

1. Clone the repository:
```bash
git clone https://github.com/kanhiya3008/ultra_secure_flutter_kit.git
cd ultra_secure_flutter_kit
```

2. Install dependencies:
```bash
flutter pub get
cd example
flutter pub get
```

3. Run the example app:
```bash
flutter run
```

## 📱 Features Demonstrated

### 1. Security Status Dashboard
- Real-time security status display
- Risk score calculation
- Device security assessment
- Security metrics overview

### 2. Device Security Tests
- **Root Detection Test** - Check if device is rooted
- **Jailbreak Detection Test** - Check if device is jailbroken
- **Emulator Detection Test** - Check if running on emulator
- **Debugger Detection Test** - Check if debugger is attached
- **Proxy Detection Test** - Check for proxy settings
- **VPN Detection Test** - Check for VPN connections
- **Developer Mode Detection** - Check if developer options are enabled

### 3. Screenshot Blocking Control
- Enable/disable screenshot blocking
- Real-time status display
- Dynamic protection control

### 4. Security Actions
- **Secure API Call** - Make protected API requests
- **Secure Storage** - Store and retrieve encrypted data
- **Device Security Checks** - Comprehensive device assessment
- **Behavior Monitoring** - Track user behavior patterns
- **Data Sanitization** - Clean malicious input
- **Secure Random Generation** - Generate secure random data

### 5. Comprehensive Security Testing
- **Complete Device Security Test** - Run all security checks at once
- **Individual Security Tests** - Test each feature separately
- **Security Report Generation** - Detailed security assessment

## 🔧 Configuration

The example app uses a comprehensive security configuration:

```dart
final config = SecurityConfig(
  mode: SecurityMode.strict,
  blockOnHighRisk: true,
  enableScreenshotBlocking: true,
  enableSSLPinning: true,
  enableSecureStorage: true,
  enableNetworkMonitoring: true,
  enableBehaviorMonitoring: true,
  enableBiometricAuth: true,
  enableCodeObfuscation: true,
  enableDebugPrintStripping: true,
  enablePlatformChannelHardening: true,
  enableMITMDetection: true,
  enableInstallationSourceVerification: true,
  enableDeveloperModeDetection: true,
  // ... additional configuration
);
```

## 🧪 Testing Scenarios

### 1. Basic Security Check
1. Launch the app
2. Wait for security initialization
3. Check the security status dashboard
4. Review device security assessment

### 2. Screenshot Blocking Test
1. Navigate to "Screenshot Blocking Control"
2. Enable screenshot blocking
3. Try to take a screenshot (should be blocked)
4. Disable screenshot blocking
5. Try to take a screenshot (should work)

### 3. Device Security Test
1. Navigate to "Device Security Test"
2. Run "Complete Device Security Test"
3. Review the security report
4. Run "Individual Security Tests"
5. Check each test result

### 4. Secure Storage Test
1. Navigate to "Security Actions"
2. Tap "Secure Storage"
3. Verify data is stored and retrieved correctly
4. Check encryption/decryption functionality

### 5. Developer Mode Test (Android)
1. Enable Developer Options on your Android device
2. Run the app and check if Developer Mode is detected
3. Use the "Fix" button to open Developer Options settings
4. Disable Developer Options and verify detection

## 📊 Understanding Results

### Security Status Colors
- 🟢 **Green** - Secure/Not detected
- 🔴 **Red** - Security threat detected
- 🟠 **Orange** - Warning/Medium risk

### Risk Score
- **0-30%** - Low risk
- **31-60%** - Medium risk
- **61-100%** - High risk

### Threat Levels
- **Low** - Informational threat
- **Medium** - Warning threat
- **High** - Critical threat
- **Critical** - Immediate action required

## 🔍 Debugging

### Common Issues

1. **Plugin not found errors**
   - Run `flutter clean` and `flutter pub get`
   - Rebuild the app

2. **Permission errors**
   - Check Android/iOS permissions in configuration
   - Ensure proper manifest entries

3. **Security features not working**
   - Verify device compatibility
   - Check security configuration
   - Review platform-specific setup

### Logs
Enable debug logging to see detailed security events:
```dart
// Add to your app for debugging
import 'dart:developer' as developer;
developer.log('Security event: $event', name: 'UltraSecureFlutterKit');
```

## 📱 Platform-Specific Notes

### Android
- Requires minimum API level 21
- Some features require specific permissions
- Developer mode detection works on Android 4.2+
- Biometric authentication requires fingerprint sensor

### iOS
- Requires iOS 9.0 or later
- Face ID/Touch ID support for biometric authentication
- Jailbreak detection covers common jailbreak methods
- Some features may be limited on iOS Simulator

## 🤝 Contributing

To contribute to the example app:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## 📄 License

This example app is part of the Ultra Secure Flutter Kit project and is licensed under the MIT License.

## 🆘 Support

For help with the example app:
- Check the [main documentation](https://github.com/kanhiya3008/ultra_secure_flutter_kit#readme)
- Open an [issue](https://github.com/kanhiya3008/ultra_secure_flutter_kit/issues)
- Contact support at support@ultrasecureflutterkit.com
