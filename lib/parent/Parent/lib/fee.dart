import 'package:flutter/material.dart';

class FeeDetails {
  final String title;
  final String cost;

  FeeDetails({required this.title, required this.cost});
}

class FeeDashboard extends StatefulWidget {
  const FeeDashboard({super.key});

  @override
  State<FeeDashboard> createState() => _FeeDashboardState();
}

class _FeeDashboardState extends State<FeeDashboard> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController =
      TextEditingController(text: 'Sittal Lamichhane');
  final TextEditingController _symbolController =
      TextEditingController(text: '1203456');
  final TextEditingController _classController =
      TextEditingController(text: '10');

  bool _isTotalFeeExpanded = false;

  List<FeeDetails> allCosts = [
    FeeDetails(title: "Tuition Fee", cost: "20000"),
    FeeDetails(title: "Transportation Fee", cost: "4500"),
    FeeDetails(title: "Exam Fee", cost: "3700"),
    FeeDetails(title: "Extra Fee", cost: "9900"),
    FeeDetails(title: "Discount", cost: "3500"),
    FeeDetails(title: "Total", cost: "0"),
  ];

  int paidAmount = 30000;

  int calculateTotalFee() {
    int sumFees = 0;
    int discount = 0;
    for (var fee in allCosts) {
      if (fee.title.toLowerCase() == 'discount') {
        discount = int.tryParse(fee.cost) ?? 0;
      } else if (fee.title.toLowerCase() != 'total') {
        sumFees += int.tryParse(fee.cost) ?? 0;
      }
    }
    return sumFees - discount;
  }

  @override
  Widget build(BuildContext context) {
    int totalFee = calculateTotalFee();
    int remainingAmount = totalFee - paidAmount;
    if (remainingAmount < 0) remainingAmount = 0;

    allCosts = allCosts.map((fee) {
      if (fee.title.toLowerCase() == 'total') {
        return FeeDetails(title: fee.title, cost: totalFee.toString());
      }
      return fee;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fee Dashboard'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text("Student Information",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              _buildEditableField(
                  "Full Name", _nameController, Icons.person_outline),
              _buildEditableField("Symbol No", _symbolController,
                  Icons.badge_outlined,
                  isNumber: true),
              _buildEditableField(
                  "Class", _classController, Icons.school_outlined,
                  isNumber: true),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Student information saved')),
                    );
                  }
                },
                icon: const Icon(Icons.save),
                label: const Text("Save Info",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 30),
              const Text("Fee Summary",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 3,
                child: ExpansionTile(
                  initiallyExpanded: _isTotalFeeExpanded,
                  onExpansionChanged: (expanded) =>
                      setState(() => _isTotalFeeExpanded = expanded),
                  leading: const CircleAvatar(
                    child: Icon(Icons.account_balance_wallet,
                        color: Colors.blue),
                  ),
                  title: const Text("Total Fee",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text("Rs. $totalFee",
                      style: const TextStyle(color: Colors.blue)),
                  trailing: Icon(
                    _isTotalFeeExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  children: allCosts
                      .map((fee) => ListTile(
                            title: Text(fee.title),
                            trailing: Text("Rs. ${fee.cost}"),
                          ))
                      .toList(),
                ),
              ),
              _feeCard("Paid", "Rs. $paidAmount", Icons.check_circle,
                  Colors.green),
              _feeCard("Remaining", "Rs. $remainingAmount",
                  Icons.warning_amber_rounded, Colors.redAccent),
              const SizedBox(height: 30),
              Center(
                child: Column(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EsewaQRPage()),
                        );
                      },
                      icon: const Icon(Icons.account_balance_wallet),
                      label: const Text("Pay with eSewa",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text("Secured by eSewa",
                        style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditableField(
      String label, TextEditingController controller, IconData icon,
      {bool isNumber = false}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: TextFormField(
          controller: controller,
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          decoration: InputDecoration(
            icon: Icon(icon),
            labelText: label,
            border: InputBorder.none,
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter $label';
            }
            if (label == "Class") {
              final classNum = int.tryParse(value);
              if (classNum == null || classNum < 1 || classNum > 8) {
                return 'Class must be between 1semester and 8semester';
              }
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _feeCard(
      String title, String amount, IconData icon, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: ListTile(
        leading: CircleAvatar(child: Icon(icon, color: color)),
        title:
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle:
            Text(amount, style: TextStyle(fontSize: 16, color: color)),
        trailing: const Icon(Icons.arrow_forward_ios,
            size: 16, color: Colors.grey),
      ),
    );
  }
}

class EsewaQRPage extends StatelessWidget {
  const EsewaQRPage({super.key});

  @override
  Widget build(BuildContext context) {
    const String phone = '9824988806';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan to Pay - eSewa'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Scan this QR Code to Pay via eSewa",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green, width: 3),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  'esewa.jpg',
                  height: 250,
                  width: 250,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 30),
              Text("Mobile Number: $phone",
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                label: const Text("Back to FeeDashboard"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
