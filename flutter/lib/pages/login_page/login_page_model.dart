import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'login_page_widget.dart' show LoginPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginPageModel extends FlutterFlowModel<LoginPageWidget> {
  ///  Local state fields for this page.

  List<String> enterpassphrase = [];
  void addToEnterpassphrase(String item) => enterpassphrase.add(item);
  void removeFromEnterpassphrase(String item) => enterpassphrase.remove(item);
  void removeAtIndexFromEnterpassphrase(int index) =>
      enterpassphrase.removeAt(index);
  void insertAtIndexInEnterpassphrase(int index, String item) =>
      enterpassphrase.insert(index, item);
  void updateEnterpassphraseAtIndex(int index, Function(String) updateFn) =>
      enterpassphrase[index] = updateFn(enterpassphrase[index]);

  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Custom Action - loginWithMnemonic] action in Button widget.
  NewAccountStruct? loginOutput;
  // Stores action output result for [Custom Action - generateAccount] action in Text widget.
  NewAccountStruct? genpassword;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
