import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:quote/apiservices/api_services.dart';
import 'package:quote/model/quote_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  QuoteModel? quote;
  bool isLoading = true;
  String? errorMessage; // 🔹 Add this variable to store errors

  @override
  void initState() {
    super.initState();
    fetchQuote();
  }

  Future<void> fetchQuote() async {
    setState(() {
      isLoading = true;
      errorMessage = null; // Reset error before fetching
    });

    try {
      QuoteModel? fetchedQuote = await ApiServices().quoteModel();
      if (fetchedQuote != null) {
        setState(() {
          quote = fetchedQuote;
        });
      } else {
        setState(() {
          errorMessage = "Error: $errorMessage";
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "Error: ${Response}"; // 🔹 Store error message
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splashimg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: isLoading
                ? const CircularProgressIndicator()
                : errorMessage != null
                    ? Text(
                        errorMessage!, // 🔹 Show error message if fetch fails
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '"${quote!.content}"',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '- ${quote!.author}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: fetchQuote,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.pink),
                            child: const Text(
                              "New Quote",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
          ),
        ),
      ),
    );
  }
}
