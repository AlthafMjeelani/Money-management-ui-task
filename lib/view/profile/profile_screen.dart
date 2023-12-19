import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:demotask/controller/profile/profile_controller.dart';
import 'package:demotask/helper/core/app_spacing.dart';
import 'package:demotask/widgets/aler_dialoage.dart';
import 'package:demotask/widgets/textfeild_widget.dart';

class ScreenProfile extends StatelessWidget {
  const ScreenProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context, listen: false);
    profile.image = null;
    profile.isEditing = false;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      profile.getData();

      Provider.of<ProfileProvider>(context, listen: false).getProfileImage(
        FirebaseAuth.instance.currentUser!.email.toString(),
      );
    });
    return Scaffold(
      appBar: AppBar(actions: const [Icon(Icons.logout),AppSpacing.ksizedBoxW15]),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Form(
            key: profile.formKey,
            child: Consumer(builder:
                (BuildContext context, ProfileProvider profile, Widget? child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Consumer(
                    builder: (BuildContext context, ProfileProvider value,
                        Widget? child) {
                      return value.isLoading
                          ? const Padding(
                              padding: EdgeInsets.only(left: 30, top: 20),
                              child: CupertinoActivityIndicator(
                                color: Colors.cyan,
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                SimpleDialogWidget.alertDialog(context);
                              },
                              child: Stack(
                                children: [
                                  value.image == null
                                      ? value.downloadUrl == null
                                          ? CircleAvatar(
                                              backgroundColor: Colors.black38,
                                              radius: 70,
                                              child: TextButton.icon(
                                                onPressed: () {
                                                  SimpleDialogWidget
                                                      .alertDialog(context);
                                                },
                                                icon: const Icon(
                                                  Icons.image,
                                                  color: Colors.black,
                                                ),
                                                label: const Text(
                                                  'No Image',
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                            )
                                          : CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                value.downloadUrl!,
                                              ),
                                              radius: 70,
                                            )
                                      : CircleAvatar(
                                          backgroundImage: FileImage(
                                            File(value.image!.path),
                                          ),
                                          radius: 70,
                                        ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(top: 110.0, left: 100),
                                    child: Icon(
                                      Icons.camera_alt_outlined,
                                      size: 32,
                                    ),
                                  )
                                ],
                              ),
                            );
                    },
                  ),
                  AppSpacing.ksizedBoxW5,
                  TextfeildWidget(
                    readOnly: false,
                    validator: (value) =>
                        profile.validation(value, "Enter Your Name"),
                    text: 'Enter Name',
                    icon: Icons.abc,
                    controller: profile.nameController,
                    suffixIcon: IconButton(
                      onPressed: () {
                        profile.isEditing = true;
                      },
                      icon: const Icon(Icons.edit),
                    ),
                  ),
                  AppSpacing.ksizedBox20,
                  TextfeildWidget(
                    keyboardType: TextInputType.phone,
                    readOnly: false,
                    validator: (value) => profile.phoneValidation(value),
                    text:
                        profile.userModel?.mob.toString() != 'No Mobile Number'
                            ? 'Mobile Number'
                            : 'No Mobile Number',
                    icon: Icons.abc,
                    controller: profile.mobController,
                    suffixIcon: IconButton(
                      onPressed: () {
                        profile.isEditing = true;
                      },
                      icon: const Icon(Icons.edit),
                    ),
                  ),
                  AppSpacing.ksizedBox20,
                  TextfeildWidget(
                    readOnly: true,
                    validator: (value) {
                      return;
                    },
                    text: 'email id',
                    icon: Icons.abc,
                    controller: profile.emailController,
                  ),
                  AppSpacing.ksizedBox15,
                  TextfeildWidget(
                    readOnly: true,
                    validator: (value) {
                      return;
                    },
                    text: 'dob',
                    icon: Icons.abc,
                    controller: profile.dobController,
                    suffixIcon: Consumer(
                      builder: (context, ProfileProvider value, child) {
                        return InkWell(
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime.now());

                            if (pickedDate != null) {
                              log(pickedDate
                                  .toString()); //pickedDate output format => 2021-03-10 00:00:00.000
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              log(formattedDate);
                              value.setDob(
                                  formattedDate); //formatted date output using intl package =>  2021-03-16
                            } else {}
                          },
                          child: const Icon(
                            Icons.date_range,
                          ),
                        );
                      },
                    ),
                  ),
                  AppSpacing.ksizedBox25,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Consumer<ProfileProvider>(
                        builder: (BuildContext context, value, Widget? child) {
                          return value.isLoading
                              ? const CupertinoActivityIndicator(
                                  color: Colors.cyan,
                                )
                              : ElevatedButton(
                                  onPressed: () async {
                                    await profile.submitUpdate(
                                        FirebaseAuth.instance.currentUser!.email
                                            .toString(),
                                        context);
                                    profile.getData();
                                  },
                                  

                                  child: const Text('      Save     '),
                                );
                        },
                      ),
                    ],
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
