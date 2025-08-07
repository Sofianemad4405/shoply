import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class FirebaseStorageService {
  Future<String> uploadImageToFirebase(XFile imageFile) async {
    final fileName = path.basename(imageFile.path);
    final ref = FirebaseStorage.instance.ref().child(
      'profile_images/$fileName',
    );
    await ref.putData(await imageFile.readAsBytes());
    return await ref.getDownloadURL();
  }
}
