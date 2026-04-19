import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import 'bmi_calculator_screen.dart';
import 'activity_tracker_screen.dart';
import 'tips_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const BmiCalculatorScreen(),
    const ActivityTrackerScreen(),
    TipsScreen(),
  ];

  final List<String> _titles = [
    'BMI Analyzer',
    'Activity Tracker',
    'Fitness Tips',
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBody: true, // Allows body to extend behind the floating nav bar
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
      drawer: const AppDrawer(),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.05, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          );
        },
        child: KeyedSubtree(
          key: ValueKey<int>(_currentIndex),
          child: _screens[_currentIndex],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 24, left: 16, right: 16),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: isDark ? Colors.black45 : Colors.black12,
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: _onTabTapped,
              backgroundColor: Colors.transparent,
              elevation: 0,
              selectedItemColor: Theme.of(context).colorScheme.primary,
              unselectedItemColor: isDark ? Colors.white54 : Colors.grey,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(Icons.calculate_outlined),
                  activeIcon: _buildActiveIcon(Icons.calculate, context),
                  label: 'BMI',
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.directions_run_outlined),
                  activeIcon: _buildActiveIcon(Icons.directions_run, context),
                  label: 'Activity',
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.lightbulb_outline),
                  activeIcon: _buildActiveIcon(Icons.lightbulb, context),
                  label: 'Tips',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActiveIcon(IconData icon, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.15),
        shape: BoxShape.circle,
      ),
      child: Icon(icon),
    );
  }
}
