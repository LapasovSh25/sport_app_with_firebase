import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:sport_app_with_api/helpers/show_message_helper.dart';
import 'package:sport_app_with_api/provider/auth/sing_in_provider.dart';
import 'package:sport_app_with_api/view/auth/sing_up_page.dart';
import 'package:sport_app_with_api/view/pages/bottomNavigationPage.dart';

class SingInPage extends StatefulWidget {
  const SingInPage({super.key});

  @override
  State<SingInPage> createState() => _SingInPageState();
}

class _SingInPageState extends State<SingInPage> {
  bool isChecked = false;
  bool _isVisible = false;

  void updateStatus() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return const Color.fromRGBO(146, 146, 157, 1);
      }
      return Colors.purple;
    }

    return ChangeNotifierProvider(
      create: (context) => SingInProvider(),
      builder: (context, child) {
        return _scaffold(getColor, context);
      },
    );
  }

  Scaffold _scaffold(
      Color getColor(Set<MaterialState> states), BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromRGBO(40, 51, 63, 1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Image.asset('assets/logotip.png')],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          const Text(
            "Log in",
            style: TextStyle(
                color: Colors.white, fontSize: 21, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: TextFormField(
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.emailAddress,
              controller: context.watch<SingInProvider>().emailController,
              decoration: InputDecoration(
                fillColor: const Color.fromRGBO(47, 60, 80, 1),
                hintText: "Email",
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: TextFormField(
              style: const TextStyle(color: Colors.white),
              obscureText: _isVisible ? false : true,
              enableInteractiveSelection: true,
              controller: context.watch<SingInProvider>().passwordController,
              decoration: InputDecoration(
                  fillColor: const Color.fromRGBO(47, 60, 80, 1),
                  hintText: "Password",
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () => updateStatus(),
                    icon: Icon(
                      _isVisible
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: const Color.fromRGBO(123, 97, 255, 1),
                    ),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Checkbox(
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                ),
                const Text(
                  "Remember Me",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.17,
                ),
                const Text(
                  "Forgot Password ?",
                  style: TextStyle(
                      color: Color.fromRGBO(123, 97, 255, 1),
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          InkWell(
            onTap: () async {
              await context.read<SingInProvider>().singIn().then((value) {
                if (value == true && value == isChecked) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PageBottomNavigation(),
                      ));
                }
              });
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.87,
              height: MediaQuery.of(context).size.height * 0.08,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromRGBO(123, 97, 255, 1)),
              child: Center(
                child: !context.watch<SingInProvider>().isLoading
                    ? const Text(
                        "Log in",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      )
                    : const CircularProgressIndicator.adaptive(),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                "____________",
                style: TextStyle(
                    color: Color.fromRGBO(75, 87, 107, 1),
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
              ),
              const Text(
                "Or continue with",
                style: TextStyle(
                    color: Color.fromRGBO(75, 87, 107, 1),
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
              ),
              const Text(
                "____________",
                style: TextStyle(
                    color: Color.fromRGBO(75, 87, 107, 1),
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: MediaQuery.of(context).size.height * 0.1,
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: AssetImage('assets/Google-logo.png')),
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromRGBO(47, 60, 80, 1)),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: MediaQuery.of(context).size.height * 0.1,
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: AssetImage('assets/Facebook-logo.png')),
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromRGBO(47, 60, 80, 1)),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: MediaQuery.of(context).size.height * 0.1,
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: AssetImage('assets/Twitter-logo.png')),
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromRGBO(47, 60, 80, 1)),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.07,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'New User? ',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SingUpPage(),
                      ));
                },
                child: const Text(
                  "Sing Up",
                  style: TextStyle(
                      color: Color.fromRGBO(123, 97, 255, 1),
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
