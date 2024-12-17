import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'register_page_widget.dart' show RegisterPageWidget;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RegisterPageModel extends FlutterFlowModel<RegisterPageWidget> {
  ///  Local state fields for this page.

  List<String> genpassword = [];
  void addToGenpassword(String item) => genpassword.add(item);
  void removeFromGenpassword(String item) => genpassword.remove(item);
  void removeAtIndexFromGenpassword(int index) => genpassword.removeAt(index);
  void insertAtIndexInGenpassword(int index, String item) =>
      genpassword.insert(index, item);
  void updateGenpasswordAtIndex(int index, Function(String) updateFn) =>
      genpassword[index] = updateFn(genpassword[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - splitString] action in registerPage widget.
  List<String>? splitresult;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode3;
  TextEditingController? textController3;
  String? Function(BuildContext, String?)? textController3Validator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();

    textFieldFocusNode3?.dispose();
    textController3?.dispose();
  }
}
