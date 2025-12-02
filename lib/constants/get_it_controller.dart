import 'package:get_it/get_it.dart';
// import 'package:ween_blaqe/features/user/user/from_master_home_to_show_more/new_master_home.dart';

import 'coordination.dart';

final GetIt getIt = GetIt.instance;

//@injectableInit
Future<void> configureInjection() async {

  getIt.registerLazySingleton(
    () => AppDimension(),
  );
}

