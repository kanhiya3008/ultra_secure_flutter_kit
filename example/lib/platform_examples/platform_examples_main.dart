import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'android_security_example.dart';
import 'ios_security_example.dart';
import 'macos_security_example.dart';
import 'linux_security_example.dart';
import 'windows_security_example.dart';
import 'web_security_example.dart';

/// Main platform examples navigation screen
/// Provides access to all platform-specific security examples
class PlatformExamplesMain extends StatelessWidget {
  const PlatformExamplesMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Platform Security Examples'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepPurple.shade50, Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderCard(),
              const SizedBox(height: 24),
              _buildPlatformCards(context),
              const SizedBox(height: 24),
              _buildInfoCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade400, Colors.deepPurple.shade600],
          ),
        ),
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.security, color: Colors.white, size: 32),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Ultra Secure Flutter Kit',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Platform-Specific Security Examples',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Explore comprehensive security features tailored for each platform',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlatformCards(BuildContext context) {
    final platforms = [
      _PlatformInfo(
        name: 'Android',
        description:
            'Root detection, secure storage, SSL pinning, biometric auth',
        icon: Icons.android,
        color: Colors.green,
        route: const AndroidSecurityExample(),
        isAvailable: Platform.isAndroid,
      ),
      _PlatformInfo(
        name: 'iOS',
        description: 'Jailbreak detection, Face ID/Touch ID, secure enclave',
        icon: Icons.phone_iphone,
        color: Colors.blue,
        route: const IOSSecurityExample(),
        isAvailable: kIsWeb,
      ),
      _PlatformInfo(
        name: 'macOS',
        description: 'System Integrity Protection, Touch ID, secure storage',
        icon: Icons.computer,
        color: Colors.grey[800]!,
        route: const MacOSSecurityExample(),
        isAvailable: kIsWeb,
      ),
      _PlatformInfo(
        name: 'Linux',
        description:
            'Root access detection, package manager security, containers',
        icon: Icons.computer,
        color: Colors.orange,
        route: const LinuxSecurityExample(),
        isAvailable: kIsWeb,
      ),
      _PlatformInfo(
        name: 'Windows',
        description: 'Windows Defender integration, BitLocker, Windows Hello',
        icon: Icons.desktop_windows,
        color: Colors.blue[700]!,
        route: const WindowsSecurityExample(),
        isAvailable: kIsWeb,
      ),
      _PlatformInfo(
        name: 'Web',
        description: 'Browser security, web storage protection, SSL pinning',
        icon: Icons.web,
        color: Colors.indigo,
        route: const WebSecurityExample(),
        isAvailable: kIsWeb,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Available Platforms',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 16),
        ...platforms.map((platform) => _buildPlatformCard(context, platform)),
      ],
    );
  }

  Widget _buildPlatformCard(BuildContext context, _PlatformInfo platform) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: platform.isAvailable
            ? () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => platform.route),
              )
            : null,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: platform.isAvailable
                  ? platform.color.withOpacity(0.3)
                  : Colors.grey.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: platform.isAvailable
                      ? platform.color.withOpacity(0.1)
                      : Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  platform.icon,
                  color: platform.isAvailable ? platform.color : Colors.grey,
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          platform.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: platform.isAvailable
                                ? Colors.grey[800]
                                : Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (platform.isAvailable)
                          Icon(
                            Icons.check_circle,
                            color: platform.color,
                            size: 20,
                          )
                        else
                          Icon(Icons.cancel, color: Colors.grey, size: 20),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      platform.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: platform.isAvailable
                            ? Colors.grey[600]
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                platform.isAvailable ? Icons.arrow_forward_ios : Icons.lock,
                color: platform.isAvailable ? platform.color : Colors.grey,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info_outline, color: Colors.blue[600], size: 24),
                const SizedBox(width: 12),
                Text(
                  'About Platform Examples',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoRow(
              'Security Features',
              'Each platform example demonstrates comprehensive security features including root/jailbreak detection, secure storage, SSL pinning, and more.',
            ),
            const SizedBox(height: 12),
            _buildInfoRow(
              'Platform-Specific',
              'Examples are tailored to each platform\'s unique security capabilities and requirements.',
            ),
            const SizedBox(height: 12),
            _buildInfoRow(
              'Real-time Monitoring',
              'All examples include real-time threat detection and security status monitoring.',
            ),
            const SizedBox(height: 12),
            _buildInfoRow(
              'Interactive Testing',
              'Use the test buttons in each example to verify security features are working correctly.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(fontSize: 13, color: Colors.grey[600], height: 1.4),
        ),
      ],
    );
  }
}

class _PlatformInfo {
  final String name;
  final String description;
  final IconData icon;
  final Color color;
  final Widget route;
  final bool isAvailable;

  _PlatformInfo({
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
    required this.route,
    required this.isAvailable,
  });
}
