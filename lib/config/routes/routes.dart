abstract class Routes {
  static const homeRoute = Paths.homePath;
  static const mainScreenRoute = Paths.mainScreenPath;
  static const detailedEventRoute = Paths.detailedEventPath;
  static const favouriteRoute = Paths.favouritePath;
  static const searchRoute = Paths.searchPath;
  static const homeScreenRoute = Paths.homeScreenPath;
  static const addScreenRoute = Paths.addPath;
  static const searchResults = Paths.searchResultsPath;
}

abstract class Paths {
  static const homePath = "/";
  static const homeScreenPath = "/home";
  static const mainScreenPath = '/main';
  static const detailedEventPath = 'detailed-event';
  static const favouritePath = '/favourite';
  static const searchPath = '/search';
  static const addPath = '/add';
  static const searchResultsPath = '/search_results';
}
