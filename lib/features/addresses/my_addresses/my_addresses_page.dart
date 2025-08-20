import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasawaaq/app_routs/app_routs.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/features/addresses/add_address/add_address_manger.dart';
import 'package:tasawaaq/features/addresses/add_address/add_address_page.dart';
import 'package:tasawaaq/features/addresses/delete_address/delete_address_manger.dart';
import 'package:tasawaaq/features/addresses/edite_address/edit_address_page.dart';
import 'package:tasawaaq/features/addresses/my_addresses/my_address_manager.dart';
import 'package:tasawaaq/features/addresses/my_addresses/my_addresses_response.dart';
import 'package:tasawaaq/features/checkout/widgets/address_desc.dart';
import 'package:tasawaaq/shared/appbar/appbar.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/shared/custom_button/custom_button.dart';
import 'package:tasawaaq/shared/dialog/tasawaaq_dialog.dart';
import 'package:tasawaaq/shared/not_available_widget/not_available_widget.dart';



class MyAddressesPage extends StatefulWidget {
  const MyAddressesPage({Key? key}) : super(key: key);

  @override
  _MyAddressesPageState createState() => _MyAddressesPageState();
}

class _MyAddressesPageState extends State<MyAddressesPage> {


  @override
  void initState() {
    super.initState();
    locator<MyAddressesManager>().execute();
  }



  @override
  Widget build(BuildContext context) {
    final myAddressesManager = context.use<MyAddressesManager>();
    // final editAddressManager = context.use<EditAddressManager>();




    return Scaffold(
      persistentFooterButtons: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
          child: CustomButton(
            onClickBtn: (){
              Navigator.of(context).pushNamed(
                AppRouts.AddAddressPage,
                arguments: AddAddressPageArgs(
                 navigateFromAddresses: true,
                ),
              );
            },
            txt: '${context.translate(AppStrings.ADD_ADDRESS)}',
            btnWidth: double.infinity,
            btnColor: AppStyle.yellowButton, ),
        )
      ],
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: MainAppBar(
          title: Text('${context.translate(AppStrings.My_Addresses)}'),
          hasCart: false,
        ),
      ),
      body: Observer<MyAddressesResponse>(
          onRetryClicked: () {
            myAddressesManager.execute();
          },
          manager: myAddressesManager,
          stream: myAddressesManager.myAddresses$,
          onSuccess: (context, myAddressesSnapshot) {

          return myAddressesSnapshot.data!.isNotEmpty ? Container(
            padding: EdgeInsets.all(20),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: myAddressesSnapshot.data!.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppStyle.topLightGrey,
                      border: Border.all(color: AppStyle.lightGrey),

                    ),
                    child: AddressDesc(
                      namePhone: myAddressesSnapshot.data![index].name,
                      addressDesc: myAddressesSnapshot.data![index].fullAddress,
                      onClickDeleteBtn: (){
                        _deleteAddressClick(context,myAddressesSnapshot.data![index].id);
                      },
                      onClickEditBtn: (){
                        locator<AddAddressManager>().selectAreaSubject.value = myAddressesSnapshot.data![index].address!.area!;
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditAddressPage(
                          navigateFromAddresses: true,
                          phone: "${myAddressesSnapshot.data![index].address!.user!.phone}",
                          addressId: "${myAddressesSnapshot.data![index].address!.id}",
                          email: "${myAddressesSnapshot.data![index].address!.user!.email}",
                          // key: ,
                          area: myAddressesSnapshot.data![index].address!.area,
                          avenue: "${myAddressesSnapshot.data![index].address!.avenue}",
                          block: "${myAddressesSnapshot.data![index].address!.block}",
                          building: "${myAddressesSnapshot.data![index].address!.buildingNo}",
                          floor: "${myAddressesSnapshot.data![index].address!.floorNo}",
                          name: "${myAddressesSnapshot.data![index].address!.name}",
                          note: "${myAddressesSnapshot.data![index].address!.textInstructions}",
                          street: "${myAddressesSnapshot.data![index].address!.streetNo}",
                        )));
                        // Navigator.of(context).pushNamed(
                        //   AppRouts.EditaddressPage,
                        //   arguments: EditAddressPageArgs(
                        //     navigateFromAddresses: true,
                        //     street: "${myAddressesSnapshot.data![index].address!.streetNo}",
                        //     name: "${myAddressesSnapshot.data![index].address!.name}",
                        //     floor: "${myAddressesSnapshot.data![index].address!.floorNo}",
                        //     email: "${myAddressesSnapshot.data![index].address!.user!.email}",
                        //     building: "${myAddressesSnapshot.data![index].address!.buildingNo}",
                        //     block: "${myAddressesSnapshot.data![index].address!.block}",
                        //     avenue: "${myAddressesSnapshot.data![index].address!.avenue}",
                        //     area: myAddressesSnapshot.data![index].address!.area,
                        //     note: "${myAddressesSnapshot.data![index].address!.textInstructions}",
                        //     phone: "${myAddressesSnapshot.data![index].address!.user!.phone}",
                        //     addressId: "${myAddressesSnapshot.data![index].address!.id}",
                        //   ),
                        // );
                      },
                    ),
                  );
                }),
          ):NotAvailableComponent(
            view: FaIcon(
              FontAwesomeIcons.locationArrow,
              color: AppStyle.blueTextButtonOpacity,
              size: 80,
            ),
            title: ('${context.translate(AppStrings.there_are_no_addresses)}'),
          );
        }
      ),
    );
  }
}



void _deleteAddressClick(BuildContext context,addressId) {
  final myAddressesManager = context.use<MyAddressesManager>();
  final deleteAddressManager = context.use<DeleteAddressManager>();

  showDialog(
      context: context,
      builder: (_) {
        return TasawaaqDialog(
          titleTextAlign: TextAlign.start,
          contentTextAlign: TextAlign.start,
          confirmBtnTxt: '${context.translate(AppStrings.DELETE)}',
          columnCrossAxisAlignment: CrossAxisAlignment.start,
          onClickConfirmBtn: (){
            deleteAddressManager.deleteAddress(id: addressId).then((value) {
              myAddressesManager.execute();
              Navigator.of(context).pop();
            });

          },
          onCloseBtn: (){Navigator.of(context).pop();},
          title: '${context.translate(AppStrings.Delete_Address)}',
          description:
          '${context.translate(AppStrings.You_sure_delete_Address)}',
        );
      });
}

