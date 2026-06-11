import 'package:flutter/material.dart';
import 'ui/core/app_theme.dart';
import 'ui/features/bank_view_model.dart';
import 'ui/features/dashboard/dashboard_view.dart';
import 'ui/features/add_money/add_money_view.dart';
import 'ui/features/profile/profile_view.dart';
import 'ui/features/other_views.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Neobank',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const MainNavigationShell(),
    );
  }
}

class MainNavigationShell extends StatefulWidget {
  const MainNavigationShell({super.key});

  @override
  State<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell> {
  int _currentIndex = 0;
  late final BankViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = BankViewModel();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      DashboardView(
        viewModel: _viewModel,
        onAddMoneyPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddMoneyView(viewModel: _viewModel),
            ),
          );
        },
      ),
      const MapView(),
      TransferView(viewModel: _viewModel),
      const SettingsView(),
      ProfileView(viewModel: _viewModel),
    ];

    return Scaffold(
      body: Stack(
        children: [
          screens[_currentIndex],
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildBottomNavigationBar(),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.charcoal.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
        border: const Border(
          top: BorderSide(color: AppColors.borderLight, width: 1),
        ),
      ),
      padding: const EdgeInsets.only(top: 8, bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(0, Icons.home_filled, Icons.home_outlined, 'Home'),
          _buildNavItem(1, Icons.map, Icons.map_outlined, 'Map'),
          _buildNavItem(2, Icons.swap_horizontal_circle, Icons.swap_horizontal_circle_outlined, 'Transfer'),
          _buildNavItem(3, Icons.settings, Icons.settings_outlined, 'Settings'),
          _buildProfileNavItem(4),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData activeIcon, IconData inactiveIcon, String label) {
    final isSelected = _currentIndex == index;
    final color = isSelected ? AppColors.charcoal : AppColors.textSecondary;
    final icon = isSelected ? activeIcon : inactiveIcon;

    return Expanded(
      child: GestureDetector(
        onTap: () => _onTabSelected(index),
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: color,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                fontFamily: 'Space Grotesk',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileNavItem(int index) {
    final isSelected = _currentIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => _onTabSelected(index),
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.neonLime : Colors.transparent,
                  width: 2.0,
                ),
              ),
              child: const CircleAvatar(
                radius: 11,
                backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&q=80&w=200',
                ),
                backgroundColor: AppColors.neonLime,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Profile',
              style: TextStyle(
                color: isSelected ? AppColors.charcoal : AppColors.textSecondary,
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                fontFamily: 'Space Grotesk',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
