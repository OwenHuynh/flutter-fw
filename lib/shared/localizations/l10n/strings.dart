import 'package:flutter_fm/presentation/screens/login-screen/login_screen.dart';
import 'package:intl/intl.dart';

mixin L10nStrings {
  /// [Common]
  String get commonOk => Intl.message("Ok", name: 'commonOk');

  String get commonCancel => Intl.message("Cancel", name: 'commonCancel');

  /// [Error]
  String get badRequestError =>
      Intl.message("Bad requests!", name: 'badRequest');

  String get unauthorizedError =>
      Intl.message("Access Denied!", name: 'unauthorized');

  String get forbiddenError =>
      Intl.message("Forbidden Errors!", name: 'forbidden');

  String get networkError =>
      Intl.message("An error occurred. We will record and fix this issue soon!",
          name: 'networkError');

  String get parseError =>
      Intl.message("Data parsing error!", name: 'parseError');

  String get connectTimeoutError =>
      Intl.message("Connection timeout with API server!",
          name: 'connectTimeoutError');

  String get sendTimeoutError =>
      Intl.message("Send timeout in connection with API server!",
          name: 'sendTimeoutError');

  String get receiveTimeoutError =>
      Intl.message("Receive timeout in connection with API server!",
          name: 'receiveTimeoutError');

  String get cancelError =>
      Intl.message("Request to API server was cancelled!", name: 'cancelError');

  /// [EmployeesEditorScreen]
  String get splashScreenScreenTitle =>
      Intl.message("Splash screen",
          name: 'splashScreenScreenTitle');

  /// [EmployeesEditorScreen]
  String get employeesEditorScreenLabelUpdateEmployee =>
      Intl.message("Update employee",
          name: 'employeesEditorScreenLabelUpdateEmployee');

  String get employeesEditorScreenLabelRemoveEmployee =>
      Intl.message("Remove employee",
          name: 'employeesEditorScreenLabelRemoveEmployee');

  String get employeesEditorScreenLabelErrorPage =>
      Intl.message("Oops, Something Went Wrong",
          name: 'employeesEditorScreenLabelErrorPage');

  String get employeesEditorScreenLabelRetry =>
      Intl.message("Retry", name: 'employeesEditorScreenLabelErrorPage');

  String get employeesEditorScreenLabelCreateSuccessfully =>
      Intl.message("Create successfully!",
          name: 'employeesEditorScreenLabelCreateSuccessfully');

  String get employeesEditorScreenLabelUpdateSuccessfully =>
      Intl.message("Update successfully!",
          name: 'employeesEditorScreenLabelUpdateSuccessfully');

  String get employeesEditorScreenLabelRemoveSuccessfully =>
      Intl.message("Remove successfully!",
          name: 'employeesEditorScreenLabelRemoveSuccessfully');

  String get notesEditorScreenLabelTitleConfirmRemoveNote =>
      Intl.message("Remove note",
          name: 'notesEditorScreenLabelTitleConfirmRemoveNote');

  String get notesEditorScreenLabelDescriptionConfirmRemoveNote =>
      Intl.message("Are you sure you want to delete this note?",
          name: 'notesEditorScreenLabelDescriptionConfirmRemoveNote');

  /// [LoginScreen]
  String get loginScreenLabelAppBarTitle =>
      Intl.message("Login Page", name: 'loginScreenLabelAppBarTitle');

  String get loginScreenLabelTitlePage =>
      Intl.message("Welcome", name: 'loginScreenLabelTitlePage');

  String get loginScreenLabelSubTitle =>
      Intl.message("Sign in with your email and password",
          name: 'loginScreenLabelSubTitle');

  String get loginScreenLabelEmail =>
      Intl.message("Email", name: 'loginScreenLabelEmail');

  String get loginScreenLabelPassword =>
      Intl.message("Password", name: 'loginScreenLabelPassword');

  String get loginScreenLabelEmailErrorMessage =>
      Intl.message("Please input email",
          name: 'loginScreenLabelEmailErrorMessage');

  String get loginScreenLabelEmailTypeErrorMessage =>
      Intl.message("Please input correct email. Example: sample@gmail.com",
          name: 'loginScreenLabelEmailTypeErrorMessage');

  String get loginScreenLabelPasswordErrorMessage =>
      Intl.message("Please input password",
          name: 'loginScreenLabelPasswordErrorMessage');

  String get loginScreenLabelPasswordLengthErrorMessage =>
      Intl.message("Please input correct password. it must be greater than 6.",
          name: 'loginScreenLabelPasswordLengthErrorMessage');

  String get loginScreenLabelLoginButton =>
      Intl.message("Login", name: 'loginScreenLabelLoginButton');

  String get employeesEditorScreenLabelTitleConfirmRemoveEmployee =>
      Intl.message("Remove employee",
          name: 'employeesEditorScreenLabelTitleConfirmRemoveEmployee');

  String get employeesEditorScreenLabelAddEmployee =>
      Intl.message("Add employee",
          name: 'employeesEditorScreenLabelAddEmployee');

  String get employeesEditorScreenLabelDescriptionConfirmRemoveEmployee =>
      Intl.message("Are you sure you want to delete this employee?",
          name: 'employeesEditorScreenLabelDescriptionConfirmRemoveEmployee');

  String get employeesEditorScreenLabelDescriptionConfirmUpdateEmployee =>
      Intl.message("Are you sure you want to update this employee?",
          name: 'employeesEditorScreenLabelDescriptionConfirmUpdateEmployee');

  String get employeeScreen =>
      Intl.message("Employees Screen", name: "employeeScreen");

  String get ok => Intl.message("OK", name: "ok");

  String get oops => Intl.message("Oops, Something Went Wrong", name: "oops");

  String get retry => Intl.message("Retry", name: "retry");

  String get employeeEditorScreen =>
      Intl.message("Employee Editor Screen", name: "employeeEditorScreen");

  String get nameEmployee => Intl.message("Name:", name: "nameEmployee");

  String get ageEmployee => Intl.message("Age:", name: "ageEmployee");

  String get emailEmployee => Intl.message("Email:", name: "emailEmployee");

  String get textErrorName =>
      Intl.message("Please enter input name", name: "textErrorName");

  String get textErrorAge =>
      Intl.message("Please enter input age", name: "textErrorAge");

  String get textErrorEmail =>
      Intl.message("Please enter input email", name: "textErrorEmail");

  String get emailNotValid =>
      Intl.message("Email is not valid", name: "emailNotValid");
}
