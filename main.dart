import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  displayMenu();
}

void displayMenu() {
print("""
===Menu===
1. Download Waifu Pics
2.  Exit (don't do it or gay)
# Waifu on Top
""");

  stdout.write('Choose an options: ');
  String choice = stdin.readLineSync() ?? '';

  switch (choice) {
    case '1':
      stdout.write('How many picture you want to download ? ');
      String photoCountInput = stdin.readLineSync() ?? '';
      int photoCount = int.tryParse(photoCountInput) ?? 0;

      if (photoCount > 0) {
        downloadWaifuPhotos(photoCount);
      } else {
        print('Number invalid (fak u).');
        displayMenu();
      }
      break;
    case '2':
      print('Goodbye gay man.');
      break;
    default:
      print('You are very dumb.');
      displayMenu();
      break;
  }
}

void downloadWaifuPhotos(int photoCount) async {
  for (int i = 0; i < photoCount; i++) {
    final response = await http.get(Uri.parse('https://api.waifu.im/search/?included_tags=waifu'));
    final data = json.decode(response.body);

    if (data['images'] != null && data['images'].length > 0) {
      final image = data['images'][0];
      final imageUrl = image['url'];

      final request = await http.get(Uri.parse(imageUrl));
      final bytes = request.bodyBytes;

      final fileName = 'waifu_$i.png';
      final file = File(fileName);
      await file.writeAsBytes(bytes);

      print('Image Downloaded, File Name : $fileName');
    }
  }

  displayMenu();
}