import 'package:flutter/material.dart';
import 'package:school_managment/util/constants/colors/colors.dart';
import 'package:school_managment/util/sizes.dart';

class ForgetPassScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CColors.primary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(CSizes.defaultSpace),
          child: Column(
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
                "Resetting your password is very easy, just tell us your user id and date of birth you registered with.",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(
                height: CSizes.itemSpacing,
              ),

              TextField(
                decoration: const InputDecoration(
                  hintText: "StudentId",
                ),
                controller: TextEditingController(),
              ),
              const SizedBox(
                height: CSizes.itemSpacing,
              ),
              BirthDateInput(),
              const SizedBox(
                height: CSizes.defaultSpace,
              ),
              //Next
              SizedBox(
                height: 50,
                width: double.infinity,
                child:
                    ElevatedButton(onPressed: () {}, child: const Text("Next")),
              )
            ],
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
