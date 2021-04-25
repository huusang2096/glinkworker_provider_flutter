part of 'document_cubit.dart';

class DocumentState {
  Document bankPassbook;
  Document registration;
  bool enableProceedButton;
  bool isLoading;

  DocumentState(
    this.bankPassbook,
    this.registration,
    this.enableProceedButton,
    this.isLoading,
  );

  DocumentState copyWith({
    Document bankPassbook,
    Document registration,
    bool enableProceedButton,
    bool isLoading,
  }) {
    return DocumentState(
      bankPassbook ?? this.bankPassbook,
      registration ?? this.registration,
      enableProceedButton ?? this.enableProceedButton,
      isLoading ?? this.isLoading,
    );
  }

  DocumentState.from(DocumentState state) {
    bankPassbook = state.bankPassbook;
    registration = state.registration;
    enableProceedButton = state.enableProceedButton;
    isLoading = state.isLoading;
  }
}

class DocumentInitial extends DocumentState {
  DocumentInitial() : super(null, null, false, false);
}

class GetDocumentSuccessState extends DocumentState {
  GetDocumentSuccessState(
    Document bankPassbook,
    Document registration,
    DocumentState state,
  ) : super.from(state.copyWith(
          bankPassbook: bankPassbook,
          registration: registration,
        ));
}

class UpdateImageState extends DocumentState {
  UpdateImageState(DocumentState state) : super.from(state);
}
