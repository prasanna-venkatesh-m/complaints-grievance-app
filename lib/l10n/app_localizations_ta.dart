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
  String get mobileNumberRequired => 'மொபைல் எண்ணை உள்ளிடவும்';

  @override
  String get invalidMobileNumber => '10 இலக்க மொபைல் எண்ணை உள்ளிடவும்';

  @override
  String get getOtp => 'OTP பெறுக';

  @override
  String get dontHaveAccount => 'கணக்கு இல்லையா?';

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
  String get alreadyHaveAccount => 'ஏற்கனவே கணக்கு உள்ளதா?';

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
  String get inProgress => 'செயல்பாட்டில்';

  @override
  String get ticket => 'புகார்';

  @override
  String get status => 'நிலை';

  @override
  String get latestGrievance => 'சமீபத்திய புகார்';

  @override
  String get unknown => 'தெரியவில்லை';

  @override
  String get noDashboardDataAvailable =>
      'புகார் பலகை தரவு எதுவும் கிடைக்கவில்லை.';

  @override
  String get noGrievanceSubmittedYet =>
      'இதுவரை எந்த புகாரும் சமர்ப்பிக்கப்படவில்லை.';

  @override
  String get unableToLoadDashboard => 'புகார் பலகையை ஏற்ற முடியவில்லை.';

  @override
  String get retry => 'மீண்டும் முயற்சி';

  @override
  String get submitted => 'சமர்ப்பிக்கப்பட்டது';

  @override
  String get forwarded => 'முன்னனுப்பப்பட்டது';

  @override
  String get underReview => 'மதிப்பாய்வில் உள்ளது';

  @override
  String get closed => 'மூடப்பட்டது';

  @override
  String get rejected => 'நிராகரிக்கப்பட்டது';

  @override
  String get water => 'தண்ணீர்';

  @override
  String get roads => 'சாலைகள்';

  @override
  String get electricity => 'மின்சாரம்';

  @override
  String get sanitation => 'சுகாதாரம்';

  @override
  String get publicServices => 'பொது சேவைகள்';

  @override
  String get housingWelfare => 'வீடு மற்றும் நலத்திட்டங்கள்';

  @override
  String get educationHealthcare => 'கல்வி மற்றும் சுகாதாரம்';

  @override
  String get other => 'மற்றவை';

  @override
  String get description => 'விளக்கம்';

  @override
  String get noDataAvailable => 'தரவு எதுவும் கிடைக்கவில்லை';

  @override
  String get attachments => 'இணைப்புகள்';

  @override
  String get postedOn => 'வெளியிடப்பட்ட தேதி';

  @override
  String get high => 'அதிகம்';

  @override
  String get low => 'குறைவு';

  @override
  String get medium => 'நடுத்தரம்';

  @override
  String get urgent => 'அவசரம்';

  @override
  String get statusHistories => 'நிலை மற்றும் வரலாறு';

  @override
  String get callorGetDirections => 'அழைக்கவும் அல்லது வழியைப் பெறவும்';

  @override
  String get allGrievances => 'அனைத்து புகார்கள்';

  @override
  String get grievanceDetails => 'குறை விவரங்கள்';

  @override
  String get grievanceInformation => 'குறை தொடர்பான தகவல்கள்';

  @override
  String get noGrievancesAvailable => 'குறைகள் எதுவும் கிடைக்கவில்லை';

  @override
  String get issueCategory => 'குறை வகை';

  @override
  String get priority => 'முன்னுரிமை';

  @override
  String get expectedResolution => 'எதிர்பார்க்கப்படும் தீர்வு';

  @override
  String get progress => 'முன்னேற்றம்';

  @override
  String get noProgressUpdates => 'முன்னேற்றப் புதுப்பிப்புகள் எதுவும் இல்லை';

  @override
  String get progressUpdate => 'முன்னேற்றப் புதுப்பிப்பு';

  @override
  String get resolutionClosure => 'தீர்வு மற்றும் நிறைவு';

  @override
  String expectedBy(String date) {
    return '$dateக்குள் தீர்வு எதிர்பார்க்கப்படுகிறது';
  }

  @override
  String get resolvedOnLabel => 'தீர்வு தேதி';

  @override
  String resolvedOn(String date) {
    return '$date அன்று தீர்க்கப்பட்டது';
  }

  @override
  String get resolution => 'தீர்வு';

  @override
  String get resolvedBy => 'தீர்வு செய்தவர்';

  @override
  String get reopenInformation => 'மீண்டும் திறந்த தகவல்கள்';

  @override
  String get reopenCount => 'மீண்டும் திறந்த எண்ணிக்கை';

  @override
  String get reopenedOn => 'மீண்டும் திறந்த தேதி';

  @override
  String get reason => 'காரணம்';

  @override
  String get rating => 'மதிப்பீடு';

  @override
  String ratedOn(String date) {
    return '$date அன்று மதிப்பீடு செய்யப்பட்டது';
  }

  @override
  String get attachment => 'இணைப்பு';

  @override
  String get unableToLoadGrievance => 'குறையை ஏற்ற முடியவில்லை.';

  @override
  String submittedOn(String date) {
    return '$date அன்று சமர்ப்பிக்கப்பட்டது';
  }

  @override
  String get noDescriptionAvailable => 'விளக்கம் எதுவும் கிடைக்கவில்லை';

  @override
  String get viewMore => 'மேலும் காண்க';

  @override
  String get allUpdates => 'அனைத்து புதுப்பிப்புகள்';
}
