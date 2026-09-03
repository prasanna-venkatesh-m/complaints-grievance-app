import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ta.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ta'),
  ];

  /// English language name
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// Tamil language name
  ///
  /// In en, this message translates to:
  /// **'Tamil'**
  String get tamil;

  /// Greeting the current user by name
  ///
  /// In en, this message translates to:
  /// **'Hello, {name}!'**
  String helloUser(String name);

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @grievance.
  ///
  /// In en, this message translates to:
  /// **'Grievances'**
  String get grievance;

  /// No description provided for @helpDesk.
  ///
  /// In en, this message translates to:
  /// **'Helpdesk'**
  String get helpDesk;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @welcomeToTvk.
  ///
  /// In en, this message translates to:
  /// **'WELCOME TO TVK'**
  String get welcomeToTvk;

  /// No description provided for @loginWithMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Login with Mobile number'**
  String get loginWithMobileNumber;

  /// No description provided for @mobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get mobileNumber;

  /// No description provided for @mobileNumberRequired.
  ///
  /// In en, this message translates to:
  /// **'Mobile number is required'**
  String get mobileNumberRequired;

  /// No description provided for @invalidMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter valid 10 digit mobile number'**
  String get invalidMobileNumber;

  /// No description provided for @getOtp.
  ///
  /// In en, this message translates to:
  /// **'Get OTP'**
  String get getOtp;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get dontHaveAccount;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @enterOtp.
  ///
  /// In en, this message translates to:
  /// **'Enter OTP'**
  String get enterOtp;

  /// No description provided for @enterOtpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter the 6 digit OTP sent to your mobile number'**
  String get enterOtpSubtitle;

  /// No description provided for @resendOtp.
  ///
  /// In en, this message translates to:
  /// **'Resend OTP'**
  String get resendOtp;

  /// No description provided for @resendOtpIn.
  ///
  /// In en, this message translates to:
  /// **'Resend OTP in {seconds}s'**
  String resendOtpIn(Object seconds);

  /// No description provided for @createYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Create your Account'**
  String get createYourAccount;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @fullNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Full Name is required'**
  String get fullNameRequired;

  /// No description provided for @minimumThreeCharacters.
  ///
  /// In en, this message translates to:
  /// **'Minimum 3 characters required'**
  String get minimumThreeCharacters;

  /// No description provided for @onlyAlphabetsAllowed.
  ///
  /// In en, this message translates to:
  /// **'Only alphabets allowed'**
  String get onlyAlphabetsAllowed;

  /// No description provided for @dateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get dateOfBirth;

  /// No description provided for @dateOfBirthRequired.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth is required'**
  String get dateOfBirthRequired;

  /// No description provided for @emailId.
  ///
  /// In en, this message translates to:
  /// **'Email Id'**
  String get emailId;

  /// No description provided for @constituencyNumber.
  ///
  /// In en, this message translates to:
  /// **'Constituency Number'**
  String get constituencyNumber;

  /// No description provided for @constituencyNumberRequired.
  ///
  /// In en, this message translates to:
  /// **'Constituency number required'**
  String get constituencyNumberRequired;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @genderRequired.
  ///
  /// In en, this message translates to:
  /// **'Gender is required'**
  String get genderRequired;

  /// No description provided for @district.
  ///
  /// In en, this message translates to:
  /// **'District'**
  String get district;

  /// No description provided for @districtRequired.
  ///
  /// In en, this message translates to:
  /// **'District is required'**
  String get districtRequired;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get alreadyHaveAccount;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @otherGender.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get otherGender;

  /// No description provided for @grievanceDashboard.
  ///
  /// In en, this message translates to:
  /// **'GRIEVANCE DASHBOARD'**
  String get grievanceDashboard;

  /// No description provided for @latestUpdates.
  ///
  /// In en, this message translates to:
  /// **'LATEST UPDATES'**
  String get latestUpdates;

  /// No description provided for @raiseGrievance.
  ///
  /// In en, this message translates to:
  /// **'Raise Grievance'**
  String get raiseGrievance;

  /// No description provided for @deptContacts.
  ///
  /// In en, this message translates to:
  /// **'Dept. Contacts'**
  String get deptContacts;

  /// No description provided for @fileNew.
  ///
  /// In en, this message translates to:
  /// **'File New'**
  String get fileNew;

  /// No description provided for @myGrievance.
  ///
  /// In en, this message translates to:
  /// **'My Grievance'**
  String get myGrievance;

  /// No description provided for @constituency.
  ///
  /// In en, this message translates to:
  /// **'Constituency'**
  String get constituency;

  /// No description provided for @chooseCategory.
  ///
  /// In en, this message translates to:
  /// **'CHOOSE CATEGORY'**
  String get chooseCategory;

  /// No description provided for @locationDetails.
  ///
  /// In en, this message translates to:
  /// **'LOCATION DETAILS'**
  String get locationDetails;

  /// No description provided for @ward.
  ///
  /// In en, this message translates to:
  /// **'WARD'**
  String get ward;

  /// No description provided for @selectWard.
  ///
  /// In en, this message translates to:
  /// **'Select Ward'**
  String get selectWard;

  /// No description provided for @area.
  ///
  /// In en, this message translates to:
  /// **'AREA'**
  String get area;

  /// No description provided for @selectArea.
  ///
  /// In en, this message translates to:
  /// **'Select Area'**
  String get selectArea;

  /// No description provided for @street.
  ///
  /// In en, this message translates to:
  /// **'STREET'**
  String get street;

  /// No description provided for @selectStreet.
  ///
  /// In en, this message translates to:
  /// **'Select Street'**
  String get selectStreet;

  /// No description provided for @describe.
  ///
  /// In en, this message translates to:
  /// **'DESCRIBE'**
  String get describe;

  /// No description provided for @describe_the_issue.
  ///
  /// In en, this message translates to:
  /// **'Describe the issue...'**
  String get describe_the_issue;

  /// No description provided for @uploadEvidence.
  ///
  /// In en, this message translates to:
  /// **'UPLOAD EVIDENCE'**
  String get uploadEvidence;

  /// No description provided for @grievance_registered_successfully.
  ///
  /// In en, this message translates to:
  /// **'Grievance registered successfully'**
  String get grievance_registered_successfully;

  /// No description provided for @select_location_details.
  ///
  /// In en, this message translates to:
  /// **'Please select location details'**
  String get select_location_details;

  /// No description provided for @please_choose_category.
  ///
  /// In en, this message translates to:
  /// **'Please choose category'**
  String get please_choose_category;

  /// No description provided for @open.
  ///
  /// In en, this message translates to:
  /// **'OPEN'**
  String get open;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'HISTORY'**
  String get history;

  /// No description provided for @resolved.
  ///
  /// In en, this message translates to:
  /// **'Resolved'**
  String get resolved;

  /// No description provided for @inProgress.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get inProgress;

  /// No description provided for @ticket.
  ///
  /// In en, this message translates to:
  /// **'Ticket'**
  String get ticket;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @latestGrievance.
  ///
  /// In en, this message translates to:
  /// **'Latest grievance'**
  String get latestGrievance;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @noDashboardDataAvailable.
  ///
  /// In en, this message translates to:
  /// **'No dashboard data available.'**
  String get noDashboardDataAvailable;

  /// No description provided for @noGrievanceSubmittedYet.
  ///
  /// In en, this message translates to:
  /// **'No grievance submitted yet.'**
  String get noGrievanceSubmittedYet;

  /// No description provided for @unableToLoadDashboard.
  ///
  /// In en, this message translates to:
  /// **'Unable to load dashboard.'**
  String get unableToLoadDashboard;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @submitted.
  ///
  /// In en, this message translates to:
  /// **'Submitted'**
  String get submitted;

  /// No description provided for @forwarded.
  ///
  /// In en, this message translates to:
  /// **'Forwarded'**
  String get forwarded;

  /// No description provided for @underReview.
  ///
  /// In en, this message translates to:
  /// **'Under Review'**
  String get underReview;

  /// No description provided for @closed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get closed;

  /// No description provided for @rejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get rejected;

  /// No description provided for @water.
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get water;

  /// No description provided for @roads.
  ///
  /// In en, this message translates to:
  /// **'Roads'**
  String get roads;

  /// No description provided for @electricity.
  ///
  /// In en, this message translates to:
  /// **'Electricity'**
  String get electricity;

  /// No description provided for @sanitation.
  ///
  /// In en, this message translates to:
  /// **'Sanitation'**
  String get sanitation;

  /// No description provided for @publicServices.
  ///
  /// In en, this message translates to:
  /// **'Public Services'**
  String get publicServices;

  /// No description provided for @housingWelfare.
  ///
  /// In en, this message translates to:
  /// **'Housing & Welfare'**
  String get housingWelfare;

  /// No description provided for @educationHealthcare.
  ///
  /// In en, this message translates to:
  /// **'Education & Healthcare'**
  String get educationHealthcare;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @noDataAvailable.
  ///
  /// In en, this message translates to:
  /// **'No data available'**
  String get noDataAvailable;

  /// No description provided for @attachments.
  ///
  /// In en, this message translates to:
  /// **'Attachments'**
  String get attachments;

  /// No description provided for @postedOn.
  ///
  /// In en, this message translates to:
  /// **'Posted On'**
  String get postedOn;

  /// No description provided for @high.
  ///
  /// In en, this message translates to:
  /// **'HIGH'**
  String get high;

  /// No description provided for @low.
  ///
  /// In en, this message translates to:
  /// **'LOW'**
  String get low;

  /// No description provided for @medium.
  ///
  /// In en, this message translates to:
  /// **'MEDIUM'**
  String get medium;

  /// No description provided for @urgent.
  ///
  /// In en, this message translates to:
  /// **'URGENT'**
  String get urgent;

  /// No description provided for @statusHistories.
  ///
  /// In en, this message translates to:
  /// **'Status & Histories'**
  String get statusHistories;

  /// No description provided for @callorGetDirections.
  ///
  /// In en, this message translates to:
  /// **'Call or Get Directions'**
  String get callorGetDirections;

  /// No description provided for @allGrievances.
  ///
  /// In en, this message translates to:
  /// **'All Grievances'**
  String get allGrievances;

  /// No description provided for @grievanceDetails.
  ///
  /// In en, this message translates to:
  /// **'Grievance Details'**
  String get grievanceDetails;

  /// No description provided for @grievanceInformation.
  ///
  /// In en, this message translates to:
  /// **'Grievance Information'**
  String get grievanceInformation;

  /// No description provided for @noGrievancesAvailable.
  ///
  /// In en, this message translates to:
  /// **'No grievances available'**
  String get noGrievancesAvailable;

  /// No description provided for @issueCategory.
  ///
  /// In en, this message translates to:
  /// **'Issue Category'**
  String get issueCategory;

  /// No description provided for @priority.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get priority;

  /// No description provided for @expectedResolution.
  ///
  /// In en, this message translates to:
  /// **'Expected Resolution'**
  String get expectedResolution;

  /// No description provided for @progress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get progress;

  /// No description provided for @noProgressUpdates.
  ///
  /// In en, this message translates to:
  /// **'No progress updates available.'**
  String get noProgressUpdates;

  /// No description provided for @progressUpdate.
  ///
  /// In en, this message translates to:
  /// **'Progress Update'**
  String get progressUpdate;

  /// No description provided for @resolutionClosure.
  ///
  /// In en, this message translates to:
  /// **'Resolution & Closure'**
  String get resolutionClosure;

  /// No description provided for @expectedBy.
  ///
  /// In en, this message translates to:
  /// **'Expected by {date}'**
  String expectedBy(String date);

  /// No description provided for @resolvedOnLabel.
  ///
  /// In en, this message translates to:
  /// **'Resolved On'**
  String get resolvedOnLabel;

  /// No description provided for @resolvedOn.
  ///
  /// In en, this message translates to:
  /// **'Resolved on {date}'**
  String resolvedOn(String date);

  /// No description provided for @resolution.
  ///
  /// In en, this message translates to:
  /// **'Resolution'**
  String get resolution;

  /// No description provided for @resolvedBy.
  ///
  /// In en, this message translates to:
  /// **'Resolved By'**
  String get resolvedBy;

  /// No description provided for @reopenInformation.
  ///
  /// In en, this message translates to:
  /// **'Reopen Information'**
  String get reopenInformation;

  /// No description provided for @reopenCount.
  ///
  /// In en, this message translates to:
  /// **'Reopen Count'**
  String get reopenCount;

  /// No description provided for @reopenedOn.
  ///
  /// In en, this message translates to:
  /// **'Reopened On'**
  String get reopenedOn;

  /// No description provided for @reason.
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String get reason;

  /// No description provided for @rating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get rating;

  /// No description provided for @ratedOn.
  ///
  /// In en, this message translates to:
  /// **'Rated on {date}'**
  String ratedOn(String date);

  /// No description provided for @attachment.
  ///
  /// In en, this message translates to:
  /// **'Attachment'**
  String get attachment;

  /// No description provided for @unableToLoadGrievance.
  ///
  /// In en, this message translates to:
  /// **'Unable to load grievance.'**
  String get unableToLoadGrievance;

  /// No description provided for @submittedOn.
  ///
  /// In en, this message translates to:
  /// **'Submitted {date}'**
  String submittedOn(String date);

  /// No description provided for @noDescriptionAvailable.
  ///
  /// In en, this message translates to:
  /// **'No description available'**
  String get noDescriptionAvailable;

  /// No description provided for @viewMore.
  ///
  /// In en, this message translates to:
  /// **'View More'**
  String get viewMore;

  /// No description provided for @allUpdates.
  ///
  /// In en, this message translates to:
  /// **'All Updates'**
  String get allUpdates;

  /// No description provided for @changeMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Change mobile number'**
  String get changeMobileNumber;

  /// No description provided for @checking.
  ///
  /// In en, this message translates to:
  /// **'Checking...'**
  String get checking;

  /// No description provided for @checkingInternetConnection.
  ///
  /// In en, this message translates to:
  /// **'Checking internet connection...'**
  String get checkingInternetConnection;

  /// No description provided for @noInternetConnection.
  ///
  /// In en, this message translates to:
  /// **'No internet connection.'**
  String get noInternetConnection;

  /// No description provided for @checkingPermissions.
  ///
  /// In en, this message translates to:
  /// **'Checking permissions...'**
  String get checkingPermissions;

  /// No description provided for @checkingAccount.
  ///
  /// In en, this message translates to:
  /// **'Checking account...'**
  String get checkingAccount;

  /// No description provided for @refreshingSession.
  ///
  /// In en, this message translates to:
  /// **'Refreshing session...'**
  String get refreshingSession;

  /// No description provided for @noInternetDescription.
  ///
  /// In en, this message translates to:
  /// **'Please check your internet connection and try again.'**
  String get noInternetDescription;

  /// No description provided for @noInternetRetryMessage.
  ///
  /// In en, this message translates to:
  /// **'No internet connection. Please check your network and try again.'**
  String get noInternetRetryMessage;

  /// No description provided for @unableToPlayVideo.
  ///
  /// In en, this message translates to:
  /// **'Unable to play video'**
  String get unableToPlayVideo;

  /// No description provided for @file.
  ///
  /// In en, this message translates to:
  /// **'File'**
  String get file;

  /// No description provided for @video.
  ///
  /// In en, this message translates to:
  /// **'Video'**
  String get video;

  /// No description provided for @image.
  ///
  /// In en, this message translates to:
  /// **'Image'**
  String get image;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ta'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ta':
      return AppLocalizationsTa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
