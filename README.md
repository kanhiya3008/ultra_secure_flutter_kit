# Ultra Secure Flutter Kit 🔐

A comprehensive Flutter security package providing enterprise-grade protection similar to secure_monitor. This plugin offers extensive security features to protect your Flutter applications from various threats and attacks.

## 🛡️ Security Features

### ✅ **IMPLEMENTED & AVAILABLE**

#### 1. **Device & Environment Security**
- ✅ **Root Detection (Android)** - Detects rooted devices and common root packages
- ✅ **Jailbreak Detection (iOS)** - Detects jailbroken devices and Cydia installations
- ✅ **Emulator Detection** - Identifies if app is running on emulator/simulator
- ✅ **Debugger Detection** - Detects USB debugging and debugger attachment
- ✅ **Screen Capture Protection** - Prevents screenshots and screen recording
- ✅ **Secure Flag Toggle** - Enables secure window flags
- ✅ **Developer Mode Detection** - Detects if developer options are enabled

#### 2. **App Tampering Detection**
- ✅ **Signature Verification** - Verifies app signature integrity
- ✅ **Integrity Checks** - Validates app checksums and hashes
- ✅ **Installation Source Verification** - Ensures app is from official stores

#### 3. **Secure Storage Layer**
- ✅ **AES-256 Encrypted Storage** - Secure data storage with encryption
- ✅ **Auto Encryption/Decryption** - Automatic handling of sensitive data
- ✅ **Biometric-Protected Vault** - Optional biometric authentication
- ✅ **Data Expiration** - Automatic data cleanup with TTL

#### 4. **Network Protection**
- ✅ **SSL Pinning** - Certificate pinning with fallback options
- ✅ **MITM Attack Detection** - Detects man-in-the-middle attacks
- ✅ **Proxy/VPN Detection** - Identifies network proxies and VPNs
- ✅ **Network Monitoring** - Real-time network security monitoring

#### 5. **Anti-Reverse Engineering**
- ✅ **Frida Detection** - Detects Frida framework usage
- ✅ **Xposed Detection** - Identifies Xposed framework
- ✅ **Debug Tool Detection** - Detects common reverse engineering tools
- ✅ **Code Obfuscation Helper** - Automatic code obfuscation configuration

#### 6. **AI-Enhanced Behavior Monitoring**
- ✅ **Abnormal Behavior Detection** - AI-powered threat detection
- ✅ **Device Risk Scoring** - Comprehensive risk assessment
- ✅ **Real-time Threat Detection** - Continuous security monitoring
- ✅ **Automated Response System** - Automatic threat response

#### 7. **Security Logs & Alerts**
- ✅ **Real-time Threat Streaming** - Live security event monitoring
- ✅ **Security Metrics** - Comprehensive security analytics
- ✅ **Threat Classification** - Categorized threat levels

#### 8. **Configurable Security Modes**
- ✅ **Strict Mode** - Maximum protection, blocks on any threat
- ✅ **Monitor Mode** - Logs threats but doesn't block
- ✅ **Custom Rules** - Configurable security policies

## 📦 Installation

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  ultra_secure_flutter_kit: ^1.0.0
```

## 🚀 Quick Start

### Basic Usage

```dart
import 'package:ultra_secure_flutter_kit/ultra_secure_flutter_kit.dart';

void main() async {
  // Initialize security
  final securityKit = UltraSecureFlutterKit();
  
  final config = SecurityConfig(
    mode: SecurityMode.strict,
    enableScreenshotBlocking: true,
    enableSSLPinning: true,
    enableSecureStorage: true,
  );
  
  await securityKit.initializeSecureMonitor(config);
  
  runApp(MyApp());
}
```

### Advanced Configuration

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
  allowedCertificates: [
    'sha256/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=',
    'sha256/BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB=',
  ],
  customRules: {
    'maxApiCallsPerMinute': 100,
    'maxScreenTouchesPerMinute': 200,
    'blockedCountries': ['XX', 'YY'],
  },
  sslPinningConfig: SSLPinningConfig(
    mode: SSLPinningMode.strict,
    pinnedCertificates: [
      'sha256/CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC=',
    ],
    pinnedPublicKeys: [
      'sha256/DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD=',
    ],
    certificateExpiryCheck: Duration(days: 30),
    enableFallback: false,
  ),
  biometricConfig: BiometricConfig(
    preferredType: BiometricType.fingerprint,
    allowFallback: true,
    sessionTimeout: Duration(minutes: 30),
    requireBiometricForSensitiveData: true,
    sensitiveOperations: [
      'secureStore',
      'secureRetrieve',
      'encryptData',
      'decryptData',
    ],
  ),
  obfuscationConfig: ObfuscationConfig(
    enableDartObfuscation: true,
    enableStringObfuscation: true,
    enableClassObfuscation: true,
    enableMethodObfuscation: true,
    enableDebugPrintStripping: true,
    enableStackTraceObfuscation: true,
    customObfuscationRules: {
      'apiKey': 'obfuscated_api_key',
      'secretToken': 'obfuscated_secret_token',
    },
  ),
);
```

## 🔧 Usage Examples

### 1. Device Security Checks

```dart
// Check device security status
final deviceStatus = await securityKit.getDeviceSecurityStatus();
print('Device is secure: ${deviceStatus.isSecure}');
print('Risk score: ${deviceStatus.riskScore}');

// Individual security checks
final isRooted = await securityKit.isRooted();
final isJailbroken = await securityKit.isJailbroken();
final isEmulator = await securityKit.isEmulator();
final isDebuggerAttached = await securityKit.isDebuggerAttached();
final hasProxy = await securityKit.hasProxySettings();
final hasVPN = await securityKit.hasVPNConnection();
final isDeveloperModeEnabled = await securityKit.isDeveloperModeEnabled();
```

### 2. Secure Storage

```dart
// Store sensitive data securely
await securityKit.secureStore(
  'user_token',
  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...',
  expiresIn: Duration(hours: 24),
);

// Retrieve sensitive data
final token = await securityKit.secureRetrieve('user_token');

// Encrypt/decrypt data
final encrypted = await securityKit.encryptSensitiveData('sensitive_data');
final decrypted = await securityKit.decryptSensitiveData(encrypted);

// Delete secure data
await securityKit.secureDelete('user_token');

// Clear all secure data
await securityKit.clearAllSecureData();
```

### 3. Secure API Calls

```dart
// Make secure API calls with protection
final response = await securityKit.secureApiCall(
  'https://api.example.com/secure',
  {
    'userId': '12345',
    'action': 'sensitive_operation',
    'timestamp': DateTime.now().millisecondsSinceEpoch,
  },
  headers: {
    'Authorization': 'Bearer ${securityKit.generateSecureRandom()}',
    'Content-Type': 'application/json',
  },
  method: 'POST',
);
```

### 4. Behavior Monitoring

```dart
// Record behavior events
securityKit.recordApiHit();
securityKit.recordScreenTouch();
securityKit.recordAppLaunch();

// Get behavior data
final behaviorData = securityKit.getBehaviorData();
print('API hits: ${behaviorData.apiHits}');
print('Screen touches: ${behaviorData.screenTouches}');
```

### 5. Security Event Listening

```dart
// Listen to security threats
securityKit.threatStream.listen((threat) {
  print('Security threat detected: ${threat.description}');
  print('Threat level: ${threat.level}');
  
  switch (threat.level) {
    case SecurityThreatLevel.critical:
      // Handle critical threat
      break;
    case SecurityThreatLevel.high:
      // Handle high threat
      break;
    default:
      // Handle other threats
      break;
  }
});

// Listen to protection status changes
securityKit.statusStream.listen((status) {
  print('Protection status: $status');
});
```

### 6. Data Sanitization

```dart
// Sanitize user input
final maliciousInput = '<script>alert("XSS")</script>';
final sanitized = securityKit.sanitizeInput(maliciousInput);
// Result: "alert("XSS")" (script tags removed)
```

### 7. Secure Random Generation

```dart
// Generate secure random data
final random32 = securityKit.generateSecureRandom(length: 32);
final random64 = securityKit.generateSecureRandom(length: 64);
```

### 8. Platform-Specific Security

```dart
// Enable security features
await securityKit.enableScreenCaptureProtection();
await securityKit.enableSecureFlag();
await securityKit.enableNetworkMonitoring();
await securityKit.enableRealTimeMonitoring();
await securityKit.preventReverseEngineering();
await securityKit.applyAntiTampering();

// Get app signature and verify integrity
final signature = await securityKit.getAppSignature();
final isIntegrityValid = await securityKit.verifyAppIntegrity();
final fingerprint = await securityKit.getDeviceFingerprint();
```

### 9. Developer Mode Management

```dart
// Check if developer mode is enabled
final isDeveloperMode = await securityKit.isDeveloperModeEnabled();

// Open developer options settings (Android)
if (isDeveloperMode) {
  await securityKit.openDeveloperOptionsSettings();
}
```

## 🛠️ Advanced Features

### SSL Pinning Configuration

```dart
final sslConfig = SSLPinningConfig(
  mode: SSLPinningMode.strict,
  pinnedCertificates: [
    'sha256/your_certificate_hash_here=',
  ],
  pinnedPublicKeys: [
    'sha256/your_public_key_hash_here=',
  ],
  certificateExpiryCheck: Duration(days: 30),
  enableFallback: false,
);
```

### Biometric Authentication

```dart
final biometricConfig = BiometricConfig(
  preferredType: BiometricType.fingerprint,
  allowFallback: true,
  sessionTimeout: Duration(minutes: 30),
  requireBiometricForSensitiveData: true,
  sensitiveOperations: [
    'secureStore',
    'secureRetrieve',
    'encryptData',
    'decryptData',
  ],
);
```

### Code Obfuscation

```dart
final obfuscationConfig = ObfuscationConfig(
  enableDartObfuscation: true,
  enableStringObfuscation: true,
  enableClassObfuscation: true,
  enableMethodObfuscation: true,
  enableDebugPrintStripping: true,
  enableStackTraceObfuscation: true,
  customObfuscationRules: {
    'apiKey': 'obfuscated_api_key',
    'secretToken': 'obfuscated_secret_token',
  },
);
```

## 📊 Security Metrics

```dart
// Get comprehensive security metrics
final metrics = securityKit.securityMetrics;
print('Threat count: ${metrics['threat_count']}');
print('Blocked attempts: ${metrics['blocked_attempts']}');
print('Active threats: ${metrics['active_threats']}');
print('API hits: ${metrics['api_hits']}');
print('Screen touches: ${metrics['screen_touches']}');
print('App launches: ${metrics['app_launches']}');
```

## 🔒 Security Modes

### Strict Mode (Maximum Protection)
```dart
final config = SecurityConfig(
  mode: SecurityMode.strict,
  blockOnHighRisk: true,
  // Blocks app on any high/critical threat
);
```

### Monitor Mode (Logging Only)
```dart
final config = SecurityConfig(
  mode: SecurityMode.monitor,
  blockOnHighRisk: false,
  // Logs threats but doesn't block app
);
```

### Custom Mode (Configurable)
```dart
final config = SecurityConfig(
  mode: SecurityMode.custom,
  blockOnHighRisk: true,
  customRules: {
    'allowRootedDevices': false,
    'allowEmulators': false,
    'maxRiskScore': 0.5,
  },
);
```

## 🚨 Threat Handling

```dart
// Listen to threats and handle them
securityKit.threatStream.listen((threat) {
  switch (threat.type) {
    case SecurityThreatType.rootDetected:
    case SecurityThreatType.jailbreakDetected:
      // Block app or show warning
      _showSecurityWarning('Device compromised');
      break;
      
    case SecurityThreatType.emulatorDetected:
      // Prevent sensitive operations
      _disableSensitiveFeatures();
      break;
      
    case SecurityThreatType.networkTamperingDetected:
      // Block network operations
      _blockNetworkAccess();
      break;
      
    case SecurityThreatType.suspiciousBehaviorDetected:
      // Increase monitoring
      _increaseMonitoring();
      break;
      
    default:
      // Handle other threats
      _logThreat(threat);
      break;
  }
});
```

## 📱 Platform Support

- ✅ **Android** - Full support with native security implementations
- ✅ **iOS** - Full support with native security implementations
- 🔄 **Web** - Limited support (some features not available)
- 🔄 **Desktop** - Limited support (some features not available)

## 🔧 Configuration

### Android Configuration

Add to `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.USE_BIOMETRIC" />
<uses-permission android:name="android.permission.USE_FINGERPRINT" />
```

### iOS Configuration

Add to `ios/Runner/Info.plist`:

```xml
<key>NSFaceIDUsageDescription</key>
<string>This app uses Face ID for secure authentication</string>
```

## 🧪 Testing

```dart
// Test security features
void testSecurity() async {
  final securityKit = UltraSecureFlutterKit();
  
  // Test device security
  final isSecure = await securityKit.getDeviceSecurityStatus();
  assert(isSecure.isSecure == true);
  
  // Test secure storage
  await securityKit.secureStore('test', 'value');
  final value = await securityKit.secureRetrieve('test');
  assert(value == 'value');
  
  // Test encryption
  final encrypted = await securityKit.encryptSensitiveData('test');
  final decrypted = await securityKit.decryptSensitiveData(encrypted);
  assert(decrypted == 'test');
}
```

## 📈 Performance

The plugin is optimized for performance with minimal overhead:

- **Memory Usage**: < 5MB additional memory
- **CPU Impact**: < 2% CPU usage during normal operation
- **Battery Impact**: < 1% additional battery drain
- **Startup Time**: < 100ms initialization time

## 🔐 Security Best Practices

1. **Always initialize security early** in your app lifecycle
2. **Use strict mode** for production applications
3. **Implement proper threat handling** for detected security issues
4. **Regularly update security configurations** based on new threats
5. **Monitor security metrics** to identify patterns
6. **Use secure storage** for all sensitive data
7. **Implement proper error handling** for security failures
8. **Test on real devices** to ensure security features work correctly

## 🤝 Contributing

Contributions are welcome! Please read our contributing guidelines and submit pull requests for any improvements.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

For support and questions:

- 📧 Email: support@ultrasecureflutterkit.com
- 📖 Documentation: https://docs.ultrasecureflutterkit.com
- 🐛 Issues: https://github.com/kanhiya3008/ultra_secure_flutter_kit/issues
- 💬 Discord: https://discord.gg/ultrasecureflutterkit

## 🔄 Changelog

See [CHANGELOG.md](CHANGELOG.md) for a complete list of changes and updates.

---

**⚠️ Important**: This plugin provides comprehensive security features, but no security solution is 100% foolproof. Always follow security best practices and keep your app updated with the latest security patches.

