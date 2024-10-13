import 'dart:convert';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:flutter_image_compress/flutter_image_compress.dart';

class ImageCompressorUtils {
  static Future<Uint8List> compress(Uint8List list) async {
    var result = await FlutterImageCompress.compressWithList(
      list,
      minHeight: 640,
      minWidth: 360,
      quality: 20,
    );
    return result;
  }

  static String removeMetadataFromBase64(String base64Image) {
    Uint8List decodedBytes = base64Decode(base64Image);
    img.Image? image = img.decodeImage(decodedBytes);
    if (image == null) {
      throw Exception("Could not decode the image");
    }
    Uint8List encodedBytes =
        Uint8List.fromList(img.encodeJpg(image, quality: 85));
    String base64WithoutMetadata = base64Encode(encodedBytes);
    return base64WithoutMetadata;
  }
}
