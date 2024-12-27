import 'package:share_plus/share_plus.dart';

class ShareController {
  void shareText(String text) {
    print("Share button clicked!");  // Debug print statement
    Share.share(text);
  }

  void shareImage(String imagePath) {
    print("Share button clicked!");  // Debug print statement
    Share.shareFiles([imagePath]);
  }
}


