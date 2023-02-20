import 'package:bronzed_blue/register.dart';
import 'package:bronzed_blue/repository.dart';
import 'package:bronzed_blue/show_users.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bronzed Blue',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

bool _mail = false;
bool _pass = false;
final usernameController = TextEditingController();
final passwordController = TextEditingController();
bool _emptyEmail = false;
bool _emptyPass = false;
bool _passwordVisible = false;
bool _hidePassword = true;

String _email = '';
String _password = '';

bool loading = false;

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    setState(() {
      _mail = false;
      _pass = false;
      _emptyEmail = false;
      _emptyPass = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Visibility(
                  visible: loading,
                  child: Column(
                    children: const [
                      SizedBox(
                        height: 200,
                      ),
                      Center(
                          child:
                              Text('Checking your Credentials, Please Wait')),
                    ],
                  )),
              Visibility(
                visible: loading == false ? true : false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "BronzedBlue",
                            style: TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 45),
                          ),
                          SizedBox(
                            height: 200,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: width - 20,
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              validator: (input) => !input!.contains('@')
                                  ? "Email address should be valid"
                                  : null,
                              onChanged: (value) {
                                setState(() {
                                  _email = value.trim();
                                  print(_email);
                                });
                              },
                              controller: usernameController,
                              decoration: InputDecoration(
                                errorText: _emptyEmail ? 'Required' : null,
                                hintStyle: const TextStyle(fontSize: 13),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1.0),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.0),
                                ),
                                border: const OutlineInputBorder(),
                                labelText: "Enter Email",
                                labelStyle: const TextStyle(
                                    color: Colors.black, fontSize: 14),
                                contentPadding: const EdgeInsets.all(8),
                                prefixIcon: const Icon(
                                  Icons.email,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: width - 20,
                        child: TextFormField(
                          obscureText: _hidePassword,
                          validator: (input) => input!.length < 3
                              ? "Password should be more than 3 characters"
                              : null,
                          onChanged: (value) {
                            setState(() {
                              _validateEmail();
                              setState(() {
                                _emptyEmail = false;
                              });
                              if (value.length == null) {
                                setState(() {
                                  _mail = false;
                                });
                              } else {
                                if (_validateEmail() == false) {
                                  setState(() {
                                    _mail = true;
                                  });
                                } else {
                                  setState(() {
                                    _mail = false;
                                  });
                                }
                              }
                              _validatePassword();
                              setState(() {
                                _emptyPass = false;
                              });
                              if (value.length == null) {
                                setState(() {
                                  _pass = false;
                                });
                              } else {
                                if (_validatePassword() == false) {
                                  setState(() {
                                    _pass = true;
                                  });
                                } else {
                                  setState(() {
                                    _pass = false;
                                  });
                                }
                              }
                            });
                          },
                          controller: passwordController,
                          decoration: InputDecoration(
                            hintStyle: const TextStyle(fontSize: 13),
                            errorText: _emptyPass ? 'Required' : null,
                            enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.0),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.0),
                            ),
                            border: const OutlineInputBorder(),
                            labelText: "Password",
                            labelStyle: const TextStyle(
                                color: Colors.black, fontSize: 14),
                            contentPadding: const EdgeInsets.all(8),
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Colors.black,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _hidePassword = !_hidePassword;
                                });
                              },
                              color: Colors.black,
                              icon: Icon(
                                _hidePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            _onLoginButtonPressed();
                          },
                          style: OutlinedButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Colors.black,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                side: BorderSide(color: Colors.black)),
                          ),
                          child: Container(
                            width: width * 0.3,
                            child: const Center(
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => const Register()));
                            },
                            child: const Text("Not Registered? "),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _validateEmail() {
    var reg = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (reg.hasMatch(usernameController.text)) {
      return true;
    } else if (usernameController.text.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool _validatePassword() {
    if (passwordController.text.length > 5) {
      return true;
    } else if (passwordController.text.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void _onLoginButtonPressed() async {
    ApiRepository apiRepository = ApiRepository();
    if (_validatePassword() &&
        _validateEmail() &&
        (usernameController.text.isNotEmpty &&
            passwordController.text.isNotEmpty)) {
      setState(() {
        loading = true;
      });

      try {
        var response = await apiRepository.authenticateUser(
            email: usernameController.text, password: passwordController.text);

        if (response.status == true) {
          setState(() {
            loading = false;
          });
          var welcomeMsg = response.message;

          //move to next page

          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => ShowLists()));
        } else {
          setState(() {
            loading = false;
          });
          AlertDialog(
            scrollable: true,
            contentPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
            title: const Text(
              "User Login Failed",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            content: Text(response.message),
            actions: const <Widget>[],
          );
        }
      } catch (e) {
        setState(() {
          loading = false;
        });
        AlertDialog(
          scrollable: true,
          contentPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
          title: const Text(
            "User Login Failed",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          content: Text(e.toString()),
          actions: const <Widget>[],
        );
      }
    } else if (usernameController.text.isEmpty &&
        passwordController.text.isEmpty) {
      setState(() {
        _emptyEmail = true;
        _emptyPass = true;
      });
    } else if (usernameController.text.isEmpty) {
      setState(() {
        _emptyEmail = true;
      });
    } else if (passwordController.text.isEmpty) {
      setState(() {
        _emptyPass = true;
      });
    } else {}
  }
}
