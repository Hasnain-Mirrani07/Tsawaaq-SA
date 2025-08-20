import 'package:flutter/material.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_core/services/prefs_service.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_routs/app_routs.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/features/addresses/add_address/add_address_manger.dart';
import 'package:tasawaaq/features/addresses/delete_address/delete_address_manger.dart';
import 'package:tasawaaq/features/addresses/edite_address/edit_address_page.dart';
import 'package:tasawaaq/features/checkout/managers/checkout_info_manager.dart';
import 'package:tasawaaq/features/checkout/responses/checkout_info_response.dart';
import 'package:tasawaaq/features/checkout/widgets/add_address_button.dart';
import 'package:tasawaaq/features/checkout/widgets/address_desc.dart';
import 'package:tasawaaq/features/checkout/widgets/registered_have_addresses_list.dart';

// final bool? hasAddresses = false;

class CheckOutShippingAddressesWidget extends StatefulWidget {
  final List<Addresses>? addresses;
  const CheckOutShippingAddressesWidget({Key? key, this.addresses})
      : super(key: key);

  @override
  _CheckOutShippingAddressesWidgetState createState() =>
      _CheckOutShippingAddressesWidgetState();
}

class _CheckOutShippingAddressesWidgetState
    extends State<CheckOutShippingAddressesWidget> {
  @override
  Widget build(BuildContext context) {
    final checkOutManager = context.use<CheckoutInfoManager>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 25,
        ),
        Text(
          '${context.translate(AppStrings.SHIPPING_ADDRESS)}',
          style: AppFontStyle.blueTextH3,
        ),
        SizedBox(
          height: 20,
        ),
        shippingAddresses(context, widget.addresses),
      ],
    );
  }

  Widget shippingAddresses(BuildContext context, List<Addresses>? addresses) {
    final prefs = context.use<PrefsService>();
    final checkOutManager = context.use<CheckoutInfoManager>();
    final deleteAddressManager = context.use<DeleteAddressManager>();

    Widget shippingAddresses;
    if (prefs.userObj == null) {
      if (addresses?.isNotEmpty ?? false) {
        checkOutManager.selectAddressSubject.value = addresses?[0].address;
        shippingAddresses = Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppStyle.topLightGrey),
          child: AddressDesc(
            namePhone:
                "${addresses?[0].address?.user?.name}, ${addresses?[0].address?.user?.phone}",
            addressDesc:
                // "${addresses?[0].name},"
                " ${addresses?[0].address?.area?.name}${addresses?[0].address?.area?.name == '' ? '' : ','} ${addresses?[0].address?.avenue}${addresses?[0].address?.avenue == '' ? '' : ','} ${addresses?[0].address?.block}${addresses?[0].address?.block == '' ? '' : ','} ${addresses?[0].address?.buildingNo}${addresses?[0].address?.buildingNo == '' ? '' : ','} ${addresses?[0].address?.floorNo}${addresses?[0].address?.floorNo == '' ? '' : ','} ${addresses?[0].address?.streetNo}${addresses?[0].address?.streetNo == '' ? '' : ','} ${addresses?[0].address?.textInstructions}${addresses?[0].address?.textInstructions == '' ? '' : ','}",
            onClickEditBtn: () {
              locator<AddAddressManager>().selectAreaSubject.value =
                  addresses![0].address!.area!;

              Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditAddressPage(
                navigateFromAddresses: false,
                phone: '${addresses[0].address?.user?.phone}',
                addressId: '${addresses[0].address?.id}',
                email: '${addresses[0].address?.user?.email}',
                // key: ,
                area: addresses[0].address?.area,
                avenue: '${addresses[0].address?.avenue}',
                block: '${addresses[0].address?.block}',
                building: '${addresses[0].address?.buildingNo}',
                floor: '${addresses[0].address?.floorNo}',
                name: '${addresses[0].address?.name}',
                note: '${addresses[0].address?.textInstructions}',
                street: '${addresses[0].address?.streetNo}',
              )));

              // Navigator.of(context).pushNamed(
              //   AppRouts.EditaddressPage,
              //   arguments: EditAddressPageArgs(
              //     email: '${addresses[0].address?.user?.email}',
              //     phone: '${addresses[0].address?.user?.phone}',
              //     navigateFromAddresses: false,
              //     addressId: '${addresses[0].address?.id}',
              //     name: '${addresses[0].address?.name}',
              //     area: addresses[0].address?.area,
              //     avenue: '${addresses[0].address?.avenue}',
              //     block: '${addresses[0].address?.block}',
              //     building: '${addresses[0].address?.buildingNo}',
              //     floor: '${addresses[0].address?.floorNo}',
              //     street: '${addresses[0].address?.streetNo}',
              //     note: '${addresses[0].address?.textInstructions}',
              //   ),
              // );
            },
            onClickDeleteBtn: () {
              deleteAddressManager
                  .deleteAddress(id: addresses?[0].address?.id)
                  .then((value) {
                if (value == ManagerState.SUCCESS) {
                  checkOutManager.selectAddressSubject.value = null;
                  checkOutManager.execute();
                }
              });
            },
          ),
        );
      } else {
        shippingAddresses = AddAddressButton();
      }
      // shippingAddresses = RegisteredUserWithAddresses();

    } else {
      if (addresses?.isNotEmpty ?? false) {
        shippingAddresses = RegisteredUserWithAddresses(
          addresses: addresses!,
        );
      } else {
        shippingAddresses = AddAddressButton();
      }
    }
    return shippingAddresses;
  }
}
