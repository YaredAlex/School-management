import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:school_managment/common/widget/button/primary_button.dart';
import 'package:school_managment/common/widget/cliper/custom_cliper.dart';
import 'package:school_managment/common/widget/error/error_dialog.dart';
import 'package:school_managment/features/auth/controller/sign_controller.dart';
import 'package:school_managment/features/auth/view/foreget_pass.dart';
import 'package:school_managment/util/image_constant.dart';
import 'package:school_managment/util/sizes.dart';
import 'package:school_managment/util/constants/text/texts.dart';
import 'package:school_managment/util/validator/input_validator.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class Signin extends StatelessWidget {
  Signin({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SignInController signInController = Get.put(SignInController());
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
          SizedBox(
            height: 150,
            width: 150,
            child: Image(
              image: AssetImage(CImageConstant.logo2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: CSizes.itemSpacing, horizontal: CSizes.defaultSpace),
            child: Form(
              key: _formKey,
              child: Obx(
                () => Column(
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
                    if (signInController.errorMessage.value != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: InlineErrorMessage(
                            message:
                                signInController.errorMessage.value ?? "Error"),
                      ),
                    const SizedBox(
                      height: CSizes.itemSpacing,
                    ),
                    IntlPhoneField(
                      decoration: InputDecoration(
                        errorText: signInController.phoneError.value,
                        labelText: CTexts.phoneNumber,
                      ),
                      initialCountryCode: 'ET',

                      disableLengthCheck: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      countries: countries
                          .where((c) => c.code == 'ET')
                          .toList(), // ETH
                      onChanged: (phone) {
                        if (phone.completeNumber == "") {
                          signInController.phoneError.value =
                              "Invalid phone number";
                        } else {
                          signInController.phoneError.value = null;
                        }
                        signInController.phone = phone.completeNumber;
                      },
                      validator: (phone) {
                        return validatePhoneNumber(phone?.number ?? '');
                      },
                    ),
                    const SizedBox(
                      height: CSizes.itemSpacing,
                    ),
                    TextFormField(
                      onChanged: (value) => signInController.password = value,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Iconsax.password_check),
                        hintText: CTexts.passwordHint,
                        suffixIcon: IconButton(
                          icon: Icon(
                            signInController.obscureText.value
                                ? Iconsax.eye_slash
                                : Iconsax.eye,
                          ),
                          onPressed: () {
                            signInController.obscureText.value =
                                !signInController.obscureText.value;
                          },
                        ),
                      ),
                      obscureText: signInController.obscureText.value,
                      validator: validatePassword,
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
                    PrimaryButton(
                      text: CTexts.login,
                      isLoading: signInController.isLoading.value,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (signInController.phone == null ||
                              signInController.phone == "") {
                            signInController.phoneError.value =
                                "Invalid phone number";
                          } else {
                            signInController.phoneError.value = null;
                            signInController.login(
                              signInController.phone.toString(),
                              signInController.password,
                            );
                          }
                        } else {
                          signInController.phoneError.value =
                              "Invalid phone number";
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
