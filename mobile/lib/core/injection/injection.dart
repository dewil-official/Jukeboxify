import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import './injection.config.dart';

final getIt = GetIt.instance;

@injectableInit
void configureInjection(Env environment) {
  String envString = EnvMapper().mapToString(environment);
  $initGetIt(getIt, environment: envString);
}

class EnvMapper {
  static const dev = 'dev';
  static const test = 'test';

  String mapToString(Env environment) {
    if (environment == Env.dev) return dev;
    if (environment == Env.test) return test;
    return dev;
  }
}

enum Env { dev, test }
