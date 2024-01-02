import 'package:css_mobile/util/lang/language_en.dart';
import 'package:css_mobile/util/lang/language_id.dart';
import 'package:get/get.dart';

class AppTranslation extends Translations{
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
    // 'id_ID' : LanguageID.getLanguage(),
    'en_US' : LanguageEN.getLanguage()
  };

}