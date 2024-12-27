import 'package:flutter/material.dart';
import 'dart:math'; // Import the dart:math library

class EMICalculator extends StatefulWidget {
  const EMICalculator({super.key});

  @override
  _EMICalculatorState createState() => _EMICalculatorState();
}

class _EMICalculatorState extends State<EMICalculator> {
  final TextEditingController _loanAmountController = TextEditingController();
  final TextEditingController _interestRateController = TextEditingController();
  final TextEditingController _loanTermController = TextEditingController();

  String _currency = 'INR';
  double _monthlyEMI = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'EMI Calculator',
            style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          const SizedBox(height: 20.0),
          _buildInputField(
              'Loan Amount', 'Enter Loan Amount', _loanAmountController),
          _buildInputField('Interest Rate (%)', 'Enter Interest Rate',
              _interestRateController),
          _buildInputField(
              'Loan Term (Years)', 'Enter Loan Term', _loanTermController),
          const SizedBox(height: 20.0),
          const Text(
            'Currency',
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue),
          ),
          Row(
            children: [
              _buildCurrencyOption('INR', '₹'),
              _buildCurrencyOption('Dollars', '\$'),
            ],
          ),
          const SizedBox(height: 20.0),
          Center(
            child: ElevatedButton(
              onPressed: _calculateEMI,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(8.0), // Adjust the radius as needed
                ),
              ),
              child: const Text('Calculate EMI'),
            ),
          ),
          const SizedBox(height: 20.0),
          Center(
            child: Text(
              'Monthly EMI: ${_monthlyEMI.toStringAsFixed(2)} $_currency',
              style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(
      String title, String placeholder, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue),
          ),
          const SizedBox(height: 5.0),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: placeholder,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencyOption(String currency, String symbol) {
    return Expanded(
      child: ListTile(
        title: Text(currency, style: const TextStyle(color: Colors.blue)),
        leading: Radio<String>(
          value: currency,
          groupValue: _currency,
          onChanged: (String? value) {
            setState(() {
              _currency = value!;
            });
          },
        ),
      ),
    );
  }

  void _calculateEMI() {
    double loanAmount = double.parse(_loanAmountController.text);
    double annualInterestRate = double.parse(_interestRateController.text);
    int loanTermYears = int.parse(_loanTermController.text);

    double monthlyInterestRate = annualInterestRate / 12 / 100;
    int loanTermMonths = loanTermYears * 12;

    double emi = loanAmount *
        monthlyInterestRate *
        pow(1 + monthlyInterestRate, loanTermMonths) /
        (pow(1 + monthlyInterestRate, loanTermMonths) - 1);

    setState(() {
      _monthlyEMI = emi;
    });
  }
}
