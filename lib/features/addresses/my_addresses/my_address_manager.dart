import 'package:rxdart/rxdart.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/features/addresses/my_addresses/my_addresses_repo.dart';
import 'package:tasawaaq/features/addresses/my_addresses/my_addresses_response.dart';

class MyAddressesManager extends Manager<MyAddressesResponse> {
  final PublishSubject<MyAddressesResponse> _subject = PublishSubject<MyAddressesResponse>();
  Stream<MyAddressesResponse> get myAddresses$ => _subject.stream;


  execute() async {
    await MyAddressesRepo.getAddresses().then(
          (result) {
        if (result.error == null) {
          _subject.add(result);
        } else {
          _subject.addError(result.error);
        }
      },
    );
  }



  @override
  void dispose() {}

  @override
  void clearSubject() {}
}
