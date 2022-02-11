class AnimationConstants {
  static AnimationConstants? _instace;
  static AnimationConstants get instance {
    _instace ??= _instace = AnimationConstants._init();
    return _instace!;
  }


  String get bioAuthSuccess =>  getJson("bio_auth_success");
  String getJson(String value) => 'assets/animation/$value.json';

  AnimationConstants._init();
}
