// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get english => 'English';

  @override
  String get tamil => 'Tamil';

  @override
  String helloUser(String name) {
    return 'Hello, $name!';
  }

  @override
  String get home => 'Home';

  @override
  String get grievance => 'Grievances';

  @override
  String get helpDesk => 'Helpdesk';

  @override
  String get submit => 'Submit';

  @override
  String get welcomeToTvk => 'WELCOME TO TVK';

  @override
  String get loginWithMobileNumber => 'Login with Mobile number';

  @override
  String get mobileNumber => 'Mobile Number';

  @override
  String get mobileNumberRequired => 'Mobile number required';

  @override
  String get invalidMobileNumber => 'Enter valid 10 digit mobile number';

  @override
  String get getOtp => 'Get OTP';

  @override
  String get dontHaveAccount => 'Don\'t have an account? ';

  @override
  String get register => 'Register';

  @override
  String get enterOtp => 'Enter OTP';

  @override
  String get enterOtpSubtitle =>
      'Enter the 6 digit OTP sent to your mobile number';

  @override
  String get resendOtp => 'Resend OTP';

  @override
  String resendOtpIn(Object seconds) {
    return 'Resend OTP in ${seconds}s';
  }

  @override
  String get createYourAccount => 'Create your Account';

  @override
  String get fullName => 'Full Name';

  @override
  String get fullNameRequired => 'Full Name is required';

  @override
  String get minimumThreeCharacters => 'Minimum 3 characters required';

  @override
  String get onlyAlphabetsAllowed => 'Only alphabets allowed';

  @override
  String get dateOfBirth => 'Date of Birth';

  @override
  String get dateOfBirthRequired => 'Date of Birth is required';

  @override
  String get emailId => 'Email Id';

  @override
  String get constituencyNumber => 'Constituency Number';

  @override
  String get constituencyNumberRequired => 'Constituency number required';

  @override
  String get gender => 'Gender';

  @override
  String get genderRequired => 'Gender is required';

  @override
  String get district => 'District';

  @override
  String get districtRequired => 'District is required';

  @override
  String get alreadyHaveAccount => 'Already have an account? ';

  @override
  String get login => 'Login';

  @override
  String get male => 'Male';

  @override
  String get female => 'Female';

  @override
  String get otherGender => 'Other';

  @override
  String get grievanceDashboard => 'GRIEVANCE DASHBOARD';

  @override
  String get latestUpdates => 'LATEST UPDATES';

  @override
  String get raiseGrievance => 'Raise Grievance';

  @override
  String get deptContacts => 'Dept. Contacts';

  @override
  String get fileNew => 'File New';

  @override
  String get myGrievance => 'My Grievance';

  @override
  String get chooseCategory => 'CHOOSE CATEGORY';

  @override
  String get locationDetails => 'LOCATION DETAILS';

  @override
  String get ward => 'WARD';

  @override
  String get selectWard => 'Select Ward';

  @override
  String get area => 'AREA';

  @override
  String get selectArea => 'Select Area';

  @override
  String get street => 'STREET';

  @override
  String get selectStreet => 'Select Street';

  @override
  String get describe => 'DESCRIBE';

  @override
  String get describe_the_issue => 'Describe the issue...';

  @override
  String get uploadEvidence => 'UPLOAD EVIDENCE';

  @override
  String get grievance_registered_successfully =>
      'Grievance registered successfully';

  @override
  String get select_location_details => 'Please select location details';

  @override
  String get please_choose_category => 'Please choose category';

  @override
  String get open => 'OPEN';

  @override
  String get history => 'HISTORY';

  @override
  String get resolved => 'Resolved';

  @override
  String get statusHistories => 'Status & Histories';

  @override
  String get callorGetDirections => 'Call or Get Direction';
}
