import 'package:flutter/material.dart';
import 'package:flutter_application_3/Screens/Screen2.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
         
            Row(
              
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(padding:EdgeInsets.fromLTRB(5, 50, 5, 100) ),
                Text(
                  'W',
                  style: TextStyle(
                    color:  Color.fromARGB(255, 228, 32, 32),
                    fontSize: 70,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'Weather\nApp',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            SizedBox(height: 50),

            Image.asset(
              'assets/Images/06509ff97ca4966e34e878881cc49db475d84799.png',
              width: 150,
              height: 150,
            ),
            SizedBox(height: 30),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: const Color.fromARGB(255, 212, 206, 206),
                        size: 25,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      fillColor:  Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 15),
                ElevatedButton(
                  onPressed: () {
                    String city = _searchController.text;
                    if (city.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Screen2(cityName: city),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please enter a city name')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 10, 60, 122),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  ),
                  child: Text('Check'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
