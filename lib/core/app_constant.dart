class AppConstant {
  static const String kUsers = 'users';
  static const String kDefaultUserImage =
      'https://e7.pngegg.com/pngimages/927/1023/png-clipart-cartoon-child-illustration-excited-boy-jumping-material-hand-photography.png';

  static  String convertGoogleDriveUrl(String url) {
    final regex = RegExp(r'd/([a-zA-Z0-9_-]+)');
    final match = regex.firstMatch(url);
    if (match != null && match.groupCount >= 1) {
      final fileId = match.group(1);
      return 'https://drive.google.com/uc?export=view&id=$fileId';
    } else {
      return "";
    }
  }
}
