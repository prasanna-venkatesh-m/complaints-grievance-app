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
  /// **'Mobile number required'**
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

  /// No description provided for @statusHistories.
  ///
  /// In en, this message translates to:
  /// **'Status & Histories'**
  String get statusHistories;

  /// No description provided for @callorGetDirections.
  ///
  /// In en, this message translates to:
  /// **'Call or Get Direction'**
  String get callorGetDirections;
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
