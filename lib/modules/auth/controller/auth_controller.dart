import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../routes/app_routes.dart';

class AuthController extends GetxController {

  // ================= TEXT CONTROLLERS =================
  // SIGNUP
  final signupName = TextEditingController();
  final signupEmail = TextEditingController();
  final signupPhone = TextEditingController();
  final signupPassword = TextEditingController();

  // SIGNIN
  final signinEmail = TextEditingController();
  final signinPassword = TextEditingController();

  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final cnic = TextEditingController();
  final experience = TextEditingController();

  bool isPasswordMatch() {
    return password.text.trim() == confirmPassword.text.trim();
  }

  // FOR FORGOT PASSWORD
  final forgotController = TextEditingController();
  final otpController = TextEditingController();

  // ================= FORM KEYS =================
  final signupFormKey = GlobalKey<FormState>();
  final signinFormKey = GlobalKey<FormState>();
  final forgotFormKey = GlobalKey<FormState>();
  final otpFormKey = GlobalKey<FormState>();
  final setPasswordFormKey = GlobalKey<FormState>();

  // ================= STATE =================
  var isLoading = false.obs;
  var hidePassword = true.obs;

  // ================= CATEGORY =================
  var selectedCategory = "".obs;
  final categoryList = ["Electrician", "Plumber", "Carpenter", "Mechanic"];

  // ================= LOCATION =================
  var provinces = ["Punjab", "Sindh", "KPK"].obs;
  var cities = <String>[].obs;

  var selectedProvince = "".obs;
  var selectedCity = "".obs;
  var selectedLocation = "".obs;

  final Map<String, List<String>> provinceCityMap = {
    "Punjab": ["Lahore", "Faisalabad", "Rawalpindi"],
    "Sindh": ["Karachi", "Hyderabad", "Sukkur"],
    "KPK": ["Peshawar", "Mardan", "Abbottabad"],
  };

  // ================= IMAGE =================
  var profileImage = Rxn<File>();
  final ImagePicker picker = ImagePicker();

  Future<void> pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      profileImage.value = File(picked.path);
    }
  }

  var experienceFile = Rxn<PlatformFile>();
  var policeFile = Rxn<PlatformFile>();
  var cnicFile = Rxn<PlatformFile>();

  Future<void> pickExperienceFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      experienceFile.value = result.files.first;
    }
  }

  Future<void> pickPoliceFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      policeFile.value = result.files.first;
    }
  }

  Future<void> pickCnicFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      cnicFile.value = result.files.first;
    }
  }

  // ================= HELPERS =================
  void togglePassword() => hidePassword.value = !hidePassword.value;

  void setCategory(String value) => selectedCategory.value = value;

  void loadCities(String province) {
    selectedProvince.value = province;
    cities.value = provinceCityMap[province] ?? [];
    selectedCity.value = "";
  }

  void setCity(String city) => selectedCity.value = city;

  void setLocation() {
    selectedLocation.value =
    "${selectedProvince.value}, ${selectedCity.value}";
  }

  void _showError(String msg) {
    Get.snackbar(
      "Error",
      msg,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  void _showSuccess(String msg) {
    Get.snackbar(
      "Success",
      msg,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  // ================= VALIDATION =================
  bool validateExtraFields() {
    if (selectedCategory.value.isEmpty) {
      _showError("Select category");
      return false;
    }

    if (cnicFile.value == null) {
      _showError("Upload CNIC image");
      return false;
    }

    if (experienceFile.value == null) {
      _showError("Upload experience image");
      return false;
    }

    if (policeFile.value == null) {
      _showError("Upload police certificate image");
      return false;
    }

    if (selectedLocation.value.isEmpty) {
      _showError("Select location");
      return false;
    }

    return true;
  }

  // ================= SIGNUP =================
  Future<void> signup() async {
    if (!signupFormKey.currentState!.validate()) {
      _showError("Fix all fields");
      return;
    }

    isLoading.value = true;

    await Future.delayed(const Duration(seconds: 2));

    isLoading.value = false;

    _showSuccess("Signup Completed");
  }

  // ================= REGISTER (EXTRA) =================
  Future<bool> register() async {
    if (!validateExtraFields()) return false;

    isLoading.value = true;

    await Future.delayed(const Duration(seconds: 2));

    isLoading.value = false;

    _showSuccess("Registered Successfully");

    _clearFields();

    Get.offAllNamed(AppRoutes.login);

    return true;
  }

  // ================= FORGOT PASSWORD =================
  Future<void> sendOtp() async {
    if (!forgotFormKey.currentState!.validate()) {
      _showError("Enter valid email or phone");
      return;
    }

    isLoading.value = true;

    await Future.delayed(const Duration(seconds: 2));

    isLoading.value = false;
    _showSuccess("OTP Sent Successfully");
    Get.toNamed(AppRoutes.otp);
  }

  Future<void> verifyOtp() async {
    if (!otpFormKey.currentState!.validate()) {
      _showError("Enter valid OTP");
      return;
    }

    isLoading.value = true;

    await Future.delayed(const Duration(seconds: 2));

    isLoading.value = false;
    _showSuccess("OTP Verified");
    Get.toNamed(AppRoutes.resetPassword);
  }
  Future<void> resetPassword() async {
    if (!setPasswordFormKey.currentState!.validate()) {
      _showError("Fix password fields");
      return;
    }

    if (!isPasswordMatch()) {
      _showError("Passwords do not match");
      return;
    }

    isLoading.value = true;

    await Future.delayed(const Duration(seconds: 2));

    isLoading.value = false;
    _showSuccess("Password Set Successfully");
    Get.offAllNamed(AppRoutes.login);
  }
  Future<bool> signin() async {
    final form = signinFormKey.currentState;

    if (form == null || !form.validate()) {
      _showError("Fix all fields");
      return false;
    }

    isLoading.value = true;

    await Future.delayed(const Duration(seconds: 2));

    isLoading.value = false;

    _showSuccess("Login Successful");

    return true;
  }

  // ================= RESET =================
  void _clearFields() {
    signupName.clear();
    signupEmail.clear();
    signupPhone.clear();
    signupPassword.clear();
    signinEmail.clear();
    signinPassword.clear();

    name.clear();
    email.clear();
    phone.clear();
    password.clear();
    cnic.clear();
    experience.clear();
    forgotController.clear();

    selectedCategory.value = "";
    selectedProvince.value = "";
    selectedCity.value = "";
    selectedLocation.value = "";

    profileImage.value = null;
    cnicFile.value = null;
    experienceFile.value = null;
    policeFile.value = null;
    cities.clear();
  }

  // ================= CLEANUP =================
  @override
  void onClose() {
    signupName.dispose();
    signupEmail.dispose();
    signupPhone.dispose();
    signupPassword.dispose();
    signinEmail.dispose();
    signinPassword.dispose();

    name.dispose();
    email.dispose();
    phone.dispose();
    password.dispose();
    cnic.dispose();
    experience.dispose();
    forgotController.dispose();
    otpController.dispose();
    super.onClose();
  }
}