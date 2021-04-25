import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glinkwok_provider/src/common/config.dart';
import 'package:glinkwok_provider/src/common/image_picker.dart';
import 'package:glinkwok_provider/src/components/custom_appbar.dart';
import 'package:glinkwok_provider/src/model/document_response.dart';
import 'package:glinkwok_provider/src/screens/document/cubit/document_cubit.dart';
import 'package:glinkwok_provider/src/widgets/app_progress_hub.dart';
import 'package:simplest/simplest.dart';

class DocumentScreen extends CubitWidget<DocumentCubit, DocumentState> {
  static provider() {
    return BlocProvider(
      create: (_) => DocumentCubit(),
      child: DocumentScreen(),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    bloc.getDocuments();
  }

  @override
  void listener(BuildContext context, DocumentState state) {
    super.listener(context, state);
  }

  @override
  Widget builder(BuildContext context, DocumentState state) {
    return AppProgressHUB(
      inAsyncCall: state.isLoading,
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: _buildBody(context, state),
        bottomNavigationBar: _buildButtonProceed(context, state),
      ),
    );
  }

  Widget _buildBody(BuildContext context, DocumentState state) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            SizedBox(height: 16),
            Text(
              "bank_passbook".tr,
              style: title,
            ),
            _buildDocumentBox(state.bankPassbook),
            Text(
              "registration_certificate".tr,
              style: title,
            ),
            _buildDocumentBox(state.registration),
          ],
        ));
  }

  Widget _buildDocumentBox(Document document) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(children: [
          document?.providerdocuments == null
              ? ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: double.infinity,
                    minWidth: double.infinity,
                  ),
                  child: AspectRatio(
                    aspectRatio: 2,
                    child: Image.asset(
                      Images.defaulPicture,
                      fit: BoxFit.cover,
                    ),
                  ))
              : ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: double.infinity,
                    minWidth: double.infinity,
                  ),
                  child: AspectRatio(
                    aspectRatio: 2,
                    child: FadeInImage(
                      image: FileImage(
                        File(document.providerdocuments.url),
                      ),
                      fit: BoxFit.cover,
                      placeholder: AssetImage(
                        Images.defaulPicture,
                      ),
                    ),
                  )),
          _buildUploadImageButton(document),
        ]),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return PreferredSize(
      child: AppbarWidget(
        text: "document".tr,
      ),
      preferredSize: Size.fromHeight(AppBar().preferredSize.height),
    );
  }

  Widget _buildButtonProceed(BuildContext context, DocumentState state) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: SizedBox(
        width: double.infinity,
        height: 60.0,
        child: FlatButton(
          disabledColor: Colors.grey,
          color: Colors.deepOrange,
          onPressed: state.enableProceedButton
              ? () {
                  bloc.updateDocuments(state.bankPassbook, state.registration);
                }
              : null,
          child: Text(
            "proceed".tr,
            style: buttonTextStyle,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  Widget _buildUploadImageButton(Document document) {
    return Container(
      padding: EdgeInsets.all(0),
      width: double.infinity,
      height: 60,
      child: FlatButton(
        color: Colors.transparent,
        onPressed: () async {
          File file = await ImagePickerHelper.onSelectImageFromDevice(context);
          if (file != null) {
            document.providerdocuments = Providerdocuments(
              url: file.path,
              documentId: document.id.toString(),
              status: document.providerdocuments?.status,
            );
            bloc.updateImage(document);
          }
        },
        child: Text(
          document?.providerdocuments == null ? "add".tr : "edit".tr,
          style: buttonTextStyle.apply(color: primaryColor),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
