import 'package:bronzed_blue/main.dart';
import 'package:bronzed_blue/repository.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({
    Key? key,
  }) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

late bool _mail;
late bool _pass;

final emailController = TextEditingController();
final passwordController = TextEditingController();
final nameController = TextEditingController();
final numberController = TextEditingController();
bool _emptyEmail = false;
bool _emptyPass = false;

bool _emptyName = false;
bool _emptyNumber = false;
bool _passwordVisible = false;
bool _hidePassword = true;

bool loading = false;

String _email = '';
String _password = '';
String _name = '';
String _number = '';

class _RegisterState extends State<Register> {
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
                      Center(child: Text('Registering, Please Wait')),
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
                            height: 150,
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
                              keyboardType: TextInputType.name,
                              onChanged: (value) {
                                setState(() {
                                  _name = value.trim();
                                });
                              },
                              controller: nameController,
                              decoration: InputDecoration(
                                errorText: _emptyName ? 'Required' : null,
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
                                labelText: "Username",
                                labelStyle: const TextStyle(
                                    color: Colors.black, fontSize: 14),
                                contentPadding: const EdgeInsets.all(8),
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
                              controller: emailController,
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: width - 20,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              _number = value.trim();
                            });
                          },
                          controller: numberController,
                          decoration: InputDecoration(
                            errorText: _emptyNumber ? 'Required' : null,
                            hintStyle: const TextStyle(fontSize: 13),
                            enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.0),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0),
                            ),
                            border: const OutlineInputBorder(),
                            labelText: "Mobile Number",
                            labelStyle: const TextStyle(
                                color: Colors.black, fontSize: 14),
                            contentPadding: const EdgeInsets.all(8),
                            prefixIcon: const Icon(
                              Icons.phone,
                              color: Colors.black,
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
                            _onRegisterButtonPressed();
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
                                'Register',
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
                                        builder: (context) =>
                                            const MyHomePage()));
                              },
                              child: const Text("Already Registered? Log In ")),
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
    if (reg.hasMatch(emailController.text)) {
      return true;
    } else if (emailController.text.isEmpty) {
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

  void _onRegisterButtonPressed() async {
    ApiRepository apiRepository = ApiRepository();
    if (_validatePassword() &&
        _validateEmail() &&
        (emailController.text.isNotEmpty &&
            passwordController.text.isNotEmpty)) {
      setState(() {
        loading = true;
      });

      try {
        var response = await apiRepository.registerUser(
            email: emailController.text,
            mobileNumber: numberController.text,
            password: passwordController.text,
            username: nameController.text);

        if (response.success == true) {
          setState(() {
            loading = false;
          });

          //move to next page

          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const MyHomePage()));
        } else {
          setState(() {
            loading = false;
          });
          AlertDialog(
            scrollable: true,
            contentPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
            title: const Text(
              "Register Failed",
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
            "Register Failed",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          content: Text(e.toString()),
          actions: const <Widget>[],
        );
      }
    } else if (emailController.text.isEmpty &&
        passwordController.text.isEmpty) {
      setState(() {
        _emptyEmail = true;
        _emptyPass = true;
      });
    } else if (emailController.text.isEmpty) {
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
