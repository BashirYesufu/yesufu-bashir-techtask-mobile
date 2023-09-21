enum Environment { SANDBOX, LIVE, TEST }

class BaseUrl {
  static Map<String, dynamic>?  _config;
  static Environment? _env;

  static void setEnvironment(Environment env) {
    _env = env;
    switch (env) {
      case Environment.SANDBOX:
        _config = _BaseUrlConfig.sandboxBaseUrl;
        break;
      case Environment.LIVE:
        _config = _BaseUrlConfig.liveBaseUrl;
      case Environment.TEST:
        _config = _BaseUrlConfig.testBaseUrl;
        break;
    }
  }

  static Environment? getEnvironment() {
    return _env;
  }

  static get BASE_URL {
    return _config?[_BaseUrlConfig.BASE_URL];
  }

}

class _BaseUrlConfig{
  static const BASE_URL = 'BaseUrl';

  static Map<String, dynamic> sandboxBaseUrl = {
    BASE_URL: "https://lb7u7svcm5.execute-api.ap-southeast-1.amazonaws.com/dev/",
  };

  static Map<String, dynamic> liveBaseUrl = {
    BASE_URL: "https://lb7u7svcm5.execute-api.ap-southeast-1.amazonaws.com/dev/",
  };

  static Map<String, dynamic> testBaseUrl = {
    BASE_URL: "https://test.com/",
  };
}