import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_managment/common/widget/cliper/custom_cliper.dart';
import 'package:school_managment/features/auth/controller/sign/signin_controller.dart';
import 'package:school_managment/features/auth/view/forget_pass/view/foreget_pass.dart';
import 'package:school_managment/util/image_constant.dart';
import 'package:school_managment/util/sizes.dart';
import 'package:school_managment/util/text/texts.dart';

class Signin extends StatelessWidget {
  Signin({super.key});
  final signinController = Get.put(SigninController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          ClipPath(
            clipper: CCustomShape(radius: 30),
            child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(CImageConstant.loginImg),
                      fit: BoxFit.cover)),
              height: 350,
            ),
          ),
          const SizedBox(
            height: 150,
            width: 150,
            child: Image(
              image: AssetImage(CImageConstant.logo),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: CSizes.itemSpacing, horizontal: CSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    CTexts.welcome,
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: CSizes.itemSpacing,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: CTexts.idHint,
                  ),
                ),
                const SizedBox(
                  height: CSizes.itemSpacing,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    hintText: CTexts.passwordHint,
                  ),
                ),
                const SizedBox(
                  height: CSizes.mdSpace,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      Get.to(() => ForgetPassScreen());
                    },
                    child: Text(CTexts.forgetPass,
                        style: Theme.of(context).textTheme.bodySmall),
                  ),
                ),
                const SizedBox(
                  height: CSizes.mdSpace,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        signinController.signinUser();
                      },
                      child: Text(CTexts.login)),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
