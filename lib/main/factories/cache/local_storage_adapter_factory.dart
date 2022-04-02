import 'package:localstorage/localstorage.dart';

import '../../../data/cache/cache.dart';

LocalStorageAdapter makeLocalStorageAdapter() =>
    LocalStorageAdapter(localStorage: LocalStorage('fordev'));
