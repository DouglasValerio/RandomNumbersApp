import 'package:get_it/get_it.dart';
import 'package:random_number_app/apis/random_number_api.dart';
import 'package:random_number_app/apis/random_number_api_impl.dart';
import 'package:random_number_app/view_model/homepage_view_model.dart';

final injector = GetIt.instance;

void setupDependencyInjection() {
  injector.registerLazySingleton<HomepageViewModel>(()=> HomepageViewModel(randomNumberApi: injector<RandomNumberApi>()));
  injector.registerFactory<RandomNumberApi>(()=> RandomNumberApiImpl());
}