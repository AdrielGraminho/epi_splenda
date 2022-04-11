import 'package:flutter/material.dart';
import 'package:splenda_epi/components/public/Button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Colors.white,
            Color.fromARGB(255, 254, 204, 22),
          ],
              stops: [
            0.7,
            1
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * 0.4,
                child:
                    const Image(image: AssetImage('images/logo_splenda.png')),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: Column(
                    children: [
                      const TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), hintText: 'E-mail'),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(), hintText: 'Senha'),
                        ),
                      ),
                      Button(label: "Entrar", function: () => print("clicou")),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
