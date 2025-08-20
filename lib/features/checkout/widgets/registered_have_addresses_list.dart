import 'package:flutter/material.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_routs/app_routs.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/features/addresses/add_address/add_address_manger.dart';
import 'package:tasawaaq/features/addresses/edite_address/edit_address_page.dart';
import 'package:tasawaaq/features/checkout/managers/checkout_info_manager.dart';
import 'package:tasawaaq/features/checkout/responses/checkout_info_response.dart';
import 'package:tasawaaq/features/checkout/widgets/address_desc.dart';
import 'package:tasawaaq/shared/custom_list_tile/custom_list_tile.dart';

class RegisteredUserWithAddresses extends StatefulWidget {
  final List<Addresses> addresses;

  const RegisteredUserWithAddresses({Key? key, required this.addresses})
      : super(key: key);

  @override
  _RegisteredUserWithAddressesState createState() =>
      _RegisteredUserWithAddressesState();
}

class _RegisteredUserWithAddressesState
    extends State<RegisteredUserWithAddresses> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final checkOutManager = context.use<CheckoutInfoManager>();

    return Container(
      child: ValueListenableBuilder<Address?>(
        valueListenable: checkOutManager.selectAddressSubject,
        builder: (context, value, _) {
          return Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey)),
                child: Column(
                  children: [
                    CustomAnimatedOpenTile(
                      vsync: this,
                      headerTxt:
                          '${context.translate(AppStrings.Select_Address)}',
                      body: Container(
                        // height: MediaQuery.of(context).size.height * .45,
                        child: ListView.separated(
                            separatorBuilder: (context, index) {
                              return Container(
                                child: Divider(),
                              );
                            },
                            shrinkWrap: true,
                            itemCount: widget.addresses.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  checkOutManager.selectAddressSubject.value = widget.addresses[index].address;
                                  setState(() {});
                                  checkOutManager.execute();
                                },
                                child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 7),
                                    child: Text("${widget.addresses[index].name}, ${widget.addresses[index].fullAddress}")),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              value == null
                  ? Container()
                  : Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppStyle.topLightGrey),
                      child: AddressDesc(
                        addressDesc:
                            "${value.name}, ${value.area?.name}, ${value.avenue}, ${value.block}, ${value.buildingNo}, ${value.floorNo}, ${value.streetNo}, ${value.textInstructions}",
                        onClickEditBtn: () {
                          locator<AddAddressManager>().selectAreaSubject.value =
                              value.area!;

                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditAddressPage(
                            navigateFromAddresses: false,
                            phone: '',
                            addressId: '${value.id}',
                            email: '',
                            // key: ,
                            area:  value.area,
                            avenue: '${value.avenue}',
                            block: '${value.block}',
                            building: '${value.buildingNo}',
                            floor: '${value.floorNo}',
                            name: '${value.name}',
                            note: '${value.textInstructions}',
                            street: '${value.streetNo}',
                          )));

                          // Navigator.of(context).pushNamed(
                          //   AppRouts.EditaddressPage,
                          //   arguments: EditAddressPageArgs(
                          //     navigateFromAddresses: false,
                          //     addressId: '${value.id}',
                          //     name: '${value.name}',
                          //     area: value.area,
                          //     avenue: '${value.avenue}',
                          //     block: '${value.block}',
                          //     building: '${value.buildingNo}',
                          //     floor: '${value.floorNo}',
                          //     street: '${value.streetNo}',
                          //     note: '${value.textInstructions}',
                          //   ),
                          // );
                        },
                      ),
                    )
            ],
          );
        },
      ),
    );
  }
}
