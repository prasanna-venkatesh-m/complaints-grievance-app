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
  String get mobileNumberRequired => 'Mobile number is required';

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
  String get inProgress => 'In Progress';

  @override
  String get ticket => 'Ticket';

  @override
  String get status => 'Status';

  @override
  String get latestGrievance => 'Latest grievance';

  @override
  String get unknown => 'Unknown';

  @override
  String get noDashboardDataAvailable => 'No dashboard data available.';

  @override
  String get noGrievanceSubmittedYet => 'No grievance submitted yet.';

  @override
  String get unableToLoadDashboard => 'Unable to load dashboard.';

  @override
  String get retry => 'Retry';

  @override
  String get submitted => 'Submitted';

  @override
  String get forwarded => 'Forwarded';

  @override
  String get underReview => 'Under Review';

  @override
  String get closed => 'Closed';

  @override
  String get rejected => 'Rejected';

  @override
  String get water => 'Water';

  @override
  String get roads => 'Roads';

  @override
  String get electricity => 'Electricity';

  @override
  String get sanitation => 'Sanitation';

  @override
  String get publicServices => 'Public Services';

  @override
  String get housingWelfare => 'Housing & Welfare';

  @override
  String get educationHealthcare => 'Education & Healthcare';

  @override
  String get other => 'Other';

  @override
  String get description => 'Description';

  @override
  String get noDataAvailable => 'No data available';

  @override
  String get attachments => 'Attachments';

  @override
  String get postedOn => 'Posted On';

  @override
  String get high => 'HIGH';

  @override
  String get low => 'LOW';

  @override
  String get medium => 'MEDIUM';

  @override
  String get urgent => 'URGENT';

  @override
  String get statusHistories => 'Status & Histories';

  @override
  String get callorGetDirections => 'Call or Get Directions';

  @override
  String get allGrievances => 'All Grievances';

  @override
  String get grievanceDetails => 'Grievance Details';

  @override
  String get grievanceInformation => 'Grievance Information';

  @override
  String get noGrievancesAvailable => 'No grievances available';

  @override
  String get issueCategory => 'Issue Category';

  @override
  String get priority => 'Priority';

  @override
  String get expectedResolution => 'Expected Resolution';

  @override
  String get progress => 'Progress';

  @override
  String get noProgressUpdates => 'No progress updates available.';

  @override
  String get progressUpdate => 'Progress Update';

  @override
  String get resolutionClosure => 'Resolution & Closure';

  @override
  String expectedBy(String date) {
    return 'Expected by $date';
  }

  @override
  String get resolvedOnLabel => 'Resolved On';

  @override
  String resolvedOn(String date) {
    return 'Resolved on $date';
  }

  @override
  String get resolution => 'Resolution';

  @override
  String get resolvedBy => 'Resolved By';

  @override
  String get reopenInformation => 'Reopen Information';

  @override
  String get reopenCount => 'Reopen Count';

  @override
  String get reopenedOn => 'Reopened On';

  @override
  String get reason => 'Reason';

  @override
  String get rating => 'Rating';

  @override
  String ratedOn(String date) {
    return 'Rated on $date';
  }

  @override
  String get attachment => 'Attachment';

  @override
  String get unableToLoadGrievance => 'Unable to load grievance.';

  @override
  String submittedOn(String date) {
    return 'Submitted $date';
  }

  @override
  String get noDescriptionAvailable => 'No description available';

  @override
  String get viewMore => 'View More';

  @override
  String get allUpdates => 'All Updates';
}
