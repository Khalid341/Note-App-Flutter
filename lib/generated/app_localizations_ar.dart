import 'app_localizations.dart';

class AppLocalizationsAr implements AppLocalizations {
  const AppLocalizationsAr();

  @override
  String get title {
    return "تطبيق الملاحظات"; // Replace with correct translation
  }

  @override
  String get noteTitleLabel {
    return "العنوان"; // Replace with correct translation
  }

  @override
  String get noteDescriptionLabel {
    return "الوصف"; // Replace with correct translation
  }

  @override
  String get saveNoteButtonLabel {
    return "حفظ الملاحظة"; // Replace with correct translation
  }

  @override
  String get signup {
    return "تسجيل"; // Replace with correct translation
  }

  @override
  String? translate(String key) {
    switch (key) {
      case 'title':
        return title;
      case 'noteTitleLabel':
        return noteTitleLabel;
      case 'noteDescriptionLabel':
        return noteDescriptionLabel;
      case 'saveNoteButtonLabel':
        return saveNoteButtonLabel;
      case 'signup':
        return signup;
    // Add more cases for other localized strings
      default:
        return null;
    }
  }

  @override
  Map<String, dynamic> get localizedStrings => {
    'title': title,
    'noteTitleLabel': noteTitleLabel,
    'noteDescriptionLabel': noteDescriptionLabel,
    'saveNoteButtonLabel': saveNoteButtonLabel,
    'signup': signup,
    // Add more localized strings here
  };
}