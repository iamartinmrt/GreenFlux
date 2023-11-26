part of 'stations_unit_test.dart';

const isDomainStationsResponse = TypeMatcher<StationsListSearchResponse>();

Matcher _hasErrorState(Object? valueOrMatcher) => HasErrorState(valueOrMatcher);

class HasErrorState extends CustomMatcher {
  HasErrorState(Object? valueOrMatcher)
      : super(
          'an object with error state field of',
          'error state',
          valueOrMatcher,
        );

  @override
  Object? featureValueOf(dynamic actual) => (actual as StationsList).whenOrNull(error: (e) => e);
}

Matcher _hasDataState(Object? valueOrMatcher) => HasDataState(valueOrMatcher);

class HasDataState extends CustomMatcher {
  HasDataState(Object? valueOrMatcher)
      : super(
    'an object with data state field of',
    'data state',
    valueOrMatcher,
  );

  @override
  Object? featureValueOf(dynamic actual) => (actual as StationsList).whenOrNull(data: (d) => d);
}
