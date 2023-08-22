import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DecimalFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final regex = RegExp(r'^\d+\.?\d*$');
    final newString = regex.stringMatch(newValue.text) ?? '';
    return newString == newValue.text ? newValue : oldValue;
  }
}

class MaterialHomePage extends StatefulWidget {
  const MaterialHomePage({super.key});

  @override
  State<MaterialHomePage> createState() => _MaterialHomePage();
}

class _MaterialHomePage extends State<MaterialHomePage> {
  double result = 0;
  final textController = TextEditingController();

  @override
  void initState() {
    // super.initState() should be called first then other state should be initialized
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    // super.dispose() should be called at last, first we need to dispose other controllers, streams futures etc.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: const BorderSide(
        color: Color.fromRGBO(0, 0, 0, 0.75),
        width: 2.5,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '₹$result',
              style: const TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              controller: textController,
              decoration: InputDecoration(
                hintText: 'Please enter amount in USD',
                hintStyle: TextStyle(
                  color: Colors.grey[500],
                ),
                prefixIcon: const Icon(
                  Icons.monetization_on_outlined,
                  size: 32,
                  color: Colors.black,
                ),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: border,
                focusedBorder: border,
                contentPadding: const EdgeInsets.all(18),
              ),
              style: const TextStyle(
                fontSize: 17,
                color: Colors.black,
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: false,
              ),
              cursorColor: Colors.black,
              inputFormatters: [DecimalFormatter()],
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  result = double.parse((double.parse(textController.text) * 81)
                      .toStringAsFixed(2));
                });
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                fixedSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Convert',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
