import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/auth_service.dart';
import '../../services/dio_client.dart';

class AuthProvider extends ChangeNotifier {

  final AuthService _authService = AuthService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;

  bool _rememberMe = false;
  bool get rememberMe => _rememberMe;


  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _fullNameError;
  String? get fullNameError => _fullNameError;

  String? _usernameError;
  String? get usernameError => _usernameError;

  String? _emailError;
  String? get emailError => _emailError;

  String? _passwordError;
  String? get passwordError => _passwordError;

  String? _confirmPasswordError;
  String? get confirmPasswordError => _confirmPasswordError;

  String? _serverError;
  String? get serverError => _serverError;

  //---------------------------------------
  // Controllers
  //---------------------------------------

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController fullNameController =
  TextEditingController();

  final TextEditingController usernameController =
  TextEditingController();

  final TextEditingController confirmPasswordController =
  TextEditingController();

  final TextEditingController _recoveryEmailController =
  TextEditingController();

  TextEditingController get recoveryEmailController =>
      _recoveryEmailController;


  final List<TextEditingController> _otpControllers =
  List.generate(6, (_) => TextEditingController());

  List<TextEditingController> get otpControllers =>
      _otpControllers;

  //---------------------------------------

  void togglePassword() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void toggleRememberMe(bool? value){
    _rememberMe=value??!_rememberMe;
    notifyListeners();
  }


  //---------------------------------------
  // LOGIN
  //---------------------------------------
  Future<bool> login() async {
    clearError();

    bool hasError = false;

    final email = emailController.text.trim();
    final password = passwordController.text;

    // Email Validation
    if (email.isEmpty) {
      _emailError = "Email is required";
      hasError = true;
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(email)) {
      _emailError = "Enter a valid email";
      hasError = true;
    }

    // Password Validation
    if (password.isEmpty) {
      _passwordError = "Password is required";
      hasError = true;
    }

    if (hasError) {
      notifyListeners();
      return false;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final response = await _authService.login(
        email: email,
        password: password,
      );
      print("Login Provider");
      debugPrint(response.toString());

      if (response.data["success"] == true) {
        final accessToken =
            response.data["accessToken"] ?? response.data["token"];
        final refreshToken = response.data["refreshToken"];

        DioClient.setToken(accessToken);

        if (_rememberMe) {
          final pref = await SharedPreferences.getInstance();
          await pref.setString("token", accessToken);

          if (refreshToken != null) {
            await pref.setString("refreshToken", refreshToken);
          }
        }

        _isLoading = false;
        notifyListeners();
        return true;
      }

      _serverError = response.data["message"] ?? "Login failed";
    } on DioException catch (e) {
      debugPrint("Login Ex: ");
      debugPrint(e.toString());
      if (e.response != null) {
        _serverError =
            e.response?.data["message"] ?? "Login failed";
      } else {
        _serverError = "Unable to connect to server";
      }
    } catch (e) {
      _serverError = e.toString();
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  //---------------------------------------
  // SIGNUP
  //---------------------------------------
  Future<bool> signup() async {
    clearError();

    bool hasError = false;

    final fullName = fullNameController.text.trim();
    final username = usernameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    // Full Name
    if (fullName.isEmpty) {
      _fullNameError = "Full name is required";
      hasError = true;
    }

    // Username
    if (username.isEmpty) {
      _usernameError = "Username is required";
      hasError = true;
    } else if (username.length < 3) {
      _usernameError = "Username must be at least 3 characters";
      hasError = true;
    }

    // Email
    if (email.isEmpty) {
      _emailError = "Email is required";
      hasError = true;
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(email)) {
      _emailError = "Enter a valid email";
      hasError = true;
    }

    // Password
    if (password.isEmpty) {
      _passwordError = "Password is required";
      hasError = true;
    } else if (password.length < 8) {
      _passwordError = "Password must be at least 8 characters";
      hasError = true;
    }

    // Confirm Password
    if (confirmPassword.isEmpty) {
      _confirmPasswordError = "Confirm password is required";
      hasError = true;
    } else if (password != confirmPassword) {
      _confirmPasswordError = "Passwords do not match";
      hasError = true;
    }

    if (hasError) {
      notifyListeners();
      return false;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final response = await _authService.signup(
        fullName: fullName,
        username: username,
        email: email,
        password: password,
      );

      _isLoading = false;

      if (response.data["success"] == true) {
        notifyListeners();
        return true;
      }

      _serverError = response.data["message"] ?? "Signup failed";
      notifyListeners();
      return false;
    } on DioException catch (e) {
      _isLoading = false;
      debugPrint("Exception ");
      debugPrint(e.toString());


      if (e.response != null) {
        final message =
            e.response?.data["message"] ?? "Signup failed";


        if (message.toLowerCase().contains("email")) {
          _emailError = message;
        } else if (message.toLowerCase().contains("username")) {
          _usernameError = message;
        } else {
          _serverError = message;
        }
      } else {
        _serverError = "Unable to connect to server";
      }

      notifyListeners();
      return false;
    } catch (e) {
      _isLoading = false;
      _serverError = e.toString();
      notifyListeners();
      return false;
    }
  }
  Future<bool> verifyOtp() async {
    clearError();

    final otp = otpControllers.map((e) => e.text).join();

    if (otp.length != 6) {
      _serverError = "OTP must be 6 digits";
      notifyListeners();
      return false;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final response = await _authService.verifyOtp(
        email: emailController.text.trim(),
        otp: otp,
      );

      _isLoading = false;

      if (response.data["success"] == true) {
        notifyListeners();
        return true;
      }

      _serverError = response.data["message"] ?? "OTP verification failed";
      notifyListeners();
      return false;
    } on DioException catch (e) {
      _isLoading = false;
      _serverError =
          e.response?.data["message"] ?? "Invalid OTP";
      notifyListeners();
      return false;
    }
  }


    //recovery pGE
Future<bool> sendRecoveryLink() async {
  clearError();

  if (recoveryEmailController.text
      .trim()
      .isEmpty) {
    _emailError = "Email is required";
    notifyListeners();
    return false;
  }

  _isLoading = true;
  notifyListeners();

  try {
    final response = await _authService.forgotPassword(
      recoveryEmailController.text.trim(),
    );

    _isLoading = false;

    if (response.data["success"] == true) {
      notifyListeners();
      return true;
    }

    _serverError =
        response.data["message"] ?? "Recovery request failed";

    notifyListeners();
    return false;

  } on DioException catch (e) {
    _isLoading = false;
    _serverError =
        e.response?.data["message"] ?? "Something went wrong";
    notifyListeners();
    return false;
  }
}


  //---------------------------------------
  // Logout
  //---------------------------------------

  Future<void> logout() async {
    try {
      await _authService.logout();
    } catch (_) {}

    final pref = await SharedPreferences.getInstance();

    await pref.remove("token");
    await pref.remove("refreshToken"); // यदि प्रयोग गर्छौ भने

    DioClient.clearToken();

    clear();
  }

  //---------------------------------------
  // Clear Controllers
  //---------------------------------------

  void clear() {

    emailController.clear();
    passwordController.clear();
    fullNameController.clear();
    usernameController.clear();
    confirmPasswordController.clear();
    _recoveryEmailController.clear();

    for (final controller in _otpControllers) {
      controller.clear();
    }

    clearError();

    notifyListeners();
  }


  void clearError() {
      _fullNameError = null;
      _usernameError = null;
      _emailError = null;
      _passwordError = null;
      _confirmPasswordError = null;
      _serverError = null;
      _errorMessage = null;

    }


  //---------------------------------------

  @override
  void dispose() {

    emailController.dispose();

    passwordController.dispose();

    fullNameController.dispose();

    usernameController.dispose();

    confirmPasswordController.dispose();
    _recoveryEmailController.dispose();

    for(final controller in _otpControllers){
      controller.dispose();
    }


    super.dispose();
  }
}