// auth_provider.dart
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

  String? _resetToken;
  String? get resetToken => _resetToken;


  //---------------------------------------
  // Controllers
  //---------------------------------------

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();

  final TextEditingController _recoveryEmailController =
  TextEditingController();
  TextEditingController get recoveryEmailController =>
      _recoveryEmailController;

  final List<TextEditingController> _otpControllers =
  List.generate(6, (_) => TextEditingController());
  List<TextEditingController> get otpControllers => _otpControllers;

  //---------------------------------------
  // Reset Password (merged from ResetPasswordProvider)
  //---------------------------------------

  final resetPasswordFormKey = GlobalKey<FormState>();

  final TextEditingController resetPasswordController =
  TextEditingController();
  final TextEditingController resetConfirmController =
  TextEditingController();

  bool _hideResetPassword = true;
  bool get hideResetPassword => _hideResetPassword;

  bool _hideResetConfirm = true;
  bool get hideResetConfirm => _hideResetConfirm;

  double _resetStrength = 0.0;
  double get resetStrength => _resetStrength;

  String _resetPasswordMessage = "Password must be at least 8 characters";
  String get resetPasswordMessage => _resetPasswordMessage;

  Color _resetStrengthColor = Colors.red;
  Color get resetStrengthColor => _resetStrengthColor;

  void toggleResetPassword() {
    _hideResetPassword = !_hideResetPassword;
    notifyListeners();
  }

  void toggleResetConfirm() {
    _hideResetConfirm = !_hideResetConfirm;
    notifyListeners();
  }

  void checkResetPasswordStrength(String value) {
    if (value.isEmpty) {
      _resetStrength = 0;
      _resetStrengthColor = Colors.red;
      _resetPasswordMessage = "Password must be at least 8 characters";
    } else if (value.length < 8) {
      _resetStrength = .25;
      _resetStrengthColor = Colors.red;
      _resetPasswordMessage = "Too short - minimum 8 characters";
    } else if (value.length < 10) {
      _resetStrength = .50;
      _resetStrengthColor = Colors.orange;
      _resetPasswordMessage = "Weak password";
    } else if (value.length < 12) {
      _resetStrength = .75;
      _resetStrengthColor = Colors.amber;
      _resetPasswordMessage = "Good password";
    } else {
      _resetStrength = 1;
      _resetStrengthColor = Colors.green;
      _resetPasswordMessage = "Strong password";
    }
    notifyListeners();
  }

  String? resetPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    if (value.length < 8) {
      return "Minimum 8 characters required";
    }
    return null;
  }

  String? resetConfirmValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Confirm password is required";
    }
    if (value != resetPasswordController.text) {
      return "Passwords do not match";
    }
    return null;
  }


  //---------------------------------------

  void togglePassword() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void toggleRememberMe(bool? value) {
    _rememberMe = value ?? !_rememberMe;
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

    if (email.isEmpty) {
      _emailError = "Email is required";
      hasError = true;
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(email)) {
      _emailError = "Enter a valid email";
      hasError = true;
    }

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

      if (response.data["success"] == true) {
        final accessToken = response.data["data"]["accessToken"] ??
            response.data["data"]["token"];
        final refreshToken = response.data["data"]["refreshToken"];

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
      if (e.response != null) {
        _serverError = e.response?.data["message"] ?? "Login failed";
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

    if (fullName.isEmpty) {
      _fullNameError = "Full name is required";
      hasError = true;
    }

    if (username.isEmpty) {
      _usernameError = "Username is required";
      hasError = true;
    } else if (username.length < 3) {
      _usernameError = "Username must be at least 3 characters";
      hasError = true;
    }

    if (email.isEmpty) {
      _emailError = "Email is required";
      hasError = true;
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(email)) {
      _emailError = "Enter a valid email";
      hasError = true;
    }

    if (password.isEmpty) {
      _passwordError = "Password is required";
      hasError = true;
    } else if (password.length < 8) {
      _passwordError = "Password must be at least 8 characters";
      hasError = true;
    }

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
        confirmPassword: confirmPassword,
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

      if (e.response != null) {
        final message = e.response?.data["message"] ?? "Signup failed";

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
        email: recoveryEmailController.text.trim(),
        otp: otp,
      );

      _isLoading = false;

      if (response.data["success"] == true) {
        _resetToken = response.data["data"]?["resetToken"];
        notifyListeners();
        return true;
      }

      _serverError = response.data["message"] ?? "OTP verification failed";
      notifyListeners();
      return false;
    } on DioException catch (e) {
      _isLoading = false;
      _serverError = e.response?.data["message"] ?? "Invalid OTP";
      notifyListeners();
      return false;
    }
  }

  Future<bool> resetPassword() async {
    if (!resetPasswordFormKey.currentState!.validate()) return false;

    clearError();

    if (_resetToken == null) {
      _serverError = "Session expired. Please verify OTP again.";
      notifyListeners();
      return false;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final response = await _authService.resetPassword(
        token: _resetToken!,
        newPassword: resetPasswordController.text,
      );

      _isLoading = false;

      if (response.data["success"] == true) {
        _resetToken = null; // one-time use, clear after success
        notifyListeners();
        return true;
      }

      _serverError = response.data["message"] ?? "Reset password failed";
      notifyListeners();
      return false;
    } on DioException catch (e) {
      _isLoading = false;
      _serverError =
          e.response?.data["message"] ?? "Unable to connect to server";
      notifyListeners();
      return false;
    } catch (e) {
      _isLoading = false;
      _serverError = e.toString();
      notifyListeners();
      return false;
    }
  }


  //google login
  Future<bool> googleLogin() async {
    clearError();

    _isLoading = true;
    notifyListeners();

    try {
      final GoogleSignInAccount user =
      await GoogleSignIn.instance.authenticate();

      final GoogleSignInAuthentication authentication =
      await user.authentication;

      final String? idToken = authentication.idToken;
      if (idToken == null) {
        _serverError = "Unable to get Google ID Token";
        _isLoading = false;
        notifyListeners();
        return false;
      }

      final response = await _authService.googleLogin(idToken);

      if (response.data["success"] == true) {
        final accessToken = response.data["data"]["accessToken"];
        final refreshToken = response.data["data"]["refreshToken"];

        DioClient.setToken(accessToken);

        final pref = await SharedPreferences.getInstance();
        await pref.setString("token", accessToken);

        if (refreshToken != null) {
          await pref.setString("refreshToken", refreshToken);
        }

        _isLoading = false;
        notifyListeners();
        return true;
      }

      _serverError = response.data["message"] ?? "Google Login Failed";
    } on GoogleSignInException catch (e) {
      _serverError = e.description ?? e.code.name;
    } on DioException catch (e) {
      _serverError =
          e.response?.data["message"] ?? "Unable to connect to server";
    } catch (e) {
      _serverError = e.toString();
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  //recovery page
  Future<bool> sendRecoveryLink() async {
    clearError();

    if (recoveryEmailController.text.trim().isEmpty) {
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

      _serverError = response.data["message"] ?? "Recovery request failed";
      notifyListeners();
      return false;
    } on DioException catch (e) {
      _isLoading = false;
      _serverError = e.response?.data["message"] ?? "Something went wrong";
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
    await pref.remove("refreshToken");

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
    resetPasswordController.clear();
    resetConfirmController.clear();
    _resetToken = null;

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
    resetPasswordController.dispose();
    resetConfirmController.dispose();

    for (final controller in _otpControllers) {
      controller.dispose();
    }

    super.dispose();
  }
}