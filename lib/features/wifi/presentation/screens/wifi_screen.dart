import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../data/repositories/wifi_repository_impl.dart';
import '../../domain/entities/wifi_credentials.dart';
import '../../domain/repositories/wifi_repository.dart';

/// Screen for WiFi auto-login configuration
class WifiScreen extends StatefulWidget {
  const WifiScreen({super.key});

  @override
  State<WifiScreen> createState() => _WifiScreenState();
}

class _WifiScreenState extends State<WifiScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late final WifiRepository _repository;

  bool _isLoading = false;
  bool _saveCredentials = false;
  bool _autoLogin = false;
  bool _obscurePassword = true;
  WifiLoginResult? _connectionStatus;
  bool _hasStoredCredentials = false;

  @override
  void initState() {
    super.initState();
    _repository = WifiRepositoryImpl();
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    setState(() => _isLoading = true);

    try {
      // Load saved credentials
      final credentials = await _repository.getCredentials();
      if (credentials != null && credentials.hasCredentials) {
        _usernameController.text = credentials.username;
        _passwordController.text = credentials.password;
        _hasStoredCredentials = true;
        _saveCredentials = true;
      }

      // Load auto-login preference
      _autoLogin = await _repository.isAutoLoginEnabled();

      // Check current status
      _connectionStatus = await _repository.checkStatus();
    } catch (e) {
      _connectionStatus = WifiLoginResult.disconnected();
    }

    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final credentials = WifiCredentials(
        username: _usernameController.text.trim(),
        password: _passwordController.text,
        autoLogin: _autoLogin,
      );

      // Save credentials if requested
      if (_saveCredentials) {
        await _repository.saveCredentials(credentials);
        await _repository.setAutoLogin(_autoLogin);
        _hasStoredCredentials = true;
      }

      // Attempt login
      final result = await _repository.login(credentials);
      _connectionStatus = result;

      if (mounted) {
        _showStatusMessage(result);
      }
    } catch (e) {
      _connectionStatus = WifiLoginResult.failed('An error occurred');
      if (mounted) {
        _showStatusMessage(_connectionStatus!);
      }
    }

    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _handleLogout() async {
    setState(() => _isLoading = true);

    try {
      _connectionStatus = await _repository.logout();
    } catch (e) {
      _connectionStatus = WifiLoginResult.disconnected();
    }

    if (mounted) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logged out from campus WiFi')),
      );
    }
  }

  Future<void> _handleClearCredentials() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Credentials'),
        content: const Text(
          'Are you sure you want to remove saved WiFi credentials?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Clear'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await _repository.deleteCredentials();
      _usernameController.clear();
      _passwordController.clear();
      setState(() {
        _hasStoredCredentials = false;
        _saveCredentials = false;
        _autoLogin = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Credentials cleared')),
        );
      }
    }
  }

  void _showStatusMessage(WifiLoginResult result) {
    final Color bgColor;
    switch (result.status) {
      case WifiConnectionStatus.connected:
      case WifiConnectionStatus.alreadyLoggedIn:
        bgColor = AppColors.success;
        break;
      case WifiConnectionStatus.failed:
        bgColor = AppColors.error;
        break;
      default:
        bgColor = AppColors.info;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(result.message ?? 'Status updated'),
        backgroundColor: bgColor,
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WiFi'),
        actions: [
          if (_hasStoredCredentials)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: _handleClearCredentials,
              tooltip: 'Clear saved credentials',
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header card
              _buildHeaderCard(),
              const SizedBox(height: 24),

              // Status card
              _buildStatusCard(),
              const SizedBox(height: 16),

              // Credentials card
              _buildCredentialsCard(),
              const SizedBox(height: 24),

              // Action buttons
              _buildActionButtons(),
              const SizedBox(height: 24),

              // Info card
              _buildInfoCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFFFBBC05).withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.wifi_rounded,
                size: 32,
                color: Color(0xFFFBBC05),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Campus WiFi',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Connect to IIT Palakkad network',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard() {
    final status = _connectionStatus;
    final Color statusColor;
    final IconData statusIcon;
    final String statusText;

    if (_isLoading && status == null) {
      statusColor = AppColors.textSecondary;
      statusIcon = Icons.sync;
      statusText = 'Checking...';
    } else if (status == null) {
      statusColor = AppColors.textSecondary;
      statusIcon = Icons.help_outline;
      statusText = 'Unknown';
    } else {
      switch (status.status) {
        case WifiConnectionStatus.connected:
        case WifiConnectionStatus.alreadyLoggedIn:
          statusColor = AppColors.success;
          statusIcon = Icons.check_circle;
          statusText = status.ipAddress != null
              ? 'Connected (${status.ipAddress})'
              : 'Connected';
          break;
        case WifiConnectionStatus.connecting:
          statusColor = AppColors.warning;
          statusIcon = Icons.sync;
          statusText = 'Connecting...';
          break;
        case WifiConnectionStatus.failed:
          statusColor = AppColors.error;
          statusIcon = Icons.error;
          statusText = 'Connection Failed';
          break;
        case WifiConnectionStatus.disconnected:
        default:
          statusColor = AppColors.textSecondary;
          statusIcon = Icons.wifi_off;
          statusText = 'Not Connected';
      }
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: AppColors.info,
                ),
                const SizedBox(width: 8),
                Text(
                  'Connection Status',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.refresh, size: 20),
                  onPressed: _isLoading ? null : _loadSavedData,
                  tooltip: 'Refresh status',
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: statusColor.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(statusIcon, color: statusColor, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      statusText,
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCredentialsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'WiFi Credentials',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                hintText: 'Enter your network username',
                prefixIcon: Icon(Icons.person_outline),
              ),
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your username';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your network password',
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                  onPressed: () {
                    setState(() => _obscurePassword = !_obscurePassword);
                  },
                ),
              ),
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _handleLogin(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            CheckboxListTile(
              value: _saveCredentials,
              onChanged: (value) {
                setState(() {
                  _saveCredentials = value ?? false;
                  if (!_saveCredentials) {
                    _autoLogin = false;
                  }
                });
              },
              title: const Text('Save credentials'),
              subtitle: const Text('Store securely on device'),
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
            ),
            if (_saveCredentials)
              CheckboxListTile(
                value: _autoLogin,
                onChanged: (value) {
                  setState(() => _autoLogin = value ?? false);
                },
                title: const Text('Enable auto-login'),
                subtitle: const Text('Automatically connect when on campus'),
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    final isConnected = _connectionStatus?.isSuccess == true;

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _isLoading ? null : _handleLogin,
            icon: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.login),
            label: Text(_isLoading ? 'Connecting...' : 'Connect to WiFi'),
          ),
        ),
        if (isConnected) ...[
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _isLoading ? null : _handleLogout,
              icon: const Icon(Icons.logout),
              label: const Text('Disconnect'),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.info.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.info.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline,
            color: AppColors.info,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'How it works',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppColors.info,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  '1. Connect to "IITPKD" WiFi network\n'
                  '2. Enter your campus credentials\n'
                  '3. Tap "Connect to WiFi" to login\n'
                  '4. Enable auto-login for automatic connection',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.5,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
