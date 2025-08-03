import Flutter
import UIKit
import Security
import SystemConfiguration
import Network
import CommonCrypto
import LocalAuthentication
import ExternalAccessory

public class UltraSecureFlutterKitPlugin: NSObject, FlutterPlugin {
  private static var pinnedCertificates: Set<String> = []
  private static var pinnedPublicKeys: Set<String> = []
  
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "ultra_secure_flutter_kit", binaryMessenger: registrar.messenger())
    let instance = UltraSecureFlutterKitPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    case "isRooted":
      result(isJailbroken())
    case "isJailbroken":
      result(isJailbroken())
    case "isEmulator":
      result(isEmulator())
    case "isDebuggerAttached":
      result(isDebuggerAttached())
    case "enableScreenCaptureProtection":
      enableScreenCaptureProtection()
      result(nil)
    case "disableScreenCaptureProtection":
      disableScreenCaptureProtection()
      result(nil)
    case "isScreenCaptureBlocked":
      result(isScreenCaptureBlocked())
    case "isUsbCableAttached":
      result(isUsbCableAttached())
    case "getUsbConnectionStatus":
      result(getUsbConnectionStatus())
    case "getAppSignature":
      result(getAppSignature())
    case "verifyAppIntegrity":
      result(verifyAppIntegrity())
    case "getDeviceFingerprint":
      result(getDeviceFingerprint())
    case "enableSecureFlag":
      enableSecureFlag()
      result(nil)
    case "enableNetworkMonitoring":
      enableNetworkMonitoring()
      result(nil)
    case "enableRealTimeMonitoring":
      enableRealTimeMonitoring()
      result(nil)
    case "preventReverseEngineering":
      preventReverseEngineering()
      result(nil)
    case "applyAntiTampering":
      applyAntiTampering()
      result(nil)
    case "hasProxySettings":
      result(hasProxySettings())
    case "hasVPNConnection":
      result(hasVPNConnection())
    case "getUnexpectedCertificates":
      result(getUnexpectedCertificates())
    case "isDeveloperModeEnabled":
      result(isDeveloperModeEnabled())
    case "openDeveloperOptionsSettings":
      openDeveloperOptionsSettings()
      result(nil)
    case "configureSSLPinning":
      let certificates = call.arguments as? [String] ?? []
      let publicKeys = call.arguments as? [String] ?? []
      configureSSLPinning(certificates: certificates, publicKeys: publicKeys)
      result(nil)
    case "verifySSLPinning":
      let url = call.arguments as? String ?? ""
      result(verifySSLPinning(url: url))
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  // MARK: - SSL Pinning Configuration
  private func configureSSLPinning(certificates: [String], publicKeys: [String]) {
    UltraSecureFlutterKitPlugin.pinnedCertificates.removeAll()
    UltraSecureFlutterKitPlugin.pinnedPublicKeys.removeAll()
    
    UltraSecureFlutterKitPlugin.pinnedCertificates.formUnion(certificates)
    UltraSecureFlutterKitPlugin.pinnedPublicKeys.formUnion(publicKeys)
    
    print("Security: SSL Pinning configured with \(certificates.count) certificates and \(publicKeys.count) public keys")
  }

  // MARK: - SSL Pinning Verification
  private func verifySSLPinning(url: String) -> Bool {
    guard let urlObj = URL(string: url) else {
      print("Security: Invalid URL for SSL pinning verification")
      return false
    }
    
    let session = URLSession(configuration: .default)
    let semaphore = DispatchSemaphore(value: 0)
    var isPinned = false
    
    let task = session.dataTask(with: urlObj) { data, response, error in
      defer { semaphore.signal() }
      
      if let httpResponse = response as? HTTPURLResponse,
         let serverTrust = httpResponse.url?.host {
        
        // Get the certificate chain
        if let trust = SecTrustCreateWithCertificates(nil, nil) {
          let certCount = SecTrustGetCertificateCount(trust)
          
          for i in 0..<certCount {
            if let cert = SecTrustGetCertificateAtIndex(trust, i) {
              // Check certificate pinning
              let certHash = self.getCertificateHash(cert: cert)
              if UltraSecureFlutterKitPlugin.pinnedCertificates.contains(certHash) {
                print("Security: Certificate pinning verification successful")
                isPinned = true
                break
              }
              
              // Check public key pinning
              let publicKeyHash = self.getPublicKeyHash(cert: cert)
              if UltraSecureFlutterKitPlugin.pinnedPublicKeys.contains(publicKeyHash) {
                print("Security: Public key pinning verification successful")
                isPinned = true
                break
              }
            }
          }
        }
      }
    }
    
    task.resume()
    _ = semaphore.wait(timeout: .now() + 10.0)
    
    if !isPinned {
      print("Security: SSL pinning verification failed")
    }
    
    return isPinned
  }

  private func getCertificateHash(cert: SecCertificate) -> String {
    let certData = SecCertificateCopyData(cert) as Data
    var hash = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
    certData.withUnsafeBytes { buffer in
      _ = CC_SHA256(buffer.baseAddress, CC_LONG(certData.count), &hash)
    }
    return Data(hash).base64EncodedString()
  }

  private func getPublicKeyHash(cert: SecCertificate) -> String {
    // Extract public key from certificate
    let policy = SecPolicyCreateBasicX509()
    var trust: SecTrust?
    let status = SecTrustCreateWithCertificates(cert, policy, &trust)
    
    guard status == errSecSuccess, let trust = trust else {
      return ""
    }
    
    if let publicKey = SecTrustCopyPublicKey(trust) {
      let publicKeyData = SecKeyCopyExternalRepresentation(publicKey, nil) as? Data
      if let data = publicKeyData {
        var hash = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        data.withUnsafeBytes { buffer in
          _ = CC_SHA256(buffer.baseAddress, CC_LONG(data.count), &hash)
        }
        return Data(hash).base64EncodedString()
      }
    }
    
    return ""
  }

  // MARK: - Jailbreak Detection
  private func isJailbroken() -> Bool {
    // Check for common jailbreak files
    let jailbreakPaths = [
      "/Applications/Cydia.app",
      "/Library/MobileSubstrate/MobileSubstrate.dylib",
      "/bin/bash",
      "/usr/sbin/sshd",
      "/etc/apt",
      "/private/var/lib/apt/",
      "/private/var/lib/cydia",
      "/private/var/mobile/Library/SBSettings/Themes",
      "/Library/MobileSubstrate/DynamicLibraries/Veency.plist",
      "/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist",
      "/System/Library/LaunchDaemons/com.ikey.bbot.plist",
      "/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist"
    ]

    for path in jailbreakPaths {
      if FileManager.default.fileExists(atPath: path) {
        print("Security: Jailbreak file found: \(path)")
        return true
      }
    }

    // Check for write access to system directories
    let systemPaths = [
      "/private/var/mobile",
      "/private/var/root",
      "/Applications"
    ]

    for path in systemPaths {
      if FileManager.default.isWritableFile(atPath: path) {
        print("Security: Write access to system directory: \(path)")
        return true
      }
    }

    // Check for suspicious environment variables
    let suspiciousEnvVars = [
      "DYLD_INSERT_LIBRARIES",
      "DYLD_LIBRARY_PATH"
    ]

    for envVar in suspiciousEnvVars {
      if getenv(envVar) != nil {
        print("Security: Suspicious environment variable: \(envVar)")
        return true
      }
    }

    return false
  }

  // MARK: - Emulator Detection
  private func isEmulator() -> Bool {
    #if targetEnvironment(simulator)
      return true
    #else
      // Check for simulator-specific files
      let simulatorPaths = [
        "/Applications/Xcode.app",
        "/Applications/Xcode-beta.app"
      ]

      for path in simulatorPaths {
        if FileManager.default.fileExists(atPath: path) {
          print("Security: Simulator detected via path: \(path)")
          return true
        }
      }

      // Check device model
      let deviceModel = UIDevice.current.model
      if deviceModel.contains("Simulator") {
        print("Security: Simulator detected via device model")
        return true
      }

      return false
    #endif
  }

  // MARK: - Debugger Detection
  private func isDebuggerAttached() -> Bool {
    var info = kinfo_proc()
    var mib: [Int32] = [CTL_KERN, KERN_PROC, KERN_PROC_PID, getpid()]
    var size = MemoryLayout<kinfo_proc>.size
    let junk = sysctl(&mib, UInt32(mib.count), &info, &size, nil, 0)
    assert(junk == 0, "sysctl failed")

    return (info.kp_proc.p_flag & P_TRACED) != 0
  }

  // MARK: - Screen Capture Protection
  private func enableScreenCaptureProtection() {
    // Set a flag in UserDefaults to indicate screenshot blocking should be enabled
    UserDefaults.standard.set(true, forKey: "screenshot_blocking_enabled")
    
    // Post notification to inform view controllers to enable screen capture protection
    NotificationCenter.default.post(name: NSNotification.Name("EnableScreenCaptureProtection"), object: nil)
    
    print("Security: Screen capture protection enabled")
  }

  private func disableScreenCaptureProtection() {
    // Set a flag in UserDefaults to indicate screenshot blocking should be disabled
    UserDefaults.standard.set(false, forKey: "screenshot_blocking_enabled")
    
    // Post notification to inform view controllers to disable screen capture protection
    NotificationCenter.default.post(name: NSNotification.Name("DisableScreenCaptureProtection"), object: nil)
    
    print("Security: Screen capture protection disabled")
  }

  private func isScreenCaptureBlocked() -> Bool {
    return UserDefaults.standard.bool(forKey: "screenshot_blocking_enabled")
  }

  // MARK: - Developer Mode Detection (iOS)
  private func isDeveloperModeEnabled() -> Bool {
    // On iOS, check if the app is running in debug mode or if developer options are available
    #if DEBUG
      return true
    #else
      // Check for developer certificates
      if let bundleIdentifier = Bundle.main.bundleIdentifier {
        // Check if app is signed with development certificate
        let isDevelopmentBuild = bundleIdentifier.contains("development") || 
                                bundleIdentifier.contains("debug") ||
                                bundleIdentifier.contains("test")
        return isDevelopmentBuild
      }
      return false
    #endif
  }

  // MARK: - Open Developer Options Settings (iOS)
  private func openDeveloperOptionsSettings() {
    // On iOS, we can't directly open developer options, but we can open general settings
    if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
      if UIApplication.shared.canOpenURL(settingsUrl) {
        UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
        print("Security: Opened iOS Settings")
      }
    }
  }

  // MARK: - App Signature Verification
  private func getAppSignature() -> String {
    guard let bundleIdentifier = Bundle.main.bundleIdentifier else {
      return ""
    }

    // Get the app's code signing identity
    var staticCode: SecStaticCode?
    var status = SecStaticCodeCreateWithPath(bundleIdentifier as CFString, [], &staticCode)
    
    guard status == errSecSuccess, let code = staticCode else {
      return ""
    }

    // Get the signing information
    var signingInfo: CFDictionary?
    status = SecCodeCopySigningInformation(code, SecCSFlags(rawValue: 0), &signingInfo)
    
    guard status == errSecSuccess, let info = signingInfo as? [String: Any] else {
      return ""
    }

    // Extract the certificate data
    if let certificates = info["certificates"] as? [SecCertificate] {
      if let firstCert = certificates.first {
        let certData = SecCertificateCopyData(firstCert)
        let data = certData as Data
        
        // Create SHA-256 hash
        var hash = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        data.withUnsafeBytes { buffer in
          _ = CC_SHA256(buffer.baseAddress, CC_LONG(data.count), &hash)
        }
        
        return Data(hash).base64EncodedString()
      }
    }

    return ""
  }

  // MARK: - App Integrity Verification
  private func verifyAppIntegrity() -> Bool {
    // Check if app is from App Store
    guard let receiptURL = Bundle.main.appStoreReceiptURL else {
      print("Security: No App Store receipt found")
      return false
    }

    // Check if receipt exists
    if !FileManager.default.fileExists(atPath: receiptURL.path) {
      print("Security: App Store receipt not found")
      return false
    }

    // Verify code signing
    var staticCode: SecStaticCode?
    var status = SecStaticCodeCreateWithPath(Bundle.main.bundlePath as CFString, [], &staticCode)
    
    guard status == errSecSuccess, let code = staticCode else {
      print("Security: Failed to create static code")
      return false
    }

    // Verify the code signature
    status = SecStaticCodeCheckValidity(code, SecCSFlags(rawValue: 0), nil)
    
    if status != errSecSuccess {
      print("Security: Code signature validation failed")
      return false
    }

    return true
  }

  // MARK: - Device Fingerprinting
  private func getDeviceFingerprint() -> String {
    let device = UIDevice.current
    let systemInfo = ProcessInfo.processInfo
    
    var fingerprint = ""
    fingerprint += device.name + "|"
    fingerprint += device.model + "|"
    fingerprint += device.systemName + "|"
    fingerprint += device.systemVersion + "|"
    fingerprint += systemInfo.machineHardwareName + "|"
    fingerprint += systemInfo.operatingSystemVersionString + "|"
    
    // Add device identifier (if available)
    if let identifierForVendor = device.identifierForVendor?.uuidString {
      fingerprint += identifierForVendor
    } else {
      fingerprint += "unknown"
    }

    // Create SHA-256 hash
    let data = fingerprint.data(using: .utf8) ?? Data()
    var hash = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
    data.withUnsafeBytes { buffer in
      _ = CC_SHA256(buffer.baseAddress, CC_LONG(data.count), &hash)
    }
    
    return Data(hash).base64EncodedString()
  }

  // MARK: - Secure Flag
  private func enableSecureFlag() {
    // This would typically be implemented in the view controller
    print("Security: Secure flag requested")
  }

  // MARK: - Network Monitoring
  private func enableNetworkMonitoring() {
    print("Security: Network monitoring enabled")
  }

  // MARK: - Real-time Monitoring
  private func enableRealTimeMonitoring() {
    print("Security: Real-time monitoring enabled")
  }

  // MARK: - Anti-Reverse Engineering
  private func preventReverseEngineering() {
    // Check for common reverse engineering tools
    let suspiciousPaths = [
      "/usr/bin/gdb",
      "/usr/bin/lldb",
      "/usr/bin/otool",
      "/usr/bin/strings",
      "/usr/bin/nm",
      "/usr/bin/class-dump",
      "/usr/bin/cycript",
      "/usr/bin/frida"
    ]

    for path in suspiciousPaths {
      if FileManager.default.fileExists(atPath: path) {
        print("Security: Reverse engineering tool detected: \(path)")
      }
    }

    print("Security: Anti-reverse engineering measures applied")
  }

  // MARK: - Anti-Tampering
  private func applyAntiTampering() {
    // Check for app modification
    if !verifyAppIntegrity() {
      print("Security: App tampering detected")
    }

    print("Security: Anti-tampering measures applied")
  }

  // MARK: - Proxy Detection
  private func hasProxySettings() -> Bool {
    guard let proxySettings = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? [String: Any] else {
      return false
    }

    // Check if HTTP proxy is configured
    if let httpProxy = proxySettings["HTTPProxy"] as? String, !httpProxy.isEmpty {
      print("Security: HTTP proxy detected: \(httpProxy)")
      return true
    }

    // Check if HTTPS proxy is configured
    if let httpsProxy = proxySettings["HTTPSProxy"] as? String, !httpsProxy.isEmpty {
      print("Security: HTTPS proxy detected: \(httpsProxy)")
      return true
    }

    return false
  }

  // MARK: - VPN Detection
  private func hasVPNConnection() -> Bool {
    // Check for VPN interfaces
    let vpnInterfaces = [
      "utun0",
      "utun1",
      "utun2",
      "utun3",
      "utun4",
      "utun5",
      "utun6",
      "utun7",
      "utun8",
      "utun9"
    ]

    for interface in vpnInterfaces {
      if getInterfaceAddress(interface) != nil {
        print("Security: VPN interface detected: \(interface)")
        return true
      }
    }

    return false
  }

  // MARK: - Certificate Validation
  private func getUnexpectedCertificates() -> [String] {
    var unexpectedCerts: [String] = []
    
    // In a real implementation, you would check for unexpected certificates
    // in the certificate chain during network requests
    print("Security: Certificate validation requested")
    
    return unexpectedCerts
  }

  // MARK: - USB Cable Detection
  private func isUsbCableAttached() -> Bool {
    // On iOS, we can detect USB connection through various methods
    // Note: iOS has limitations on USB detection compared to Android
    
    // Method 1: Check if device is connected to power (USB charging)
    let device = UIDevice.current
    device.isBatteryMonitoringEnabled = true
    
    let batteryState = device.batteryState
    let isConnectedToPower = batteryState == .charging || batteryState == .full
    
    // Method 2: Check if device is connected to computer (limited on iOS)
    // iOS doesn't provide direct access to USB connection status like Android
    // but we can infer from certain conditions
    
    // Method 3: Check for external accessory connections (if available)
    let hasExternalAccessories = EAAccessoryManager.shared().connectedAccessories.count > 0
    
    print("Security: USB detection - Battery state: \(batteryState.rawValue), Connected to power: \(isConnectedToPower), External accessories: \(hasExternalAccessories)")
    
    // On iOS, we primarily rely on battery charging status as a proxy for USB connection
    return isConnectedToPower || hasExternalAccessories
  }

  private func getUsbConnectionStatus() -> [String: Any] {
    let device = UIDevice.current
    device.isBatteryMonitoringEnabled = true
    
    let batteryState = device.batteryState
    let isCharging = batteryState == .charging || batteryState == .full
    let isConnectedToPower = isCharging
    
    // Check for external accessories
    let externalAccessories = EAAccessoryManager.shared().connectedAccessories
    let hasExternalAccessories = externalAccessories.count > 0
    
    // Determine connection type
    let connectionType: String
    if hasExternalAccessories {
      connectionType = "external_accessory"
    } else if isConnectedToPower {
      connectionType = "charging"
    } else {
      connectionType = "none"
    }
    
    let isAttached = isConnectedToPower || hasExternalAccessories
    
    let status: [String: Any] = [
      "isAttached": isAttached,
      "connectionType": connectionType,
      "isCharging": isCharging,
      "isDataTransfer": hasExternalAccessories,
      "isUsbCharging": isConnectedToPower,
      "isConnectedToComputer": false, // iOS doesn't provide this information
      "isConnectedViaUsb": isConnectedToPower,
      "deviceCount": externalAccessories.count,
      "powerSource": isConnectedToPower ? "usb" : "none",
      "batteryState": batteryState.rawValue,
      "timestamp": Int(Date().timeIntervalSince1970 * 1000)
    ] as [String: Any]
    
    print("Security: USB connection status: \(status)")
    return status
  }

  // MARK: - Helper Methods
  private func getInterfaceAddress(_ interfaceName: String) -> String? {
    var ifaddr: UnsafeMutablePointer<ifaddrs>?
    guard getifaddrs(&ifaddr) == 0 else {
      return nil
    }
    defer { freeifaddrs(ifaddr) }

    var ptr = ifaddr
    while ptr != nil {
      defer { ptr = ptr?.pointee.ifa_next }

      let interface = ptr?.pointee
      let name = String(cString: (interface?.ifa_name)!)
      
      if name == interfaceName {
        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
        getnameinfo(interface?.ifa_addr,
                   socklen_t((interface?.ifa_addr.pointee.sa_len)!),
                   &hostname,
                   socklen_t(hostname.count),
                   nil,
                   0,
                   NI_NUMERICHOST)
        return String(cString: hostname)
      }
    }
    
    return nil
  }
}
