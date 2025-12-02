import 'package:dz_pub/api/categories.dart';

import '../../../api/social_media.dart';

class     AuthState {
  final bool isLoading;
  final String? errorMessage;
  final bool hasError;
  final Future<List<Category>>? categories;
  final Future<List<SocialMediaLink>>? socialMediaLinks;

  AuthState( {this.isLoading = false,this.hasError = false, this
      .errorMessage,this.categories,
  this.socialMediaLinks
  });

  AuthState copyWith({bool?  isLoading, String? errorMessage,bool ? hasError,
    Future<List<Category>>? categories,
    Future<List<SocialMediaLink>>? socialMediaLinks
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
      categories: categories ?? this.categories,
      socialMediaLinks: socialMediaLinks ?? this.socialMediaLinks,
    );
  }
}
