// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tamil (`ta`).
class AppLocalizationsTa extends AppLocalizations {
  AppLocalizationsTa([String locale = 'ta']) : super(locale);

  @override
  String get english => 'ஆங்கிலம்';

  @override
  String get tamil => 'தமிழ்';

  @override
  String helloUser(String name) {
    return 'வணக்கம், $name!';
  }

  @override
  String get home => 'முகப்பு';

  @override
  String get grievance => 'குறைகள்';

  @override
  String get helpDesk => 'உதவி மையம்';

  @override
  String get submit => 'சமர்ப்பிக்கவும்';

  @override
  String get welcomeToTvk => 'தவெக உங்களை வரவேற்கிறது!';

  @override
  String get loginWithMobileNumber => 'மொபைல் எண்ணில் உள்நுழையவும்';

  @override
  String get mobileNumber => 'மொபைல் எண்';

  @override
  String get mobileNumberRequired => 'மொபைல் எண் அவசியமானது';

  @override
  String get invalidMobileNumber => 'சரியான 10 இலக்க மொபைல் எண்ணை உள்ளிடவும்';

  @override
  String get getOtp => 'OTP பெறுக';

  @override
  String get dontHaveAccount => 'கணக்கு இல்லையா? ';

  @override
  String get register => 'பதிவு செய்க';

  @override
  String get enterOtp => 'OTP உள்ளிடவும்';

  @override
  String get enterOtpSubtitle =>
      'உங்கள் மொபைல் எண்ணிற்கு அனுப்பப்பட்ட 6 இலக்க OTP-ஐ உள்ளிடவும்';

  @override
  String get resendOtp => 'OTP மீண்டும் அனுப்பவும்';

  @override
  String resendOtpIn(Object seconds) {
    return '$seconds விநாடிகளில் OTP மீண்டும் அனுப்பலாம்';
  }

  @override
  String get createYourAccount => 'உங்கள் கணக்கை உருவாக்கவும்';

  @override
  String get fullName => 'முழுப் பெயர்';

  @override
  String get fullNameRequired => 'முழுப் பெயர் அவசியமானது';

  @override
  String get minimumThreeCharacters =>
      'குறைந்தது 3 எழுத்துக்கள் இருக்க வேண்டும்';

  @override
  String get onlyAlphabetsAllowed => 'எழுத்துக்கள் மட்டுமே அனுமதிக்கப்படும்';

  @override
  String get dateOfBirth => 'பிறந்த தேதி';

  @override
  String get dateOfBirthRequired => 'பிறந்த தேதி அவசியமானது';

  @override
  String get emailId => 'மின்னஞ்சல் முகவரி';

  @override
  String get constituencyNumber => 'தொகுதி எண்';

  @override
  String get constituencyNumberRequired => 'தொகுதி எண் அவசியமானது';

  @override
  String get gender => 'பாலினம்';

  @override
  String get genderRequired => 'பாலினம் அவசியமானது';

  @override
  String get district => 'மாவட்டம்';

  @override
  String get districtRequired => 'மாவட்டம் அவசியமானது';

  @override
  String get alreadyHaveAccount => 'ஏற்கனவே கணக்கு உள்ளதா? ';

  @override
  String get login => 'உள்நுழைக';

  @override
  String get male => 'ஆண்';

  @override
  String get female => 'பெண்';

  @override
  String get otherGender => 'மற்றவை';

  @override
  String get grievanceDashboard => 'குறைதீர்ப்பு முகப்பு';

  @override
  String get latestUpdates => 'சமீபத்திய புதுப்பிப்புகள்';

  @override
  String get raiseGrievance => 'குறை பதிவு';

  @override
  String get deptContacts => 'துறை தொடர்புகள்';

  @override
  String get fileNew => 'புதிய குறை';

  @override
  String get myGrievance => 'எனது குறைகள்';

  @override
  String get chooseCategory => 'பிரிவைத் தேர்ந்தெடுக்கவும்';

  @override
  String get locationDetails => 'இட விவரங்கள்';

  @override
  String get ward => 'வார்டு';

  @override
  String get selectWard => 'வார்டைத் தேர்ந்தெடுக்கவும்';

  @override
  String get area => 'பகுதி';

  @override
  String get selectArea => 'பகுதியைத் தேர்ந்தெடுக்கவும்';

  @override
  String get street => 'தெரு';

  @override
  String get selectStreet => 'தெருவைத் தேர்ந்தெடுக்கவும்';

  @override
  String get describe => 'விவரம்';

  @override
  String get describe_the_issue => 'சிக்கலை விவரிக்கவும்...';

  @override
  String get uploadEvidence => 'சான்றைப் பதிவேற்றவும்';

  @override
  String get grievance_registered_successfully =>
      'குறை வெற்றிகரமாகப் பதிவு செய்யப்பட்டது';

  @override
  String get select_location_details =>
      'தயவுசெய்து இட விவரங்களைத் தேர்ந்தெடுக்கவும்';

  @override
  String get please_choose_category => 'தயவுசெய்து பிரிவைத் தேர்ந்தெடுக்கவும்';

  @override
  String get open => 'செயலில் உள்ளவை';

  @override
  String get history => 'முந்தையவை';

  @override
  String get resolved => 'தீர்க்கப்பட்டது';

  @override
  String get statusHistories => 'நிலை மற்றும் வரலாறு';

  @override
  String get callorGetDirections => 'அழைக்கவும் அல்லது வழிdirections பெறவும்';
}
