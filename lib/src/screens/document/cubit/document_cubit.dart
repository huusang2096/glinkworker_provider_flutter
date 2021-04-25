import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:glinkwok_provider/src/common/bloc/base_cubit.dart';
import 'package:glinkwok_provider/src/common/config.dart';
import 'package:glinkwok_provider/src/model/document_response.dart';

import 'package:simplest/simplest.dart';

part 'document_state.dart';

class DocumentCubit extends BaseCubit<DocumentState> {
  DocumentCubit() : super(DocumentInitial());

  getDocuments() async {
    try {
      emit(state.copyWith(isLoading: true));
      DocumentResponse documentResponse = await dataRepository.getDocuments();
      // bankPassbook Document
      Document bankPassbook = documentResponse.documents
          .firstWhere((document) => document.id == BANK_PASSBOOK_ID);
      if (bankPassbook.providerdocuments != null) {
        File fileBankPassbook = await _fileFromImageUrl(
            url: bankPassbook.providerdocuments.url,
            fileName: "bankPassbook.jpeg");
        bankPassbook.providerdocuments.url = fileBankPassbook.path;
      }

      // registration Document
      Document registration = documentResponse.documents
          .firstWhere((document) => document.id == REGISTRATION_ID);
      if (registration.providerdocuments != null) {
        File fileRegistration = await _fileFromImageUrl(
            url: registration.providerdocuments.url,
            fileName: "registration.jpeg");
        registration.providerdocuments.url = fileRegistration.path;
      }
      emit(GetDocumentSuccessState(bankPassbook, registration, state));
    } catch (e) {
      showErrorMessage("get_document_failed".tr);
    }
    emit(state.copyWith(isLoading: false));
  }

  Future<File> _fileFromImageUrl({String url, String fileName}) async {
    String version = "?v=${DateTime.now().toString()}";
    final response = await http.get(IMG_URL + url + version);
    final documentDirectory = await getApplicationDocumentsDirectory();
    PaintingBinding.instance.imageCache.clear();
    final file = File(join(documentDirectory.path, fileName));

    file.writeAsBytesSync(response.bodyBytes);

    return file;
  }

  updateDocuments(Document bankPassbook, Document registration) async {
    try {
      emit(state.copyWith(isLoading: true));
      await dataRepository.uploadDocumentResponse(
          bankPassbook: bankPassbook, registration: registration);
      await getDocuments();
    } catch (e) {
      showErrorMessage("update_document_failed".tr);
    }
    emit(state.copyWith(isLoading: false));
  }

  updateImage(Document updatedDocument) async {
    try {
      if (updatedDocument.id == BANK_PASSBOOK_ID) {
        state.bankPassbook = updatedDocument;
      } else {
        state.registration = updatedDocument;
      }
      if (state.bankPassbook != null && state.registration != null) {
        state.enableProceedButton = true;
      }
      emit(UpdateImageState(state));
    } catch (e) {}
  }
}
