import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tracker_habit/authentication/login.dart';
import 'package:dio/dio.dart';
import 'package:tracker_habit/models/country.dart';
import 'package:tracker_habit/models/city.dart';
import 'package:tracker_habit/models/region.dart';
import '../constants/contstants.dart';
import '../geolocation.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _MySignupState();
}

class _MySignupState extends State<SignUp> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _regionController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  List<Country> _country = [];
  Country? _selectedCountry;
  List<Region> _region = [];
  Region? _selectedRegion;
  List<City> _city = [];
  City? _selectedCity;
  bool _isLoadingSignUp = false;
  bool _isLoadingCountry = false;
  bool _isLoadingRegion = false;
  bool _showPassword = false;
  bool _showConfirmPassword=false;


  @override
  void initState() {
    super.initState();
    fetchCountries();
  }

  fetchCountries() async {
    final response = await Dio().get(
      'https://wft-geo-db.p.rapidapi.com/v1/geo/countries',
      //'https://wft-geo-db.p.rapidapi.com/v1/geo/countries?namePrefix=R',
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

  Future<bool> _Register() async {
    setState(() {
      _isLoadingSignUp = true;
    });
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .set({
        'name': _nameController.text,
        'email': _emailController.text,
        'country': _selectedCountry?.name,
        'region': _selectedRegion?.name,
        'city': _selectedCity?.name,
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Saved successfully')));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyLogin()),
      );
    }
    on FirebaseAuthException catch (e) {
      print("Exception here ${e.code}");
      if (e.code == 'weak-password') {
        print('The password provided is too weak');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('The password provided is too weak')));
      }
      else if (e.code == 'email-already-in-use') {
       // print('The account already exists for that email.');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('The account already exists for that email')));
      } else if (e.code == 'invalid-email') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('The email address is badly formatted')));
      }
      else {
        print(e.message);
      }
    }
    catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please Fill All Fields')));
    }
    finally {
      setState(() {
        _isLoadingSignUp = false;
      });
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    //print("length ${_country.length}");
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'SignUp'.tr(),
                style: const TextStyle(
                  color: Color(0xff4c505b),
                  fontSize: 27,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(
                children: [
                  TextButton(
                    child: Text(
                      'LogIn'.tr(),
                      style: const TextStyle(color: Colors.deepOrangeAccent),
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
        ),
        body:Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                      key: const Key('nameField'),
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Name'.tr(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'pleaseEnterYourName'.tr();
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    key: const Key('emailField'),
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email'.tr(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'pleaseEnterYourEmail'.tr();
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _isLoadingCountry
                      ? const Center(child: CircularProgressIndicator())
                      : DropdownButtonFormField<Country>(
                    key: const Key('countryField'),

                    decoration: InputDecoration(
                        labelText: 'Country'.tr(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    value: _selectedCountry,
                    hint:  Text('Country'.tr()),
                    items: _country
                        .map((e) =>
                        DropdownMenuItem(value: e, child: Text(e.name)))
                        .toList(),
                    // onChanged: (newValue) {
                    //   setState(() {
                    //     _selectedCountry = newValue;
                    //     _isLoading=true;
                    //   });
                    //   fetchRegions(newValue!.wikiDataId);
                    onChanged: (newValue) {
                      setState(() {
                        _selectedCountry = newValue;
                        _isLoadingCountry = true;
                      });
                      fetchRegions(newValue!.wikiDataId).then((_) {
                        setState(() {
                          _isLoadingCountry = false;
                        });
                      });

                    },
                    validator: (value) => value == null ? 'PleaseSelectCountry' .tr(): null,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _isLoadingRegion
                      ? const Center(child: CircularProgressIndicator())
                      : DropdownButtonFormField<Region>(
                    key: const Key('regionField'),

                    decoration: InputDecoration(
                        labelText: 'Region'.tr(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    value: _selectedRegion,
                    hint: Text('Region'.tr()),
                    items: _region.isNotEmpty
                        ? _region
                        .map((e) =>
                        DropdownMenuItem(value: e, child: Text(e.name)))
                        .toList()
                        : [],
                    onChanged: (newValue) async {
                      setState(() {
                        _selectedRegion = newValue;
                        _isLoadingRegion = true;
                      });
                      var cities = await fetchCities(newValue!.isoCode, newValue.countryCode);
                      setState(() {
                        _city = cities;
                        _isLoadingRegion = false;
                      });
                    },


                    // onChanged: (newValue) async {
                    //   setState(() {
                    //     _selectedRegion = newValue;
                    //   });
                    //   var cities = await fetchCities(
                    //       newValue!.isoCode, newValue.countryCode);
                    //   setState(() {
                    //     _city = cities;
                    //   });
                    // },
                    validator: (value) => value == null ? 'PleaseSelectRegion'.tr() : null,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField<City>(
                    key: const Key('cityField'),
                    decoration: InputDecoration(
                        labelText: 'City'.tr(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    value: _selectedCity,
                    hint: Text('City'.tr()),
                    items: _city.isNotEmpty
                        ? _city
                        .map((e) =>
                        DropdownMenuItem(value: e, child: Text(e.name)))
                        .toList()
                        : [],
                    onChanged: (newValue) async {
                      setState(() {
                        _selectedCity=newValue;
                      });
                    },
                    validator: (value) => value == null ? 'PleaseSelectCity'.tr() : null,

                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    key: const Key('passwordField'),
                    controller: _passwordController,
                    obscureText: ! _showPassword,
                    decoration: InputDecoration(
                        labelText: 'Password'.tr(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _showPassword ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'PleaseEnterYourPassword'.tr();
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    key: const Key('confirmField'),
                    controller: _confirmPasswordController,
                    obscureText: ! _showConfirmPassword,
                    decoration: InputDecoration(
                        labelText: 'ConfirmPassword'.tr(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _showConfirmPassword ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _showConfirmPassword = !_showConfirmPassword;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == "") {
                        return 'PleaseEnterYourConfirmPassword'.tr();
                      }
                      if (value != _passwordController.text) {
                        return 'PasswordDoNotMatch'.tr();
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  _isLoadingSignUp
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50), // NEW
                    ),
                    onPressed: () async {
                      if(_formKey.currentState!.validate()){
                        _Register();
                      }
                    },
                    child: Text('SignUp'.tr()),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}