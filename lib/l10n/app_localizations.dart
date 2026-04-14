import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr')
  ];

  /// Text for search Button
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// the adress label
  ///
  /// In en, this message translates to:
  /// **'Adress'**
  String get company_adresse_label;

  /// the phone label
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get company_label_phone;

  /// the Email label
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get company_label_email;

  /// No description provided for @success_send_message_title.
  ///
  /// In en, this message translates to:
  /// **'Message send'**
  String get success_send_message_title;

  /// No description provided for @success_send_message_message.
  ///
  /// In en, this message translates to:
  /// **'Thank you for your message'**
  String get success_send_message_message;

  /// No description provided for @error_send_mail_title.
  ///
  /// In en, this message translates to:
  /// **'Authentication Error'**
  String get error_send_mail_title;

  /// No description provided for @error_send_mail_message.
  ///
  /// In en, this message translates to:
  /// **'You must sign before using this functionnality'**
  String get error_send_mail_message;

  /// No description provided for @error_input_hint_message.
  ///
  /// In en, this message translates to:
  /// **'Please write your message.'**
  String get error_input_hint_message;

  /// No description provided for @btn_close_label.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get btn_close_label;

  /// No description provided for @btn_send_label.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get btn_send_label;

  /// No description provided for @form_contact_title.
  ///
  /// In en, this message translates to:
  /// **'Contact Form:'**
  String get form_contact_title;

  /// No description provided for @input_hint_name.
  ///
  /// In en, this message translates to:
  /// **'Firstname'**
  String get input_hint_name;

  /// No description provided for @input_hint_prenom.
  ///
  /// In en, this message translates to:
  /// **'Lastname'**
  String get input_hint_prenom;

  /// No description provided for @input_hint_adress_email.
  ///
  /// In en, this message translates to:
  /// **'Email Adress'**
  String get input_hint_adress_email;

  /// No description provided for @input_hint_message.
  ///
  /// In en, this message translates to:
  /// **'Your Message...'**
  String get input_hint_message;

  /// No description provided for @movegui_info_title.
  ///
  /// In en, this message translates to:
  /// **'MoveGui – Motorcycle Delivery & Transport in Guinea'**
  String get movegui_info_title;

  /// No description provided for @movegui_info_text_1.
  ///
  /// In en, this message translates to:
  /// **'MoveGui is an innovative company specialising in food delivery and motorcycle transport in Guinea.Our mission is to make delivery more accessible, more transparent and more affordable for everyone.'**
  String get movegui_info_text_1;

  /// No description provided for @movegui_info_text_2.
  ///
  /// In en, this message translates to:
  /// **'We offer a fixed price for every journey, regardless of the distance, ensuring complete transparency for our customers.No more price surprises – just a fast, reliable and straightforward service..'**
  String get movegui_info_text_2;

  /// No description provided for @movegui_info_text_3.
  ///
  /// In en, this message translates to:
  /// **'Thanks to our partnerships with local restaurants, we offer low-cost deliveries whilst supporting the local economy.MoveGui is the perfect blend of technology, accessibility and efficiency.'**
  String get movegui_info_text_3;

  /// No description provided for @deactivate_button_title.
  ///
  /// In en, this message translates to:
  /// **'Service Unavailable '**
  String get deactivate_button_title;

  /// No description provided for @deactivate_button_message.
  ///
  /// In en, this message translates to:
  /// **'Service currently unavailable'**
  String get deactivate_button_message;

  /// No description provided for @deactivate_button_attach_message.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get deactivate_button_attach_message;

  /// No description provided for @category_courses_name.
  ///
  /// In en, this message translates to:
  /// **'Races'**
  String get category_courses_name;

  /// No description provided for @category_restaurant_name.
  ///
  /// In en, this message translates to:
  /// **'Restaurant'**
  String get category_restaurant_name;

  /// No description provided for @category_patisserie_name.
  ///
  /// In en, this message translates to:
  /// **'Pastry shop'**
  String get category_patisserie_name;

  /// No description provided for @category_supermarche_name.
  ///
  /// In en, this message translates to:
  /// **'Super Market'**
  String get category_supermarche_name;

  /// No description provided for @category_supplier_name.
  ///
  /// In en, this message translates to:
  /// **'Supplier'**
  String get category_supplier_name;

  /// No description provided for @category_pressing_name.
  ///
  /// In en, this message translates to:
  /// **'Dry cleaning'**
  String get category_pressing_name;

  /// No description provided for @category_discovery_name.
  ///
  /// In en, this message translates to:
  /// **'Discovery'**
  String get category_discovery_name;

  /// No description provided for @category_boulangerie_name.
  ///
  /// In en, this message translates to:
  /// **'Bakery'**
  String get category_boulangerie_name;

  /// No description provided for @category_pharmacy_name.
  ///
  /// In en, this message translates to:
  /// **'Pharmacy'**
  String get category_pharmacy_name;

  /// No description provided for @category_beauty_name.
  ///
  /// In en, this message translates to:
  /// **'Beauty & Care'**
  String get category_beauty_name;

  /// No description provided for @categroy_store_name.
  ///
  /// In en, this message translates to:
  /// **'Store'**
  String get categroy_store_name;

  /// No description provided for @category_shop_name.
  ///
  /// In en, this message translates to:
  /// **'Shop'**
  String get category_shop_name;

  /// No description provided for @category_wholesaler_name.
  ///
  /// In en, this message translates to:
  /// **'Wholesaler'**
  String get category_wholesaler_name;

  /// No description provided for @category_profession_name.
  ///
  /// In en, this message translates to:
  /// **'Professions'**
  String get category_profession_name;

  /// No description provided for @category_fast_food_name.
  ///
  /// In en, this message translates to:
  /// **'Fast Food'**
  String get category_fast_food_name;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'fr': return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
