// ignore_for_file: do_not_use_environment

const kDefaultPubEndpoint = 'https://pub.dev/api/';

const kPubEndpoint =
    String.fromEnvironment('PUB_ENDPOINT', defaultValue: kDefaultPubEndpoint);

const kUseMock = String.fromEnvironment('USE_MOCK') == 'true';
