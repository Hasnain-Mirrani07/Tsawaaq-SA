import 'package:rxdart/rxdart.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/features/Profile/profile_repo.dart';
import 'package:tasawaaq/features/Profile/profile_response.dart';


class ProfileManager extends Manager<ProfileResponse> {
  final PublishSubject<ProfileResponse> _subject =
      PublishSubject<ProfileResponse>();

  Stream<ProfileResponse> get profile$  => _subject.stream;






  execute() async{
    await ProfileRepo.getProfile().then((result) {
      if (result.error == null) {
        _subject.add(result);
      } else {
        _subject.addError(result.error);
      }
    });
  }

  @override
  void dispose() {}

  @override
  void clearSubject() {}
}
