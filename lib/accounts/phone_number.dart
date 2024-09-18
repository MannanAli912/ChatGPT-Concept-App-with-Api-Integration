import 'package:chatbot/accounts/verify_number.dart';
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';

class CountryCodeSelector extends StatefulWidget {
  @override
  _CountryCodeSelectorState createState() => _CountryCodeSelectorState();
}

class _CountryCodeSelectorState extends State<CountryCodeSelector> {
  String selectedCountryCode = '+1'; // Default country code
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Logo
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Image.asset(
                  "assets/images/chatgpt.png",
                  height: 70,
                ),
              ),
            ),
            const SizedBox(
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  "Verify your phone number",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),

            // Country code and phone number input fields
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
              child: Row(
                children: [
                  // Country Code Picker
                  Container(
                    width: 100,
                    height: 55,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: CountryCodePicker(
                      onChanged: (CountryCode countryCode) {
                        setState(() {
                          selectedCountryCode = countryCode.toString();
                        });
                      },
                      initialSelection: 'US', // Default to US
                      favorite: const ['US', 'IN', 'GB', 'PK'], // Favorites
                      showCountryOnly: false,
                      showOnlyCountryWhenClosed: false,
                      alignLeft: true,
                      textStyle: const TextStyle(
                        color: Colors.white, // Country code text color
                      ),
                      flagWidth: 25.0, // Set flag size
                    ),
                  ),

                  const SizedBox(
                      width:
                          15), // Spacing between country code and phone number

                  // Phone Number Input Field
                  Expanded(
                    child: Container(
                      height: 55,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              selectedCountryCode,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const VerticalDivider(
                            width: 1,
                            thickness: 1,
                            color: Colors.white,
                          ),
                          Expanded(
                            child: TextField(
                              controller: phoneController,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                border: InputBorder.none,
                                hintText: 'Phone Number',
                                hintStyle: TextStyle(
                                  color: Colors.white70,
                                ),
                              ),
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Disclaimer Text
            const SizedBox(
              child: Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  "We will send you a one time SMS message",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ),

            // Send OTP Button
            SizedBox(
              width: 300,
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: ElevatedButton(
                  onPressed: () {
                    // Check if the phone number is entered
                    if (phoneController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter your phone number'),
                        ),
                      );
                      return;
                    }
                    // Proceed to OTP verification page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Verify(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: Colors.white, width: 1),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      "Send OTP",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
