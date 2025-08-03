import 'package:flutter/material.dart';
import 'network_error_handler.dart';

/// Comprehensive troubleshooting guide for network issues
class NetworkTroubleshootingGuide extends StatelessWidget {
  final NetworkErrorInfo? errorInfo;

  const NetworkTroubleshootingGuide({
    super.key,
    this.errorInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Network Troubleshooting'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildErrorSummary(),
            const SizedBox(height: 24),
            _buildPaisaNetworkExceptionSection(),
            const SizedBox(height: 24),
            _buildGeneralTroubleshootingSection(),
            const SizedBox(height: 24),
            _buildAdvancedSolutionsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorSummary() {
    if (errorInfo == null) return const SizedBox.shrink();

    return Card(
      elevation: 4,
      color: _getErrorColor(errorInfo!.type).withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  _getErrorIcon(errorInfo!.type),
                  color: _getErrorColor(errorInfo!.type),
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  'Current Error: ${_getErrorTitle(errorInfo!.type)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _getErrorColor(errorInfo!.type),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              errorInfo!.message,
              style: const TextStyle(fontSize: 14),
            ),
            if (errorInfo!.errorCode != null) ...[
              const SizedBox(height: 8),
              Text(
                'Error Code: ${errorInfo!.errorCode}',
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: 'monospace',
                  color: Colors.grey,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPaisaNetworkExceptionSection() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.warning, color: Colors.orange[600], size: 24),
                const SizedBox(width: 8),
                const Text(
                  'PaisaNetworkException Solutions',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSolutionItem(
              '1. Check Internet Connection',
              'Ensure your device has a stable internet connection. Try switching between WiFi and mobile data.',
              Icons.wifi,
            ),
            _buildSolutionItem(
              '2. Restart Network Services',
              'Turn off WiFi/mobile data for 10 seconds, then turn it back on. This can resolve DNS cache issues.',
              Icons.refresh,
            ),
            _buildSolutionItem(
              '3. Clear DNS Cache',
              'On Android: Go to Settings > Network & Internet > WiFi > Advanced > Reset to factory defaults.\nOn iOS: Go to Settings > General > Reset > Reset Network Settings.',
              Icons.dns,
            ),
            _buildSolutionItem(
              '4. Check Google Play Services',
              'The Paisa service is part of Google Play Services. Try updating or clearing Google Play Services cache.',
              Icons.android,
            ),
            _buildSolutionItem(
              '5. VPN/Proxy Issues',
              'If using VPN or proxy, try disabling it temporarily. Some VPNs can interfere with Google services.',
              Icons.vpn_key,
            ),
            _buildSolutionItem(
              '6. Firewall/Antivirus',
              'Check if your firewall or antivirus software is blocking the connection to Google services.',
              Icons.security,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGeneralTroubleshootingSection() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.build, color: Colors.blue[600], size: 24),
                const SizedBox(width: 8),
                const Text(
                  'General Network Troubleshooting',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSolutionItem(
              'Check Network Status',
              'Verify that your device can access other websites and apps that require internet.',
              Icons.network_check,
            ),
            _buildSolutionItem(
              'Restart Device',
              'A simple restart can resolve many network-related issues.',
              Icons.power_settings_new,
            ),
            _buildSolutionItem(
              'Update App',
              'Ensure you have the latest version of the app, as updates often include network fixes.',
              Icons.system_update,
            ),
            _buildSolutionItem(
              'Check App Permissions',
              'Verify that the app has permission to access the internet.',
              Icons.security,
            ),
            _buildSolutionItem(
              'Try Different Network',
              'Test the app on a different WiFi network or mobile data to isolate the issue.',
              Icons.network_wifi,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdvancedSolutionsSection() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.engineering, color: Colors.purple[600], size: 24),
                const SizedBox(width: 8),
                const Text(
                  'Advanced Solutions',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSolutionItem(
              'DNS Configuration',
              'Try changing your DNS server to Google DNS (8.8.8.8, 8.8.4.4) or Cloudflare DNS (1.1.1.1).',
              Icons.settings,
            ),
            _buildSolutionItem(
              'Network Reset',
              'As a last resort, reset all network settings on your device (this will remove saved WiFi passwords).',
              Icons.restore,
            ),
            _buildSolutionItem(
              'Contact Support',
              'If the issue persists, contact the app support team with the error details.',
              Icons.support_agent,
            ),
            _buildSolutionItem(
              'Check System Status',
              'Verify that Google services are not experiencing outages.',
              Icons.monitor_heart,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSolutionItem(String title, String description, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.blue[600], size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getErrorColor(NetworkErrorType type) {
    switch (type) {
      case NetworkErrorType.noNetworkConnection:
        return Colors.orange;
      case NetworkErrorType.dnsResolutionFailed:
        return Colors.red;
      case NetworkErrorType.timeout:
        return Colors.amber;
      case NetworkErrorType.serverError:
        return Colors.red;
      case NetworkErrorType.sslError:
        return Colors.red;
      case NetworkErrorType.unknown:
        return Colors.grey;
    }
  }

  IconData _getErrorIcon(NetworkErrorType type) {
    switch (type) {
      case NetworkErrorType.noNetworkConnection:
        return Icons.wifi_off;
      case NetworkErrorType.dnsResolutionFailed:
        return Icons.dns;
      case NetworkErrorType.timeout:
        return Icons.timer_off;
      case NetworkErrorType.serverError:
        return Icons.error_outline;
      case NetworkErrorType.sslError:
        return Icons.security;
      case NetworkErrorType.unknown:
        return Icons.help_outline;
    }
  }

  String _getErrorTitle(NetworkErrorType type) {
    switch (type) {
      case NetworkErrorType.noNetworkConnection:
        return 'No Internet Connection';
      case NetworkErrorType.dnsResolutionFailed:
        return 'DNS Resolution Failed';
      case NetworkErrorType.timeout:
        return 'Request Timeout';
      case NetworkErrorType.serverError:
        return 'Server Error';
      case NetworkErrorType.sslError:
        return 'SSL Error';
      case NetworkErrorType.unknown:
        return 'Unknown Error';
    }
  }
}

/// Quick troubleshooting actions widget
class QuickTroubleshootingActions extends StatelessWidget {
  final VoidCallback? onRetryConnection;
  final VoidCallback? onShowTroubleshootingGuide;

  const QuickTroubleshootingActions({
    super.key,
    this.onRetryConnection,
    this.onShowTroubleshootingGuide,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onRetryConnection,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry Connection'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onShowTroubleshootingGuide,
                    icon: const Icon(Icons.help),
                    label: const Text('Troubleshooting'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 