import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'addlist_page_widget.dart' show AddlistPageWidget;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddlistPageModel extends FlutterFlowModel<AddlistPageWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for Ingrediant widget.
  FocusNode? ingrediantFocusNode1;
  TextEditingController? ingrediantTextController1;
  String? Function(BuildContext, String?)? ingrediantTextController1Validator;
  String? _ingrediantTextController1Validator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter the patients full name.';
    }

    return null;
  }

  // State field(s) for Ingrediant widget.
  FocusNode? ingrediantFocusNode2;
  TextEditingController? ingrediantTextController2;
  String? Function(BuildContext, String?)? ingrediantTextController2Validator;
  DateTime? datePicked1;
  DateTime? datePicked2;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // State field(s) for description widget.
  FocusNode? descriptionFocusNode;
  TextEditingController? descriptionTextController;
  String? Function(BuildContext, String?)? descriptionTextControllerValidator;
  // Stores action output result for [Backend Call - API (foodInserts)] action in Button widget.
  ApiCallResponse? apiResult7d1;

  @override
  void initState(BuildContext context) {
    ingrediantTextController1Validator = _ingrediantTextController1Validator;
  }

  @override
  void dispose() {
    ingrediantFocusNode1?.dispose();
    ingrediantTextController1?.dispose();

    ingrediantFocusNode2?.dispose();
    ingrediantTextController2?.dispose();

    descriptionFocusNode?.dispose();
    descriptionTextController?.dispose();
  }
}
