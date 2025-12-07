import 'package:dz_pub/api/users.dart';

class     InfluencerState {
  final bool isLoading;
  final String? errorMessage;
  final bool hasError;
  final Future<List<User>>? influencer;
  final bool? isFetched;
  final Future<User>? influencerById;
  final User ? userInfluencerModel;


  InfluencerState( {this.isLoading = false,this.hasError = false, this
      .errorMessage,this.influencer, this.isFetched,
    this.influencerById,
    this.userInfluencerModel,
  });

  InfluencerState copyWith({bool?  isLoading, String? errorMessage,bool ? hasError,
    Future<List<User>>? influencer,
    Future<User>? influencerById,
    User ? userInfluencerModel,
    bool? isFetched,
  }) {
    return InfluencerState(
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
      influencer: influencer ?? this.influencer,
      influencerById: influencerById ?? this.influencerById,
      isFetched: isFetched ?? this.isFetched,
      userInfluencerModel: userInfluencerModel ?? this.userInfluencerModel,
    );
  }
}
