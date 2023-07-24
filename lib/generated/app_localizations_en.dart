import 'app_localizations.dart';

class AppLocalizationsEn implements AppLocalizations {
  const AppLocalizationsEn();

  @override
  String get title {
    return "Note App";
  }

  @override
  String get noteTitleLabel {
    return "Title";
  }

  @override
  String get noteDescriptionLabel {
    return "Description";
  }

  @override
  String get saveNoteButtonLabel {
    return "Save Note";
  }

  @override
  String get signup {
    return "Sign up";
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