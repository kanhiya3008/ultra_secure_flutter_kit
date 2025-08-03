/// Protection status enum
enum ProtectionStatus { uninitialized, protected, threatened, blocked, failed }

/// Log levels for security events
enum LogLevel { debug, info, warning, error, critical }

/// Security threat levels
enum SecurityThreatLevel { low, medium, high, critical }

/// Security modes for different protection levels
enum SecurityMode {
  strict, // Maximum protection, block on any threat
  monitor, // Log threats but don't block
  custom, // Custom rules
}

/// Types of security threats
enum SecurityThreatType {
  rootDetected,
  jailbreakDetected,
  emulatorDetected,
  debuggerDetected,
  screenCaptureAttempted,
  networkTamperingDetected,
  proxyDetected,
  vpnDetected,
  suspiciousBehaviorDetected,
  appTamperingDetected,
  reverseEngineeringDetected,
  dataLeakageDetected,
  fridaDetected,
  xposedDetected,
  mitmAttackDetected,
  certificateMismatch,
  biometricBypassDetected,
  usbCableAttached, // New USB cable detection threat
}

/// Device risk factors
enum DeviceRiskFactor {
  rooted,
  jailbroken,
  emulator,
  debugger,
  proxy,
  vpn,
  suspiciousBehavior,
  unknown,
}

/// Biometric authentication types
enum BiometricType { fingerprint, face, iris, voice, none }

/// SSL Pinning modes
enum SSLPinningMode {
  strict, // Only allow pinned certificates
  fallback, // Allow fallback to system certificates
  custom, // Custom certificate validation
}

/// Security configuration
class SecurityConfig {
  final SecurityMode mode;
  final bool blockOnHighRisk;
  final bool enableScreenshotBlocking;
  final bool enableSSLPinning;
  final bool enableSecureStorage;
  final bool enableNetworkMonitoring;
  final bool enableBehaviorMonitoring;
  final bool enableBiometricAuth;
  final bool enableCodeObfuscation;
  final bool enableDebugPrintStripping;
  final bool enablePlatformChannelHardening;
  final bool enableMITMDetection;
  final bool enableInstallationSourceVerification;
  final bool enableDeveloperModeDetection;
  final List<String> allowedCertificates;
  final Map<String, dynamic> customRules;
  final SSLPinningConfig? sslPinningConfig;
  final BiometricConfig? biometricConfig;
  final ObfuscationConfig? obfuscationConfig;

  const SecurityConfig({
    this.mode = SecurityMode.strict,
    this.blockOnHighRisk = true,
    this.enableScreenshotBlocking = true,
    this.enableSSLPinning = true,
    this.enableSecureStorage = true,
    this.enableNetworkMonitoring = true,
    this.enableBehaviorMonitoring = true,
    this.enableBiometricAuth = false,
    this.enableCodeObfuscation = true,
    this.enableDebugPrintStripping = true,
    this.enablePlatformChannelHardening = true,
    this.enableMITMDetection = true,
    this.enableInstallationSourceVerification = true,
    this.enableDeveloperModeDetection = true,
    this.allowedCertificates = const [],
    this.customRules = const {},
    this.sslPinningConfig,
    this.biometricConfig,
    this.obfuscationConfig,
  });

  Map<String, dynamic> toJson() {
    return {
      'mode': mode.toString(),
      'blockOnHighRisk': blockOnHighRisk,
      'enableScreenshotBlocking': enableScreenshotBlocking,
      'enableSSLPinning': enableSSLPinning,
      'enableSecureStorage': enableSecureStorage,
      'enableNetworkMonitoring': enableNetworkMonitoring,
      'enableBehaviorMonitoring': enableBehaviorMonitoring,
      'enableBiometricAuth': enableBiometricAuth,
      'enableCodeObfuscation': enableCodeObfuscation,
      'enableDebugPrintStripping': enableDebugPrintStripping,
      'enablePlatformChannelHardening': enablePlatformChannelHardening,
      'enableMITMDetection': enableMITMDetection,
      'enableInstallationSourceVerification':
          enableInstallationSourceVerification,
      'enableDeveloperModeDetection': enableDeveloperModeDetection,
      'allowedCertificates': allowedCertificates,
      'customRules': customRules,
      'sslPinningConfig': sslPinningConfig?.toJson(),
      'biometricConfig': biometricConfig?.toJson(),
      'obfuscationConfig': obfuscationConfig?.toJson(),
    };
  }

  factory SecurityConfig.fromJson(Map<String, dynamic> json) {
    return SecurityConfig(
      mode: SecurityMode.values.firstWhere(
        (e) => e.toString() == json['mode'],
        orElse: () => SecurityMode.strict,
      ),
      blockOnHighRisk: json['blockOnHighRisk'] ?? true,
      enableScreenshotBlocking: json['enableScreenshotBlocking'] ?? true,
      enableSSLPinning: json['enableSSLPinning'] ?? true,
      enableSecureStorage: json['enableSecureStorage'] ?? true,
      enableNetworkMonitoring: json['enableNetworkMonitoring'] ?? true,
      enableBehaviorMonitoring: json['enableBehaviorMonitoring'] ?? true,
      enableBiometricAuth: json['enableBiometricAuth'] ?? false,
      enableCodeObfuscation: json['enableCodeObfuscation'] ?? true,
      enableDebugPrintStripping: json['enableDebugPrintStripping'] ?? true,
      enablePlatformChannelHardening:
          json['enablePlatformChannelHardening'] ?? true,
      enableMITMDetection: json['enableMITMDetection'] ?? true,
      enableInstallationSourceVerification:
          json['enableInstallationSourceVerification'] ?? true,
      enableDeveloperModeDetection:
          json['enableDeveloperModeDetection'] ?? true,
      allowedCertificates: List<String>.from(json['allowedCertificates'] ?? []),
      customRules: Map<String, dynamic>.from(json['customRules'] ?? {}),
      sslPinningConfig: json['sslPinningConfig'] != null
          ? SSLPinningConfig.fromJson(json['sslPinningConfig'])
          : null,
      biometricConfig: json['biometricConfig'] != null
          ? BiometricConfig.fromJson(json['biometricConfig'])
          : null,
      obfuscationConfig: json['obfuscationConfig'] != null
          ? ObfuscationConfig.fromJson(json['obfuscationConfig'])
          : null,
    );
  }

  SecurityConfig copyWith({
    SecurityMode? mode,
    bool? blockOnHighRisk,
    bool? enableScreenshotBlocking,
    bool? enableSSLPinning,
    bool? enableSecureStorage,
    bool? enableNetworkMonitoring,
    bool? enableBehaviorMonitoring,
    bool? enableBiometricAuth,
    bool? enableCodeObfuscation,
    bool? enableDebugPrintStripping,
    bool? enablePlatformChannelHardening,
    bool? enableMITMDetection,
    bool? enableInstallationSourceVerification,
    bool? enableDeveloperModeDetection,
    List<String>? allowedCertificates,
    Map<String, dynamic>? customRules,
    SSLPinningConfig? sslPinningConfig,
    BiometricConfig? biometricConfig,
    ObfuscationConfig? obfuscationConfig,
  }) {
    return SecurityConfig(
      mode: mode ?? this.mode,
      blockOnHighRisk: blockOnHighRisk ?? this.blockOnHighRisk,
      enableScreenshotBlocking:
          enableScreenshotBlocking ?? this.enableScreenshotBlocking,
      enableSSLPinning: enableSSLPinning ?? this.enableSSLPinning,
      enableSecureStorage: enableSecureStorage ?? this.enableSecureStorage,
      enableNetworkMonitoring:
          enableNetworkMonitoring ?? this.enableNetworkMonitoring,
      enableBehaviorMonitoring:
          enableBehaviorMonitoring ?? this.enableBehaviorMonitoring,
      enableBiometricAuth: enableBiometricAuth ?? this.enableBiometricAuth,
      enableCodeObfuscation:
          enableCodeObfuscation ?? this.enableCodeObfuscation,
      enableDebugPrintStripping:
          enableDebugPrintStripping ?? this.enableDebugPrintStripping,
      enablePlatformChannelHardening:
          enablePlatformChannelHardening ?? this.enablePlatformChannelHardening,
      enableMITMDetection: enableMITMDetection ?? this.enableMITMDetection,
      enableInstallationSourceVerification:
          enableInstallationSourceVerification ??
          this.enableInstallationSourceVerification,
      enableDeveloperModeDetection:
          enableDeveloperModeDetection ?? this.enableDeveloperModeDetection,
      allowedCertificates: allowedCertificates ?? this.allowedCertificates,
      customRules: customRules ?? this.customRules,
      sslPinningConfig: sslPinningConfig ?? this.sslPinningConfig,
      biometricConfig: biometricConfig ?? this.biometricConfig,
      obfuscationConfig: obfuscationConfig ?? this.obfuscationConfig,
    );
  }
}

/// SSL Pinning Configuration
class SSLPinningConfig {
  final SSLPinningMode mode;
  final List<String> pinnedCertificates;
  final List<String> pinnedPublicKeys;
  final Duration certificateExpiryCheck;
  final bool enableFallback;

  const SSLPinningConfig({
    this.mode = SSLPinningMode.strict,
    this.pinnedCertificates = const [],
    this.pinnedPublicKeys = const [],
    this.certificateExpiryCheck = const Duration(days: 30),
    this.enableFallback = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'mode': mode.toString(),
      'pinnedCertificates': pinnedCertificates,
      'pinnedPublicKeys': pinnedPublicKeys,
      'certificateExpiryCheck': certificateExpiryCheck.inDays,
      'enableFallback': enableFallback,
    };
  }

  factory SSLPinningConfig.fromJson(Map<String, dynamic> json) {
    return SSLPinningConfig(
      mode: SSLPinningMode.values.firstWhere(
        (e) => e.toString() == json['mode'],
        orElse: () => SSLPinningMode.strict,
      ),
      pinnedCertificates: List<String>.from(json['pinnedCertificates'] ?? []),
      pinnedPublicKeys: List<String>.from(json['pinnedPublicKeys'] ?? []),
      certificateExpiryCheck: Duration(
        days: json['certificateExpiryCheck'] ?? 30,
      ),
      enableFallback: json['enableFallback'] ?? false,
    );
  }
}

/// Biometric Configuration
class BiometricConfig {
  final BiometricType preferredType;
  final bool allowFallback;
  final Duration sessionTimeout;
  final bool requireBiometricForSensitiveData;
  final List<String> sensitiveOperations;

  const BiometricConfig({
    this.preferredType = BiometricType.fingerprint,
    this.allowFallback = true,
    this.sessionTimeout = const Duration(minutes: 30),
    this.requireBiometricForSensitiveData = true,
    this.sensitiveOperations = const [
      'secureStore',
      'secureRetrieve',
      'encryptData',
    ],
  });

  Map<String, dynamic> toJson() {
    return {
      'preferredType': preferredType.toString(),
      'allowFallback': allowFallback,
      'sessionTimeout': sessionTimeout.inMinutes,
      'requireBiometricForSensitiveData': requireBiometricForSensitiveData,
      'sensitiveOperations': sensitiveOperations,
    };
  }

  factory BiometricConfig.fromJson(Map<String, dynamic> json) {
    return BiometricConfig(
      preferredType: BiometricType.values.firstWhere(
        (e) => e.toString() == json['preferredType'],
        orElse: () => BiometricType.fingerprint,
      ),
      allowFallback: json['allowFallback'] ?? true,
      sessionTimeout: Duration(minutes: json['sessionTimeout'] ?? 30),
      requireBiometricForSensitiveData:
          json['requireBiometricForSensitiveData'] ?? true,
      sensitiveOperations: List<String>.from(json['sensitiveOperations'] ?? []),
    );
  }
}

/// Code Obfuscation Configuration
class ObfuscationConfig {
  final bool enableDartObfuscation;
  final bool enableStringObfuscation;
  final bool enableClassObfuscation;
  final bool enableMethodObfuscation;
  final bool enableDebugPrintStripping;
  final bool enableStackTraceObfuscation;
  final Map<String, String> customObfuscationRules;

  const ObfuscationConfig({
    this.enableDartObfuscation = true,
    this.enableStringObfuscation = true,
    this.enableClassObfuscation = true,
    this.enableMethodObfuscation = true,
    this.enableDebugPrintStripping = true,
    this.enableStackTraceObfuscation = true,
    this.customObfuscationRules = const {},
  });

  Map<String, dynamic> toJson() {
    return {
      'enableDartObfuscation': enableDartObfuscation,
      'enableStringObfuscation': enableStringObfuscation,
      'enableClassObfuscation': enableClassObfuscation,
      'enableMethodObfuscation': enableMethodObfuscation,
      'enableDebugPrintStripping': enableDebugPrintStripping,
      'enableStackTraceObfuscation': enableStackTraceObfuscation,
      'customObfuscationRules': customObfuscationRules,
    };
  }

  factory ObfuscationConfig.fromJson(Map<String, dynamic> json) {
    return ObfuscationConfig(
      enableDartObfuscation: json['enableDartObfuscation'] ?? true,
      enableStringObfuscation: json['enableStringObfuscation'] ?? true,
      enableClassObfuscation: json['enableClassObfuscation'] ?? true,
      enableMethodObfuscation: json['enableMethodObfuscation'] ?? true,
      enableDebugPrintStripping: json['enableDebugPrintStripping'] ?? true,
      enableStackTraceObfuscation: json['enableStackTraceObfuscation'] ?? true,
      customObfuscationRules: Map<String, String>.from(
        json['customObfuscationRules'] ?? {},
      ),
    );
  }
}

/// Security threat information
class SecurityThreat {
  final SecurityThreatType type;
  final SecurityThreatLevel level;
  final String description;
  final DateTime timestamp;
  final Map<String, dynamic>? metadata;

  const SecurityThreat({
    required this.type,
    required this.level,
    required this.description,
    required this.timestamp,
    this.metadata,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type.toString(),
      'level': level.toString(),
      'description': description,
      'timestamp': timestamp.toIso8601String(),
      'metadata': metadata,
    };
  }

  factory SecurityThreat.fromJson(Map<String, dynamic> json) {
    return SecurityThreat(
      type: SecurityThreatType.values.firstWhere(
        (e) => e.toString() == json['type'],
        orElse: () => SecurityThreatType.suspiciousBehaviorDetected,
      ),
      level: SecurityThreatLevel.values.firstWhere(
        (e) => e.toString() == json['level'],
        orElse: () => SecurityThreatLevel.medium,
      ),
      description: json['description'] ?? '',
      timestamp: DateTime.parse(json['timestamp']),
      metadata: json['metadata'],
    );
  }
}

/// Device security status
class DeviceSecurityStatus {
  final bool isRooted;
  final bool isJailbroken;
  final bool isEmulator;
  final bool isDebuggerAttached;
  final bool hasProxy;
  final bool hasVPN;
  final bool isScreenCaptureBlocked;
  final bool isSSLValid;
  final bool isBiometricAvailable;
  final bool isCodeObfuscated;
  final bool isDeveloperModeEnabled;
  final bool isUsbCableAttached; // New USB cable status
  final double riskScore;
  final bool isSecure;
  final List<SecurityThreat> activeThreats;

  const DeviceSecurityStatus({
    required this.isRooted,
    required this.isJailbroken,
    required this.isEmulator,
    required this.isDebuggerAttached,
    required this.hasProxy,
    required this.hasVPN,
    required this.isScreenCaptureBlocked,
    required this.isSSLValid,
    required this.isBiometricAvailable,
    required this.isCodeObfuscated,
    required this.isDeveloperModeEnabled,
    required this.isUsbCableAttached, // New field
    required this.riskScore,
    required this.isSecure,
    required this.activeThreats,
  });

  factory DeviceSecurityStatus.fromJson(Map<String, dynamic> json) {
    return DeviceSecurityStatus(
      isRooted: json['isRooted'] ?? false,
      isJailbroken: json['isJailbroken'] ?? false,
      isEmulator: json['isEmulator'] ?? false,
      isDebuggerAttached: json['isDebuggerAttached'] ?? false,
      hasProxy: json['hasProxy'] ?? false,
      hasVPN: json['hasVPN'] ?? false,
      isScreenCaptureBlocked: json['isScreenCaptureBlocked'] ?? false,
      isSSLValid: json['isSSLValid'] ?? false,
      isBiometricAvailable: json['isBiometricAvailable'] ?? false,
      isCodeObfuscated: json['isCodeObfuscated'] ?? false,
      isDeveloperModeEnabled: json['isDeveloperModeEnabled'] ?? false,
      isUsbCableAttached: json['isUsbCableAttached'] ?? false, // New field
      riskScore: (json['riskScore'] ?? 0.0).toDouble(),
      isSecure: json['isSecure'] ?? false,
      activeThreats:
          (json['activeThreats'] as List<dynamic>?)
              ?.map((e) => SecurityThreat.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isRooted': isRooted,
      'isJailbroken': isJailbroken,
      'isEmulator': isEmulator,
      'isDebuggerAttached': isDebuggerAttached,
      'hasProxy': hasProxy,
      'hasVPN': hasVPN,
      'isScreenCaptureBlocked': isScreenCaptureBlocked,
      'isSSLValid': isSSLValid,
      'isBiometricAvailable': isBiometricAvailable,
      'isCodeObfuscated': isCodeObfuscated,
      'isDeveloperModeEnabled': isDeveloperModeEnabled,
      'isUsbCableAttached': isUsbCableAttached, // New field
      'riskScore': riskScore,
      'isSecure': isSecure,
      'activeThreats': activeThreats.map((e) => e.toJson()).toList(),
    };
  }

  DeviceSecurityStatus copyWith({
    bool? isRooted,
    bool? isJailbroken,
    bool? isEmulator,
    bool? isDebuggerAttached,
    bool? hasProxy,
    bool? hasVPN,
    bool? isScreenCaptureBlocked,
    bool? isSSLValid,
    bool? isBiometricAvailable,
    bool? isCodeObfuscated,
    bool? isDeveloperModeEnabled,
    bool? isUsbCableAttached, // New field
    double? riskScore,
    bool? isSecure,
    List<SecurityThreat>? activeThreats,
  }) {
    return DeviceSecurityStatus(
      isRooted: isRooted ?? this.isRooted,
      isJailbroken: isJailbroken ?? this.isJailbroken,
      isEmulator: isEmulator ?? this.isEmulator,
      isDebuggerAttached: isDebuggerAttached ?? this.isDebuggerAttached,
      hasProxy: hasProxy ?? this.hasProxy,
      hasVPN: hasVPN ?? this.hasVPN,
      isScreenCaptureBlocked:
          isScreenCaptureBlocked ?? this.isScreenCaptureBlocked,
      isSSLValid: isSSLValid ?? this.isSSLValid,
      isBiometricAvailable: isBiometricAvailable ?? this.isBiometricAvailable,
      isCodeObfuscated: isCodeObfuscated ?? this.isCodeObfuscated,
      isDeveloperModeEnabled:
          isDeveloperModeEnabled ?? this.isDeveloperModeEnabled,
      isUsbCableAttached:
          isUsbCableAttached ?? this.isUsbCableAttached, // New field
      riskScore: riskScore ?? this.riskScore,
      isSecure: isSecure ?? this.isSecure,
      activeThreats: activeThreats ?? this.activeThreats,
    );
  }
}

/// Behavior data for monitoring
class BehaviorData {
  final int apiHits;
  final int screenTouches;
  final int appLaunches;
  final DateTime timestamp;
  final Map<String, dynamic> additionalData;

  const BehaviorData({
    required this.apiHits,
    required this.screenTouches,
    required this.appLaunches,
    required this.timestamp,
    this.additionalData = const {},
  });

  Map<String, dynamic> toJson() {
    return {
      'apiHits': apiHits,
      'screenTouches': screenTouches,
      'appLaunches': appLaunches,
      'timestamp': timestamp.toIso8601String(),
      'additionalData': additionalData,
    };
  }
}

/// Secure storage data
class SecureData {
  final String key;
  final String encryptedValue;
  final DateTime createdAt;
  final DateTime? expiresAt;
  final Map<String, dynamic> metadata;

  const SecureData({
    required this.key,
    required this.encryptedValue,
    required this.createdAt,
    this.expiresAt,
    this.metadata = const {},
  });

  bool get isExpired => expiresAt != null && DateTime.now().isAfter(expiresAt!);

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'encryptedValue': encryptedValue,
      'createdAt': createdAt.toIso8601String(),
      'expiresAt': expiresAt?.toIso8601String(),
      'metadata': metadata,
      'isExpired': isExpired,
    };
  }
}

/// Biometric authentication result
class BiometricResult {
  final bool success;
  final BiometricType type;
  final String? errorMessage;
  final Map<String, dynamic>? metadata;

  const BiometricResult({
    required this.success,
    required this.type,
    this.errorMessage,
    this.metadata,
  });

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'type': type.toString(),
      'errorMessage': errorMessage,
      'metadata': metadata,
    };
  }
}

/// Installation source information
class InstallationSource {
  final String source;
  final bool isVerified;
  final String? certificateHash;
  final DateTime? installationDate;
  final Map<String, dynamic>? metadata;

  const InstallationSource({
    required this.source,
    required this.isVerified,
    this.certificateHash,
    this.installationDate,
    this.metadata,
  });

  Map<String, dynamic> toJson() {
    return {
      'source': source,
      'isVerified': isVerified,
      'certificateHash': certificateHash,
      'installationDate': installationDate?.toIso8601String(),
      'metadata': metadata,
    };
  }
}
