import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    fetchQuote();
  }

  Future<void> fetchQuote() async {
    setState(() => isLoading = true);
    QuoteModel? fetchedQuote = await ApiServices().quoteModel();
    setState(() {
      quote = fetchedQuote;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height;
    // double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Quote"),
      //   centerTitle: true,
      //   backgroundColor: Colors.blue,
      // ),
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
                : quote != null
                    ? Column(
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
                            child: Text(
                              "New Quote",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      )
                    : const Text(
                        "Failed to load quote",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
          ),
        ),
      ),
    );
  }
}
