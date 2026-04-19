import 'package:flutter/material.dart';

class BmiCalculatorScreen extends StatefulWidget {
  const BmiCalculatorScreen({Key? key}) : super(key: key);

  @override
  State<BmiCalculatorScreen> createState() => _BmiCalculatorScreenState();
}

class _BmiCalculatorScreenState extends State<BmiCalculatorScreen> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  
  double? _bmi;
  String _category = '';
  
  void _calculateBMI() {
    FocusScope.of(context).unfocus();
    
    final heightText = _heightController.text;
    final weightText = _weightController.text;
    
    if (heightText.isEmpty || weightText.isEmpty) {
      _showSnackBar('Please enter both height and weight');
      return;
    }
    
    final heightCm = double.tryParse(heightText);
    final weightKg = double.tryParse(weightText);
    
    if (heightCm == null || weightKg == null || heightCm <= 0 || weightKg <= 0) {
      _showSnackBar('Please enter valid positive numbers');
      return;
    }
    
    setState(() {
      _bmi = weightKg / ((heightCm / 100) * (heightCm / 100));
      if (_bmi! < 18.5) {
        _category = 'Underweight';
      } else if (_bmi! >= 18.5 && _bmi! <= 24.9) {
        _category = 'Normal';
      } else if (_bmi! >= 25 && _bmi! <= 29.9) {
        _category = 'Overweight';
      } else {
        _category = 'Obese';
      }
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Check your BMI',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Enter your details to get your body mass index',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          _buildTextField(
            controller: _heightController,
            label: 'Height (in cm)',
            icon: Icons.height,
          ),
          const SizedBox(height: 20),
          _buildTextField(
            controller: _weightController,
            label: 'Weight (in kg)',
            icon: Icons.monitor_weight,
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: _calculateBMI,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 18),
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
              elevation: 4,
              shadowColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              'Calculate BMI',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 40),
          AnimatedSize(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutBack,
            child: _bmi != null ? _buildResultCard() : const SizedBox.shrink(),
          ),
          const SizedBox(height: 80), // Padding for floating nav bar
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: TextStyle(color: isDark ? Colors.white : Colors.black87),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
        prefixIcon: Icon(icon, color: Theme.of(context).colorScheme.primary),
        filled: true,
        fillColor: Theme.of(context).cardColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
        ),
      ),
    );
  }

  Widget _buildResultCard() {
    Color categoryColor;
    if (_category == 'Normal') {
      categoryColor = Colors.green;
    } else if (_category == 'Underweight') {
      categoryColor = Colors.blue;
    } else if (_category == 'Overweight') {
      categoryColor = Colors.orange;
    } else {
      categoryColor = Colors.red;
    }

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            categoryColor.withValues(alpha: 0.8),
            categoryColor.withValues(alpha: 0.4),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: categoryColor.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            const Text(
              'Your BMI is',
              style: TextStyle(fontSize: 18, color: Colors.white70, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              _bmi!.toStringAsFixed(1),
              style: const TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [Shadow(color: Colors.black26, blurRadius: 10, offset: Offset(2, 2))],
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _category.toUpperCase(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
