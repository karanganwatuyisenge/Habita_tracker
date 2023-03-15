import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tracker_habit/authentication/login.dart';
import 'package:dio/dio.dart';
import 'package:tracker_habit/city.dart';
import 'package:tracker_habit/country.dart';
import 'package:tracker_habit/region.dart';

class Location extends StatefulWidget {
  const Location({Key? key}) : super(key: key);

  @override
  State<Location> createState() => LocationState();
}

class LocationState extends State<Location> {
  // String _selectedValue = 'Rwanda';
  // final List<String> _options = ['Rwanda', 'Kenya', 'Tanzania', 'Uganda', 'Burundi',];

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  List<Country> _country = [];
  Country? _selectedCountry;
  List<Region> _region = [];
  Region? _selectedRegion;
  List<City> _city = [];
  City? _selectedCity;

  @override
  void initState() {
    super.initState();
    fetchCountries();
  }

  fetchCountries() async {
    final response = await Dio().get(
      'https://wft-geo-db.p.rapidapi.com/v1/geo/countries',
      options: Options(
        headers: {
          'X-RapidAPI-Key':
              '1c5c14744fmsha74fb3aaae95219p1e43d2jsnbf987ff4ee8e',
          'X-RapidAPI-Host': 'wft-geo-db.p.rapidapi.com',
        },
      ),
    );
    final jsonData = response.data;
    List<Country> countries = [];
    for (var country in jsonData['data']) {
      var item = Country.fromJson(country);
      print(item.wikiDataId);
      countries.add(item);
    }
    setState(() {
      _country = countries;
    });
    //print("length ${_country.length}");
  }

  fetchRegions(String wikiDataId) async {
    final response = await Dio().get(
      'https://wft-geo-db.p.rapidapi.com/v1/geo/countries/$wikiDataId/regions',
      options: Options(
        headers: {
          'X-RapidAPI-Key':
              '1c5c14744fmsha74fb3aaae95219p1e43d2jsnbf987ff4ee8e',
          'X-RapidAPI-Host': 'wft-geo-db.p.rapidapi.com',
        },
      ),
    );
    final jsonData = response.data;
    List<Region> regions = [];
    for (var region in jsonData['data']) {
      var item = Region.fromJson(region);
      regions.add(item);
    }
    setState(() {
      _region = regions;
    });
  }

  fetchCities(String isoCode, String wikiDataId) async {
    final response = await Dio().get(
      'https://wft-geo-db.p.rapidapi.com/v1/geo/countries/$wikiDataId/regions/$isoCode/cities',
      options: Options(
        headers: {
          'X-RapidAPI-Key':
              '1c5c14744fmsha74fb3aaae95219p1e43d2jsnbf987ff4ee8e',
          'X-RapidAPI-Host': 'wft-geo-db.p.rapidapi.com',
        },
      ),
    );
    final jsonData = response.data;
    List<City> cities = [];
    for (var city in jsonData['data']) {
      var item = City.fromJson(city);
      cities.add(item);
    }
    setState(() {
      _city = cities??[];
    });
    return cities;
  }

  void _Register() async {
    print("Signing up...");
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .set({
        'name': _nameController.text,
        'email': _emailController.text,
      });
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      print("Exception here ${e.code}");
      if (e.code == 'weak-password') {
        print('The password provided is too weak');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else {
        print(e.message);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    //print("length ${_country.length}");
    return Scaffold(
        backgroundColor: const Color(0xFFEDEDED),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 88.0,
              left: 25.0,
              right: 25.0,
            ),
            child: ClipRect(
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Geolocation',
                        style: TextStyle(
                          color: Color(0xff4c505b),
                          fontSize: 27,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Row(
                        children: [
                          TextButton(
                            child: const Text(
                              'Log In',
                              style: TextStyle(color: Colors.deepOrangeAccent),
                            ),
                            onPressed: () {
                              // print('Login');
                              Navigator.of(context).pushNamed('login');
                            },
                          ),
                          Container(
                            child: IconButton(
                              color: Colors.deepOrangeAccent,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const MyLogin()));
                              },
                              icon: const Icon(Icons.arrow_forward_ios),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your name';
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField<Country>(
                    isExpanded: true,
                    decoration: InputDecoration(
                        labelText: 'Country',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    value: _selectedCountry,
                    hint: const Text('Country'),
                    items: _country
                        .map((e) =>
                            DropdownMenuItem(value: e, child: Text(e.name)))
                        .toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedCountry = newValue;
                      });
                      fetchRegions(newValue!.wikiDataId);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField<Region>(
                    isExpanded: true,
                    decoration: InputDecoration(
                        labelText: 'Region',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    value: _selectedRegion,
                    hint: const Text('Region'),
                    items: _region.isNotEmpty
                        ? _region
                            .map((e) =>
                                DropdownMenuItem(value: e, child: Text(e.name)))
                            .toList()
                        : [],
                    onChanged: (newValue) async {
                      setState(() {
                        _selectedRegion = newValue;
                      });
                      var cities = await fetchCities(
                          newValue!.isoCode, newValue.countryCode);
                      setState(() {
                        _city = cities;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField<City>(
                    isExpanded: true,
                    decoration: InputDecoration(
                        labelText: 'City',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    value: _selectedCity,
                    hint: const Text('City'),
                    items: _city.isNotEmpty
                        ? _city
                            .map((e) =>
                                DropdownMenuItem(value: e, child: Text(e.name)))
                            .toList()
                        : [],
                    onChanged: (newValue) async {

                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter yur confirm password';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50), // NEW
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _Register();
                      }
                    },
                    child: const Text('Sign Up'),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

