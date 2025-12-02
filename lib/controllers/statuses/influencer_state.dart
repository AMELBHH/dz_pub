import 'package:dz_pub/api/users.dart';

class     InfluencerState {
  final bool isLoading;
  final String? errorMessage;
  final bool hasError;
  final Future<List<Influencer>>? influencer;
  final bool? isFetched;

  InfluencerState( {this.isLoading = false,this.hasError = false, this
      .errorMessage,this.influencer, this.isFetched,
  });

  InfluencerState copyWith({bool?  isLoading, String? errorMessage,bool ? hasError,
    Future<List<Influencer>>? influencer,
    bool? isFetched,
  }) {
    return InfluencerState(
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
      influencer: influencer ?? this.influencer,
      isFetched: isFetched ?? this.isFetched,
    );
  }
}
