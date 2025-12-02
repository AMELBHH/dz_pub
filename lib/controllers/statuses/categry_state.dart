import 'package:dz_pub/api/categories.dart';

class     CategoryState {
  final bool isLoading;
  final String? errorMessage;
  final bool hasError;
  final Future<List<Category>>? categories;

  CategoryState( {this.isLoading = false,this.hasError = false, this
      .errorMessage,this.categories,
  });

  CategoryState copyWith({bool?  isLoading, String? errorMessage,bool ? hasError,
    Future<List<Category>>? categories,
  }) {
    return CategoryState(
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
      categories: categories ?? this.categories,
    );
  }
}
