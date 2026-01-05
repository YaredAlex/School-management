import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_managment/common/widget/button/primary_button.dart';
import 'package:school_managment/common/widget/error/error_dialog.dart';
import 'package:school_managment/features/auth/controller/forget_pass_controller.dart';
import 'package:school_managment/util/constants/colors/colors.dart';
import 'package:school_managment/util/routes/routes.dart';
import 'package:school_managment/util/sizes.dart';
import 'package:school_managment/util/validator/input_validator.dart';

class ForgetPassScreen extends StatelessWidget {
  ForgetPasswordCtrl ctrl = Get.put(ForgetPasswordCtrl());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CColors.primary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(CSizes.defaultSpace),
          child: Form(
            key: _formKey,
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Title
                  Text(
                    "Password recovery",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: CSizes.itemSpacing,
                  ),
                  Text(
                    "Resetting your password is very easy, just tell us your email and your receive new password.",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(
                    height: CSizes.itemSpacing,
                  ),
                  if (ctrl.errorMessage.value != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: InlineErrorMessage(
                          message: ctrl.errorMessage.value ?? "Error"),
                    ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Email",
                    ),
                    onChanged: (value) => ctrl.email = value,
                    validator: validateEmail,
                  ),
                  // const SizedBox(
                  //   height: CSizes.itemSpacing,
                  // ),
                  // BirthDateInput(),
                  const SizedBox(
                    height: CSizes.defaultSpace,
                  ),

                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: PrimaryButton(
                      text: "Reset",
                      isLoading: ctrl.isLoading.value,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (ctrl.email == null || ctrl.email == "") {
                            ctrl.emailError.value = "Invalid email";
                          } else {
                            ctrl.emailError.value = null;
                            ctrl.resetPassword(
                              ctrl.email.toString(),
                            );
                          }
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        Get.toNamed(CRoutes.signin);
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: CColors.primary, width: 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text("Back"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BirthDateInput extends StatelessWidget {
  final TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: dateController,
      decoration: const InputDecoration(
        hintText: "Birth Date",
        suffixIcon: Icon(Icons.calendar_today),
      ),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1990),
          lastDate: DateTime.now(),
        );

        if (pickedDate != null) {
          dateController.text = "${pickedDate.toLocal()}".split(' ')[0];
        }
      },
    );
  }
}
