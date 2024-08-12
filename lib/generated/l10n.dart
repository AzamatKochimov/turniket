// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class GeneratedLocalization {
  GeneratedLocalization();

  static GeneratedLocalization? _current;

  static GeneratedLocalization get current {
    assert(_current != null,
        'No instance of GeneratedLocalization was loaded. Try to initialize the GeneratedLocalization delegate before accessing GeneratedLocalization.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<GeneratedLocalization> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = GeneratedLocalization();
      GeneratedLocalization._current = instance;

      return instance;
    });
  }

  static GeneratedLocalization of(BuildContext context) {
    final instance = GeneratedLocalization.maybeOf(context);
    assert(instance != null,
        'No instance of GeneratedLocalization present in the widget tree. Did you add GeneratedLocalization.delegate in localizationsDelegates?');
    return instance!;
  }

  static GeneratedLocalization? maybeOf(BuildContext context) {
    return Localizations.of<GeneratedLocalization>(
        context, GeneratedLocalization);
  }

  /// `Hello World!`
  String get helloWorld {
    return Intl.message(
      'Hello World!',
      name: 'helloWorld',
      desc: '',
      args: [],
    );
  }

  /// `This is mine!!!`
  String get mine {
    return Intl.message(
      'This is mine!!!',
      name: 'mine',
      desc: '',
      args: [],
    );
  }

  /// `Stable and high-yield investments`
  String get intro_page_header_one {
    return Intl.message(
      'Stable and high-yield investments',
      name: 'intro_page_header_one',
      desc: '',
      args: [],
    );
  }

  /// `Honest and fair cooperation`
  String get intro_page_header_two {
    return Intl.message(
      'Honest and fair cooperation',
      name: 'intro_page_header_two',
      desc: '',
      args: [],
    );
  }

  /// `Socially significant project`
  String get intro_page_header_three {
    return Intl.message(
      'Socially significant project',
      name: 'intro_page_header_three',
      desc: '',
      args: [],
    );
  }

  /// `Minimal risk`
  String get intro_page_header_four {
    return Intl.message(
      'Minimal risk',
      name: 'intro_page_header_four',
      desc: '',
      args: [],
    );
  }

  /// `Reliable business`
  String get intro_page_header_five {
    return Intl.message(
      'Reliable business',
      name: 'intro_page_header_five',
      desc: '',
      args: [],
    );
  }

  /// `Income of at least 18% per year in USD equivalent. This means at least 30% income in UZS.`
  String get intro_page_subHeader_one {
    return Intl.message(
      'Income of at least 18% per year in USD equivalent. This means at least 30% income in UZS.',
      name: 'intro_page_subHeader_one',
      desc: '',
      args: [],
    );
  }

  /// `Partnership based on non-usury`
  String get intro_page_subHeader_two {
    return Intl.message(
      'Partnership based on non-usury',
      name: 'intro_page_subHeader_two',
      desc: '',
      args: [],
    );
  }

  /// `Investment in education - investment in the nation's future.`
  String get intro_page_subHeader_three {
    return Intl.message(
      'Investment in education - investment in the nation\'s future.',
      name: 'intro_page_subHeader_three',
      desc: '',
      args: [],
    );
  }

  /// `Investment in highly liquid assets`
  String get intro_page_subHeader_four {
    return Intl.message(
      'Investment in highly liquid assets',
      name: 'intro_page_subHeader_four',
      desc: '',
      args: [],
    );
  }

  /// `A company engaged in educational activities for many years.`
  String get intro_page_subHeader_five {
    return Intl.message(
      'A company engaged in educational activities for many years.',
      name: 'intro_page_subHeader_five',
      desc: '',
      args: [],
    );
  }

  /// `Language selection`
  String get drawer_language_change_header {
    return Intl.message(
      'Language selection',
      name: 'drawer_language_change_header',
      desc: '',
      args: [],
    );
  }

  /// `Don't worry! You can change the language at any time.`
  String get drawer_language_change_subHeader {
    return Intl.message(
      'Don\'t worry! You can change the language at any time.',
      name: 'drawer_language_change_subHeader',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next_button_text {
    return Intl.message(
      'Next',
      name: 'next_button_text',
      desc: '',
      args: [],
    );
  }

  /// `Enter Passport`
  String get stepper_card_button_tex {
    return Intl.message(
      'Enter Passport',
      name: 'stepper_card_button_tex',
      desc: '',
      args: [],
    );
  }

  /// `Phone \nNumber`
  String get stepper_card_step_one {
    return Intl.message(
      'Phone \nNumber',
      name: 'stepper_card_step_one',
      desc: '',
      args: [],
    );
  }

  /// `Passport \nInformation`
  String get stepper_card_step_two {
    return Intl.message(
      'Passport \nInformation',
      name: 'stepper_card_step_two',
      desc: '',
      args: [],
    );
  }

  /// `Verification`
  String get stepper_card_step_three {
    return Intl.message(
      'Verification',
      name: 'stepper_card_step_three',
      desc: '',
      args: [],
    );
  }

  /// `Investment`
  String get stepper_card_step_four {
    return Intl.message(
      'Investment',
      name: 'stepper_card_step_four',
      desc: '',
      args: [],
    );
  }

  /// `Registration`
  String get passport_page_appBar {
    return Intl.message(
      'Registration',
      name: 'passport_page_appBar',
      desc: '',
      args: [],
    );
  }

  /// `Are you a citizen of Uzbekistan?`
  String get passport_page_first_center_header {
    return Intl.message(
      'Are you a citizen of Uzbekistan?',
      name: 'passport_page_first_center_header',
      desc: '',
      args: [],
    );
  }

  /// `This information is required to register you as an investor with government agencies`
  String get passport_page_first_center_subHeader {
    return Intl.message(
      'This information is required to register you as an investor with government agencies',
      name: 'passport_page_first_center_subHeader',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get passport_page_first_button_yes {
    return Intl.message(
      'Yes',
      name: 'passport_page_first_button_yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get passport_page_first_button_no {
    return Intl.message(
      'No',
      name: 'passport_page_first_button_no',
      desc: '',
      args: [],
    );
  }

  /// `Upload Document`
  String get passport_page_second_center_header {
    return Intl.message(
      'Upload Document',
      name: 'passport_page_second_center_header',
      desc: '',
      args: [],
    );
  }

  /// `The system will scan the data and automatically fill out the questionnaire.`
  String get passport_page_second_center_subHeader {
    return Intl.message(
      'The system will scan the data and automatically fill out the questionnaire.',
      name: 'passport_page_second_center_subHeader',
      desc: '',
      args: [],
    );
  }

  /// `Passport`
  String get passport_page_second_passport_header {
    return Intl.message(
      'Passport',
      name: 'passport_page_second_passport_header',
      desc: '',
      args: [],
    );
  }

  /// `Take a vertical photo of the first page of your passport`
  String get passport_page_second_passport_subHeader {
    return Intl.message(
      'Take a vertical photo of the first page of your passport',
      name: 'passport_page_second_passport_subHeader',
      desc: '',
      args: [],
    );
  }

  /// `ID Card`
  String get passport_page_second_id_card_header {
    return Intl.message(
      'ID Card',
      name: 'passport_page_second_id_card_header',
      desc: '',
      args: [],
    );
  }

  /// `Send photos of the front and back of the ID card`
  String get passport_page_second_id_card_subHeader {
    return Intl.message(
      'Send photos of the front and back of the ID card',
      name: 'passport_page_second_id_card_subHeader',
      desc: '',
      args: [],
    );
  }

  /// `Personal Information`
  String get home_page_drawer_user_info {
    return Intl.message(
      'Personal Information',
      name: 'home_page_drawer_user_info',
      desc: '',
      args: [],
    );
  }

  /// `Support`
  String get home_page_drawer_support {
    return Intl.message(
      'Support',
      name: 'home_page_drawer_support',
      desc: '',
      args: [],
    );
  }

  /// `Language Settings`
  String get home_page_drawer_language {
    return Intl.message(
      'Language Settings',
      name: 'home_page_drawer_language',
      desc: '',
      args: [],
    );
  }

  /// `Security`
  String get home_page_drawer_security {
    return Intl.message(
      'Security',
      name: 'home_page_drawer_security',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get home_page_drawer_settings {
    return Intl.message(
      'Settings',
      name: 'home_page_drawer_settings',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get home_page_drawer_log_out {
    return Intl.message(
      'Log Out',
      name: 'home_page_drawer_log_out',
      desc: '',
      args: [],
    );
  }

  /// `Public Offer`
  String get home_page_drawer_public_offer {
    return Intl.message(
      'Public Offer',
      name: 'home_page_drawer_public_offer',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get home_page_drawer_privacy_policy {
    return Intl.message(
      'Privacy Policy',
      name: 'home_page_drawer_privacy_policy',
      desc: '',
      args: [],
    );
  }

  /// `Data Processing`
  String get home_page_drawer_data_processing {
    return Intl.message(
      'Data Processing',
      name: 'home_page_drawer_data_processing',
      desc: '',
      args: [],
    );
  }

  /// `App Version:`
  String get home_page_drawer_version {
    return Intl.message(
      'App Version:',
      name: 'home_page_drawer_version',
      desc: '',
      args: [],
    );
  }

  /// `Main`
  String get bottom_nav_bar_main {
    return Intl.message(
      'Main',
      name: 'bottom_nav_bar_main',
      desc: '',
      args: [],
    );
  }

  /// `Career`
  String get bottom_nav_bar_career {
    return Intl.message(
      'Career',
      name: 'bottom_nav_bar_career',
      desc: '',
      args: [],
    );
  }

  /// `Projects`
  String get bottom_nav_bar_projects {
    return Intl.message(
      'Projects',
      name: 'bottom_nav_bar_projects',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get bottom_nav_bar_profile {
    return Intl.message(
      'Profile',
      name: 'bottom_nav_bar_profile',
      desc: '',
      args: [],
    );
  }

  /// `Support`
  String get support_page_header {
    return Intl.message(
      'Support',
      name: 'support_page_header',
      desc: '',
      args: [],
    );
  }

  /// `Online chat`
  String get support_page_online_chat {
    return Intl.message(
      'Online chat',
      name: 'support_page_online_chat',
      desc: '',
      args: [],
    );
  }

  /// `Calling`
  String get support_page_calling {
    return Intl.message(
      'Calling',
      name: 'support_page_calling',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get support_page_address {
    return Intl.message(
      'Address',
      name: 'support_page_address',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get support_page_email_address {
    return Intl.message(
      'Email',
      name: 'support_page_email_address',
      desc: '',
      args: [],
    );
  }

  /// `F.A.Q`
  String get support_page_FAQ {
    return Intl.message(
      'F.A.Q',
      name: 'support_page_FAQ',
      desc: '',
      args: [],
    );
  }

  /// `SARDOR`
  String get sardors {
    return Intl.message(
      'SARDOR',
      name: 'sardors',
      desc: '',
      args: [],
    );
  }

  /// `Security`
  String get security_title {
    return Intl.message(
      'Security',
      name: 'security_title',
      desc: '',
      args: [],
    );
  }

  /// `Change PIN code`
  String get security_change_pin_code {
    return Intl.message(
      'Change PIN code',
      name: 'security_change_pin_code',
      desc: '',
      args: [],
    );
  }

  /// `Use biometric`
  String get security_use_biometrics {
    return Intl.message(
      'Use biometric',
      name: 'security_use_biometrics',
      desc: '',
      args: [],
    );
  }

  /// `Delete account`
  String get security_delete_acc {
    return Intl.message(
      'Delete account',
      name: 'security_delete_acc',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations!`
  String get complete_congrats {
    return Intl.message(
      'Congratulations!',
      name: 'complete_congrats',
      desc: '',
      args: [],
    );
  }

  /// `You have successfully registered from the PDP Invest app`
  String get complete_success_text {
    return Intl.message(
      'You have successfully registered from the PDP Invest app',
      name: 'complete_success_text',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get complete_next {
    return Intl.message(
      'Next',
      name: 'complete_next',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get confirm_login {
    return Intl.message(
      'Login',
      name: 'confirm_login',
      desc: '',
      args: [],
    );
  }

  /// `A company that has been engaged in educational activities for many years.`
  String get confirm_text {
    return Intl.message(
      'A company that has been engaged in educational activities for many years.',
      name: 'confirm_text',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get confirm_next {
    return Intl.message(
      'Next',
      name: 'confirm_next',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get login_next {
    return Intl.message(
      'Next',
      name: 'login_next',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login_login {
    return Intl.message(
      'Login',
      name: 'login_login',
      desc: '',
      args: [],
    );
  }

  /// `A company that has been engaged in educational activities for many years.`
  String get login_text_about_company {
    return Intl.message(
      'A company that has been engaged in educational activities for many years.',
      name: 'login_text_about_company',
      desc: '',
      args: [],
    );
  }

  /// `By clicking the Continue button, you agree to the terms of `
  String get login_privacy_policy_part1 {
    return Intl.message(
      'By clicking the Continue button, you agree to the terms of ',
      name: 'login_privacy_policy_part1',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy `
  String get login_privacy_policy_part2 {
    return Intl.message(
      'Privacy Policy ',
      name: 'login_privacy_policy_part2',
      desc: '',
      args: [],
    );
  }

  /// `and Personal Data Processing documents`
  String get login_privacy_policy_part3 {
    return Intl.message(
      'and Personal Data Processing documents',
      name: 'login_privacy_policy_part3',
      desc: '',
      args: [],
    );
  }

  /// `PIN-code`
  String get pin_code {
    return Intl.message(
      'PIN-code',
      name: 'pin_code',
      desc: '',
      args: [],
    );
  }

  /// `Set PIN-code`
  String get set_pin_code {
    return Intl.message(
      'Set PIN-code',
      name: 'set_pin_code',
      desc: '',
      args: [],
    );
  }

  /// `Repeat the PIN-code`
  String get verify_pin_code {
    return Intl.message(
      'Repeat the PIN-code',
      name: 'verify_pin_code',
      desc: '',
      args: [],
    );
  }

  /// `Enter PIN-code`
  String get enter_pin_code {
    return Intl.message(
      'Enter PIN-code',
      name: 'enter_pin_code',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgot_pincode {
    return Intl.message(
      'Forgot password?',
      name: 'forgot_pincode',
      desc: '',
      args: [],
    );
  }

  /// `PIN-code has been set!`
  String get pin_code_success {
    return Intl.message(
      'PIN-code has been set!',
      name: 'pin_code_success',
      desc: '',
      args: [],
    );
  }

  /// `Main page`
  String get go_to_main_page {
    return Intl.message(
      'Main page',
      name: 'go_to_main_page',
      desc: '',
      args: [],
    );
  }

  /// `All investments`
  String get home_all_investments {
    return Intl.message(
      'All investments',
      name: 'home_all_investments',
      desc: '',
      args: [],
    );
  }

  /// `Profit: `
  String get home_profit {
    return Intl.message(
      'Profit: ',
      name: 'home_profit',
      desc: '',
      args: [],
    );
  }

  /// `Invest`
  String get home_investing {
    return Intl.message(
      'Invest',
      name: 'home_investing',
      desc: '',
      args: [],
    );
  }

  /// `How does PDP Invest work?`
  String get home_how_it_works {
    return Intl.message(
      'How does PDP Invest work?',
      name: 'home_how_it_works',
      desc: '',
      args: [],
    );
  }

  /// `som`
  String get home_currency {
    return Intl.message(
      'som',
      name: 'home_currency',
      desc: '',
      args: [],
    );
  }

  /// `How does it work?`
  String get home_how_does_it_work {
    return Intl.message(
      'How does it work?',
      name: 'home_how_does_it_work',
      desc: '',
      args: [],
    );
  }

  /// `When can I get profit?`
  String get home_when_profit {
    return Intl.message(
      'When can I get profit?',
      name: 'home_when_profit',
      desc: '',
      args: [],
    );
  }

  /// `Which language is convenient for you?`
  String get initial_page_header_text {
    return Intl.message(
      'Which language is convenient for you?',
      name: 'initial_page_header_text',
      desc: '',
      args: [],
    );
  }

  /// `Xabarnoma`
  String get notification_page_app_bar_title {
    return Intl.message(
      'Xabarnoma',
      name: 'notification_page_app_bar_title',
      desc: '',
      args: [],
    );
  }

  /// `Telegram kanalimiz`
  String get our_telegram_chanel {
    return Intl.message(
      'Telegram kanalimiz',
      name: 'our_telegram_chanel',
      desc: '',
      args: [],
    );
  }

  /// `Telegram orqali o'qish`
  String get go_to_telegram {
    return Intl.message(
      'Telegram orqali o\'qish',
      name: 'go_to_telegram',
      desc: '',
      args: [],
    );
  }

  /// `Investor darajalari`
  String get investor_page_title {
    return Intl.message(
      'Investor darajalari',
      name: 'investor_page_title',
      desc: '',
      args: [],
    );
  }

  /// `Sarmoyadorlar darajasi va foyda ulushi kiritgan mablag'lari miqdoriga qarab quyidagicha taqsimlanadi:`
  String get investor_page_desc {
    return Intl.message(
      'Sarmoyadorlar darajasi va foyda ulushi kiritgan mablag\'lari miqdoriga qarab quyidagicha taqsimlanadi:',
      name: 'investor_page_desc',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate
    extends LocalizationsDelegate<GeneratedLocalization> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'uz'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<GeneratedLocalization> load(Locale locale) =>
      GeneratedLocalization.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
