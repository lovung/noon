import 'package:flutter/foundation.dart';
import 'smart_text_field.dart';

class EditorProvider extends ChangeNotifier {
  SmartTextType selectedType;

  EditorProvider({SmartTextType defaultType = SmartTextType.T})
      : selectedType = defaultType;

  void setType(SmartTextType type) {
    if (selectedType == type) {
      selectedType = SmartTextType.T;
    } else {
      selectedType = type;
    }
    notifyListeners();
  }
}
