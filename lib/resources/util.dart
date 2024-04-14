import 'package:dash_board_mopidati/shared/constant.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source, context) async {
  ImagePicker imagepicker = ImagePicker();
  XFile? file = await imagepicker.pickImage(source: source);
  if (file != null) {
    return await file.readAsBytes();
  } else {
    message(context, 'لم يتم اختيار صورة');
    print('لم يتم اختيار صورة');
  }
}
