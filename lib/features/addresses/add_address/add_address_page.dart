import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:tasawaaq/app_core/app_core.dart';
import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
import 'package:tasawaaq/app_strings/app_strings.dart';
import 'package:tasawaaq/app_style/app_style.dart';
import 'package:tasawaaq/features/addresses/add_address/add_address_manger.dart';
import 'package:tasawaaq/features/addresses/add_address/add_address_request.dart';
import 'package:tasawaaq/features/addresses/add_address/add_address_response.dart';
import 'package:tasawaaq/features/addresses/area_get/area_get_manager.dart';
import 'package:tasawaaq/features/addresses/area_get/area_get_response.dart';
import 'package:tasawaaq/features/addresses/my_addresses/my_address_manager.dart';
import 'package:tasawaaq/features/addresses/my_addresses/my_addresses_response.dart';
import 'package:tasawaaq/features/checkout/managers/checkout_info_manager.dart';
import 'package:tasawaaq/shared/appbar/appbar.dart';
import 'package:tasawaaq/shared/custom_button/custom_button.dart';
import 'package:tasawaaq/shared/custom_list_tile/custom_list_tile.dart';
import 'package:tasawaaq/shared/custom_text_field/custom_text_field.dart';
import 'package:tasawaaq/shared/remove_focus/remove_focus.dart';

class AddAddressPageArgs {
  final bool navigateFromAddresses;
  AddAddressPageArgs({
    required this.navigateFromAddresses,
  });
}

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  _AddAddressPageState createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage>
    with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;



  final areaController = TextEditingController();
  final searchController = TextEditingController();
  final _nameTextEditing = TextEditingController();
  final _emailTextEditing = TextEditingController();
  final _phoneTextEditing = TextEditingController();
  final _blockTextEditing = TextEditingController();
  final _streetNumberTextEditing = TextEditingController();
  final _buildingNoTextEditing = TextEditingController();
  final _floorNoEditing = TextEditingController();
  final _avenueTextEditing = TextEditingController();
  final _otherInstructionsTextEditing = TextEditingController();



  String _name = "";
  // String _addressName = "";
  String _email = "";
  String _phone = "";
  String _area = "";
  String _block = "";
  String _streetNumber = "";
  String _buildingNo = "";
  String _floorNo = "";
  String _avenue = "";
  String _otherInstructions = "";

  final nameFocus = FocusNode();
  // final addressNameFocus = FocusNode();
  final emailFocus = FocusNode();
  final phoneFocus = FocusNode();
  final areaFocus = FocusNode();
  final blockFocus = FocusNode();
  final streetNumberFocus = FocusNode();
  final buildingNoFocus = FocusNode();
  final floorNoFocus = FocusNode();
  final avenueFocus = FocusNode();
  final otherInstructionsFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    // locator<AreaGetManager>().resetAreasList();
    locator<AddAddressManager>().selectAreaSubject.value = Area(
        id: 0,
        name: locator<PrefsService>().appLanguage == 'en' ? "Area" : "المنطقة");
    locator<AreaGetManager>().execute();

  }

  @override
  Widget build(BuildContext context) {
    final myAddressesManager = context.use<MyAddressesManager>();
    final prefs = context.use<PrefsService>();
    final addAddressManager = context.use<AddAddressManager>();
    final areaGetManager = context.use<AreaGetManager>();
    final ToastTemplate _showToast = context.use<ToastTemplate>();
    final checkoutInfoManager = context.use<CheckoutInfoManager>();

    final AddAddressPageArgs args =
    ModalRoute.of(context)!.settings.arguments as AddAddressPageArgs;

    return GestureDetector(
      onTap: () {
        removeFocus(context);
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          persistentFooterButtons: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              child: CustomButton(
                onClickBtn: () {
                  removeFocus(context);
                  if (_formKey.currentState!.validate()) {
                    // If all data are correct then save data to out variables
                    _formKey.currentState!.save();
                  } else {
                    // If all data are not valid then start auto validation.
                    setState(() {
                      _autoValidateMode = AutovalidateMode.always;
                    });
                    context.use<ToastTemplate>().show(
                        '${context.translate(AppStrings.PLEASE_ENTER_REQUIRED_FIELDS)}');
                    return;
                  }

                  if (locator<AddAddressManager>().selectAreaSubject.value ==
                      Area(
                          id: 0,
                          name: locator<PrefsService>().appLanguage == 'en'
                              ? "Area"
                              : "المنطقة")) {
                    _showToast.show(prefs.appLanguage == 'en'
                        ? "برجاء تحديد المنطقة"
                        : "please select area");
                    return;
                  }

                  addAddressManager
                      .addAddress(
                    request: AddressesRequest(
                        method: "post",
                        area: "${addAddressManager.selectAreaSubject.value.id}",
                        avenue: _avenue,
                        block: _block,
                        building: _buildingNo,
                        email: _email,
                        floor: _floorNo,
                        name: _name,
                        notes: _otherInstructions,
                        phone: _phone,
                        street: _streetNumber),
                  )
                      .then((value) {
                    if (value == ManagerState.SUCCESS) {
                      if (args.navigateFromAddresses == true) {
                        myAddressesManager.execute();
                      } else {
                        checkoutInfoManager.execute();
                      }
                      Navigator.of(context).pop();
                    }
                  });
                },
                txt: '${context.translate(AppStrings.ADD_ADDRESS)}',
                btnWidth: double.infinity,
                btnColor: AppStyle.yellowButton,
              ),
            )
          ],
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0),
            child: MainAppBar(
              title: Text('${context.translate(AppStrings.ADD_ADDRESS)}'),
              hasCart: false,
            ),
          ),
          body: Observer<AreaResponse>(
              onRetryClicked: () {
                areaGetManager.execute();
              },
              manager: areaGetManager,
              stream: areaGetManager.ereas$,
              onSuccess: (context, areaSnapShot) {
                return Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: StreamBuilder<ManagerState>(
                      initialData: ManagerState.IDLE,
                      stream: addAddressManager.state$,
                      builder:
                          (context, AsyncSnapshot<ManagerState> stateSnapshot) {
                        return FormsStateHandling(
                          managerState: stateSnapshot.data,
                          errorMsg: addAddressManager.errorDescription,
                          onClickCloseErrorBtn: () {
                            addAddressManager.inState.add(ManagerState.IDLE);
                          },
                          child: Container(
                            child: Form(
                              key: _formKey,
                              autovalidateMode: _autoValidateMode,
                              child: ListView(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  if (prefs.userObj == null)
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        //// start name
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 15),
                                          child: Text(
                                            "${AppLocalizations.of(context)!.translate(AppStrings.NAME)}*",
                                            style: AppFontStyle.blueTextH4,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CustomTextFiled(
                                          controller: _nameTextEditing,
                                          obscureText: false,
                                          currentFocus: nameFocus,
                                          maxLines: 1,
                                          onFieldSubmitted: (v) {
                                            FocusScope.of(context)
                                                .requestFocus(emailFocus);
                                          },
                                          // labelText: "block_rq_str",
                                          hintText:
                                          '${AppLocalizations.of(context)!.translate(AppStrings.Type_Here)}',
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "${AppLocalizations.of(context)!.translate('*required_str')}";
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            if (value.isNotEmpty) {
                                              _name = value;
                                            } else {
                                              _name = '';
                                            }
                                          },
                                          // keyboardType: TextInputType.emailAddress,
                                        ),
                                        //// end name
                                        SizedBox(
                                          height: 25,
                                        ),
                                        //// start email
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 15),
                                          child: Text(
                                            "${AppLocalizations.of(context)!.translate(AppStrings.EMAIL_ADDRESS_)}*",
                                            style: AppFontStyle.blueTextH4,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CustomTextFiled(
                                          controller: _emailTextEditing,
                                          keyboardType:
                                          TextInputType.emailAddress,
                                          obscureText: false,
                                          currentFocus: emailFocus,
                                          maxLines: 1,
                                          onFieldSubmitted: (v) {
                                            FocusScope.of(context)
                                                .requestFocus(phoneFocus);
                                          },
                                          hintText:
                                          '${AppLocalizations.of(context)!.translate(AppStrings.Type_Here)}',
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "${AppLocalizations.of(context)!.translate('*required_str')}";
                                            } else if (!EmailValidator.validate(
                                                value)) {
                                              return "${AppLocalizations.of(context)!.translate('EnterAValidEmail_str')}";
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            if (value.isNotEmpty) {
                                              _email = value;
                                            } else {
                                              _email = '';
                                            }
                                          },
                                        ),
                                        //// end email
                                        SizedBox(
                                          height: 25,
                                        ),
                                        //// start phone
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 15),
                                          child: Text(
                                            "${AppLocalizations.of(context)!.translate(AppStrings.PHONE_NUMBER)}*",
                                            style: AppFontStyle.blueTextH4,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CustomTextFiled(
                                          controller: _phoneTextEditing,
                                          keyboardType: TextInputType.phone,
                                          obscureText: false,
                                          currentFocus: phoneFocus,
                                          maxLines: 1,
                                          onFieldSubmitted: (v) {
                                            // FocusScope.of(context).requestFocus(phoneFocus);
                                          },
                                          hintText:
                                          '${AppLocalizations.of(context)!.translate(AppStrings.Type_Here)}',
                                          validator: (value) {
                                            if (prefs.userObj == null) {
                                              if (value!.isEmpty) {
                                                return "${AppLocalizations.of(context)!.translate('*required_str')}";
                                              } else if (value.length != 8) {
                                                return '${AppLocalizations.of(context)!.translate(AppStrings.PHONE_MSG)}';
                                              }
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            if (value.isNotEmpty) {
                                              _phone = value;
                                            } else {
                                              _phone = '';
                                            }
                                          },
                                        ),
                                        //// end phone
                                      ],
                                    ),

                                  //// start address name
                                  if (prefs.userObj != null)
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 15),

                                          child: Text(
                                            "${AppLocalizations.of(context)!.translate(AppStrings.ADDRESS_NAME_)}*",
                                            style: AppFontStyle.blueTextH4,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CustomTextFiled(
                                          controller: _nameTextEditing,
                                          obscureText: false,
                                          currentFocus: nameFocus,
                                          maxLines: 1,
                                          onFieldSubmitted: (v) {
                                            FocusScope.of(context)
                                                .requestFocus(emailFocus);
                                          },
                                          // labelText: "block_rq_str",
                                          hintText:
                                          '${AppLocalizations.of(context)!.translate(AppStrings.Type_Here)}',
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "${AppLocalizations.of(context)!.translate('*required_str')}";
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            if (value.isNotEmpty) {
                                              _name = value;
                                            } else {
                                              _name = '';
                                            }
                                          },
                                          // keyboardType: TextInputType.emailAddress,
                                        ),
                                      ],
                                    ),
                                  //// end address name

                                  SizedBox(
                                    height: 25,
                                  ),

                                  //// start select area
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15),

                                    child:  Text(
                                      "${AppLocalizations.of(context)!.translate(AppStrings.Area)}*",
                                      style: AppFontStyle.blueTextH4,
                                    ),),
                                  SizedBox(
                                    height: 10,
                                  ),


                                  InkWell(
                                    onTap: (){
                                      showDialog(context: context, builder: (context) => AlertDialog( content: Container(
                                        height: MediaQuery.of(context).size.height * .7,
                                        width: MediaQuery.of(context).size.width * .9,
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            CustomTextFiled(
                                              controller: searchController,
                                              borderRadius: 10,
                                              borderColor: AppStyle.blueTextButton,
                                              obscureText: false,
                                              maxLines: 1,
                                              suffixIcon: InkWell(
                                                // onTap: (){
                                                //
                                                // },
                                                child: Icon(Icons.search),
                                              ),
                                              // onFieldSubmitted: (v) {
                                              //   FocusScope.of(context)
                                              //       .requestFocus(emailFocus);
                                              // },
                                              // labelText: "block_rq_str",
                                              hintText:
                                              '${AppLocalizations.of(context)!.translate(AppStrings.SEARCH)}',
                                              // validator: (value) {
                                              //   if (value!.isEmpty) {
                                              //     return "${AppLocalizations.of(context)!.translate('*required_str')}";
                                              //   }
                                              //   return null;
                                              // },
                                              onChanged: (value) {
                                                if (value.isNotEmpty) {
                                                  areaGetManager.searchInAreas(word: value);
                                                }
                                                //   _name = value;
                                                // } else {
                                                //   _name = '';
                                                // }
                                              },
                                              // keyboardType: TextInputType.emailAddress,
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Expanded(
                                              child: StreamBuilder<List<Area>>(
                                                  initialData: const [],
                                                  stream: areaGetManager.areaSearchListSubject,
                                                  builder: (context, areaSearchListSnapshot) {
                                                    return ListView.separated(

                                                      // physics:
                                                      // NeverScrollableScrollPhysics(),
                                                        separatorBuilder:
                                                            (context, index) {
                                                          return Container(
                                                            child: Divider(),
                                                          );
                                                        },
                                                        // shrinkWrap: true,
                                                        itemCount:
                                                        areaSearchListSnapshot.data!.length,
                                                        // itemCount: areaSnapShot.data!.length,
                                                        itemBuilder: (context, index) {
                                                          return ValueListenableBuilder<Area>(
                                                              valueListenable:
                                                              addAddressManager.selectAreaSubject,
                                                              builder: (context, areaValue, _) {
                                                                return InkWell(
                                                                  onTap: () {
                                                                    areaController.text = "${areaSearchListSnapshot.data![index].name}";
                                                                    addAddressManager
                                                                        .selectAreaSubject
                                                                        .value =
                                                                    areaSearchListSnapshot
                                                                        .data![index];
                                                                    Navigator.of(context).pop();
                                                                    // setState(() {});
                                                                  },
                                                                  child: Container(
                                                                      padding:
                                                                      const EdgeInsets
                                                                          .symmetric(
                                                                          vertical: 7),
                                                                      child: Text(
                                                                          "${areaSearchListSnapshot.data![index].name}")),
                                                                );
                                                              }
                                                          );
                                                        });
                                                  }
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),));

                                    },
                                    child: CustomTextFiled(
                                      controller: areaController,
                                      enable: false,
                                      hintText: "${AppLocalizations.of(context)!.translate(AppStrings.Area)}",
                                      obscureText: false,
                                      // currentFocus: nameFocus,
                                      maxLines: 1,

                                      // keyboardType: TextInputType.emailAddress,
                                    ),
                                  ),


                                  // Container(
                                  //   padding: EdgeInsets.symmetric(
                                  //       horizontal: 15, vertical: 12),
                                  //   decoration: BoxDecoration(
                                  //       borderRadius: BorderRadius.circular(15),
                                  //       border: Border.all(color: Colors.grey)),
                                  //   child: ValueListenableBuilder<Area>(
                                  //       valueListenable:
                                  //           addAddressManager.selectAreaSubject,
                                  //       builder: (context, areaValue, _) {
                                  //         return CustomAnimatedOpenTile(
                                  //           vsync: this,
                                  //           headerTxt: '${areaValue.name}',
                                  //           body:
                                  //         );
                                  //       }),
                                  // ),

                                  //// end select area
                                  SizedBox(
                                    height: 25,
                                  ),
//// start Row of Block & street number

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      //// start select Block
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 15),
                                              child:Text(
                                                "${AppLocalizations.of(context)!.translate(AppStrings.Block_no)}*",
                                                style: AppFontStyle.blueTextH4,
                                              ),),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            CustomTextFiled(
                                              controller: _blockTextEditing,
                                              obscureText: false,
                                              currentFocus: blockFocus,
                                              maxLines: 1,
                                              onFieldSubmitted: (v) {
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                    streetNumberFocus);
                                              },
                                              // labelText: "block_rq_str",
                                              hintText:
                                              '${AppLocalizations.of(context)!.translate(AppStrings.Type_Here)}',
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "${AppLocalizations.of(context)!.translate('*required_str')}";
                                                }
                                                return null;
                                              },
                                              onChanged: (value) {
                                                if (value.isNotEmpty) {
                                                  _block = value;
                                                } else {
                                                  _block = '';
                                                }
                                              },
                                              // keyboardType: TextInputType.emailAddress,
                                            ),
                                          ],
                                        ),
                                      ),
                                      //// end select Block
                                      SizedBox(
                                        width: 15,
                                      ),
                                      //// start select street Number
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 15),
                                              child: Text(
                                                "${AppLocalizations.of(context)!.translate(AppStrings.STREET_NUMBER_)}*",
                                                style: AppFontStyle.blueTextH4,
                                              ),),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            CustomTextFiled(
                                              controller: _streetNumberTextEditing,
                                              obscureText: false,
                                              currentFocus: streetNumberFocus,
                                              maxLines: 1,
                                              onFieldSubmitted: (v) {
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                    buildingNoFocus);
                                              },
                                              hintText:
                                              '${AppLocalizations.of(context)!.translate(AppStrings.Type_Here)}',
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "${AppLocalizations.of(context)!.translate('*required_str')}";
                                                }
                                                return null;
                                              },
                                              onChanged: (value) {
                                                if (value.isNotEmpty) {
                                                  _streetNumber = value;
                                                } else {
                                                  _streetNumber = '';
                                                }
                                              },
                                              // keyboardType: TextInputType.emailAddress,
                                            ),
                                          ],
                                        ),
                                      )
                                      //// end select street number
                                    ],
                                  ),

                                  //// end Row of Block & street number

                                  SizedBox(
                                    height: 25,
                                  ),

                                  //// start Row of bulding & FLOOR number

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      //// start select Block
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 15),
                                              child: Text(
                                                "${AppLocalizations.of(context)!.translate(AppStrings.BUILDING_NUMBER_)}*",
                                                style: AppFontStyle.blueTextH4,
                                              ),),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            CustomTextFiled(
                                              controller: _buildingNoTextEditing,
                                              obscureText: false,
                                              currentFocus: buildingNoFocus,
                                              maxLines: 1,
                                              onFieldSubmitted: (v) {
                                                FocusScope.of(context)
                                                    .requestFocus(floorNoFocus);
                                              },
                                              hintText:
                                              '${AppLocalizations.of(context)!.translate(AppStrings.Type_Here)}',
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "${AppLocalizations.of(context)!.translate('*required_str')}";
                                                }
                                                return null;
                                              },
                                              onChanged: (value) {
                                                if (value.isNotEmpty) {
                                                  _buildingNo = value;
                                                } else {
                                                  _buildingNo = '';
                                                }
                                              },
                                              // keyboardType: TextInputType.emailAddress,
                                            ),
                                          ],
                                        ),
                                      ),
                                      //// end select Block
                                      SizedBox(
                                        width: 15,
                                      ),
                                      //// start select street Number
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 15),
                                              child: Text(
                                                "${AppLocalizations.of(context)!.translate(AppStrings.Floor_Str)}",
                                                style: AppFontStyle.blueTextH4,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            CustomTextFiled(
                                              controller: _floorNoEditing,
                                              obscureText: false,
                                              currentFocus: floorNoFocus,
                                              maxLines: 1,
                                              onFieldSubmitted: (v) {
                                                FocusScope.of(context)
                                                    .requestFocus(avenueFocus);
                                              },
                                              hintText:
                                              '${AppLocalizations.of(context)!.translate(AppStrings.Type_Here)}',
                                              onChanged: (value) {
                                                if (value.isNotEmpty) {
                                                  _floorNo = value;
                                                } else {
                                                  _floorNo = '';
                                                }
                                              },
                                              // keyboardType: TextInputType.emailAddress,
                                            ),
                                          ],
                                        ),
                                      )
                                      //// end select street number
                                    ],
                                  ),

                                  //// end Row of bulding & FLOOR number

                                  SizedBox(
                                    height: 15,
                                  ),
                                  //// start avenue
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      //// start select Block
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 15),
                                              child: Text(
                                                "${AppLocalizations.of(context)!.translate(AppStrings.AVENUE)}",
                                                style: AppFontStyle.blueTextH4,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            CustomTextFiled(
                                              controller: _avenueTextEditing,
                                              obscureText: false,
                                              currentFocus: avenueFocus,
                                              maxLines: 1,
                                              onFieldSubmitted: (v) {
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                    otherInstructionsFocus);
                                              },
                                              hintText:
                                              '${AppLocalizations.of(context)!.translate(AppStrings.Type_Here)}',
                                              onChanged: (value) {
                                                if (value.isNotEmpty) {
                                                  _avenue = value;
                                                } else {
                                                  _avenue = '';
                                                }
                                              },
                                              // keyboardType: TextInputType.emailAddress,
                                            ),
                                          ],
                                        ),
                                      ),
                                      //// end select Block
                                      SizedBox(
                                        width: 15,
                                      ),
                                      //// start select street Number
                                      Expanded(
                                        child: Container(),
                                      )
                                      //// end select street number
                                    ],
                                  ),

                                  //// end avenue

                                  SizedBox(
                                    height: 25,
                                  ),

                                  //// start Other Instructions
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15),
                                    child:Text(
                                      "${AppLocalizations.of(context)!.translate(AppStrings.OTHER_INSTRUCTIONS)}",
                                      style: AppFontStyle.blueTextH4,
                                    ),),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CustomTextFiled(
                                    controller: _otherInstructionsTextEditing,
                                    isTextArea: true,
                                    obscureText: false,
                                    currentFocus: otherInstructionsFocus,
                                    maxLines: 4,

                                    onFieldSubmitted: (v) {},
                                    hintText:
                                    '${AppLocalizations.of(context)!.translate(AppStrings.Type_Here)}',
                                    onChanged: (value) {
                                      if (value.isNotEmpty) {
                                        _otherInstructions = value;
                                      } else {
                                        _otherInstructions = '';
                                      }
                                    },
                                    // keyboardType: TextInputType.emailAddress,
                                  ),
                                  //// end Other Instructions
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                );
              })),
    );
  }
}


// import 'package:email_validator/email_validator.dart';
// import 'package:flutter/material.dart';
// import 'package:tasawaaq/app_core/app_core.dart';
// import 'package:tasawaaq/app_font_styles/app_font_styles.dart';
// import 'package:tasawaaq/app_strings/app_strings.dart';
// import 'package:tasawaaq/app_style/app_style.dart';
// import 'package:tasawaaq/features/addresses/add_address/add_address_manger.dart';
// import 'package:tasawaaq/features/addresses/add_address/add_address_request.dart';
// import 'package:tasawaaq/features/addresses/area_get/area_get_manager.dart';
// import 'package:tasawaaq/features/addresses/area_get/area_get_response.dart';
// import 'package:tasawaaq/features/addresses/my_addresses/my_address_manager.dart';
// import 'package:tasawaaq/features/addresses/my_addresses/my_addresses_response.dart';
// import 'package:tasawaaq/features/checkout/managers/checkout_info_manager.dart';
// import 'package:tasawaaq/shared/appbar/appbar.dart';
// import 'package:tasawaaq/shared/custom_button/custom_button.dart';
// import 'package:tasawaaq/shared/custom_list_tile/custom_list_tile.dart';
// import 'package:tasawaaq/shared/custom_text_field/custom_text_field.dart';
// import 'package:tasawaaq/shared/remove_focus/remove_focus.dart';
//
// class AddAddressPageArgs {
//   final bool navigateFromAddresses;
//   AddAddressPageArgs({
//     required this.navigateFromAddresses,
//   });
// }
//
// class AddAddressPage extends StatefulWidget {
//   const AddAddressPage({Key? key}) : super(key: key);
//
//   @override
//   _AddAddressPageState createState() => _AddAddressPageState();
// }
//
// class _AddAddressPageState extends State<AddAddressPage>
//     with TickerProviderStateMixin {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
//
//
//
//   final _nameTextEditing = TextEditingController();
//   final _emailTextEditing = TextEditingController();
//   final _phoneTextEditing = TextEditingController();
//   final _blockTextEditing = TextEditingController();
//   final _streetNumberTextEditing = TextEditingController();
//   final _buildingNoTextEditing = TextEditingController();
//   final _floorNoEditing = TextEditingController();
//   final _avenueTextEditing = TextEditingController();
//   final _otherInstructionsTextEditing = TextEditingController();
//
//
//
//   String _name = "";
//   // String _addressName = "";
//   String _email = "";
//   String _phone = "";
//   String _area = "";
//   String _block = "";
//   String _streetNumber = "";
//   String _buildingNo = "";
//   String _floorNo = "";
//   String _avenue = "";
//   String _otherInstructions = "";
//
//   final nameFocus = FocusNode();
//   // final addressNameFocus = FocusNode();
//   final emailFocus = FocusNode();
//   final phoneFocus = FocusNode();
//   final areaFocus = FocusNode();
//   final blockFocus = FocusNode();
//   final streetNumberFocus = FocusNode();
//   final buildingNoFocus = FocusNode();
//   final floorNoFocus = FocusNode();
//   final avenueFocus = FocusNode();
//   final otherInstructionsFocus = FocusNode();
//
//   @override
//   void initState() {
//     super.initState();
//     locator<AddAddressManager>().selectAreaSubject.value = Area(
//         id: 0,
//         name: locator<PrefsService>().appLanguage == 'en' ? "Area" : "المنطقة");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final myAddressesManager = context.use<MyAddressesManager>();
//     final prefs = context.use<PrefsService>();
//     final addAddressManager = context.use<AddAddressManager>();
//     final areaGetManager = context.use<AreaGetManager>();
//     final ToastTemplate _showToast = context.use<ToastTemplate>();
//     final checkoutInfoManager = context.use<CheckoutInfoManager>();
//
//     final AddAddressPageArgs args =
//         ModalRoute.of(context)!.settings.arguments as AddAddressPageArgs;
//
//     return GestureDetector(
//       onTap: () {
//         removeFocus(context);
//       },
//       child: Scaffold(
//           backgroundColor: Colors.white,
//           persistentFooterButtons: [
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
//               child: CustomButton(
//                 onClickBtn: () {
//                   removeFocus(context);
//                   if (_formKey.currentState!.validate()) {
//                     // If all data are correct then save data to out variables
//                     _formKey.currentState!.save();
//                   } else {
//                     // If all data are not valid then start auto validation.
//                     setState(() {
//                       _autoValidateMode = AutovalidateMode.always;
//                     });
//                     context.use<ToastTemplate>().show(
//                         '${context.translate(AppStrings.PLEASE_ENTER_REQUIRED_FIELDS)}');
//                     return;
//                   }
//
//                   if (locator<AddAddressManager>().selectAreaSubject.value ==
//                       Area(
//                           id: 0,
//                           name: locator<PrefsService>().appLanguage == 'en'
//                               ? "Area"
//                               : "المنطقة")) {
//                     _showToast.show(prefs.appLanguage == 'en'
//                         ? "برجاء تحديد المنطقة"
//                         : "please select area");
//                     return;
//                   }
//
//                   addAddressManager
//                       .addAddress(
//                     request: AddressesRequest(
//                         method: "post",
//                         area: "${addAddressManager.selectAreaSubject.value.id}",
//                         avenue: _avenue,
//                         block: _block,
//                         building: _buildingNo,
//                         email: _email,
//                         floor: _floorNo,
//                         name: _name,
//                         notes: _otherInstructions,
//                         phone: _phone,
//                         street: _streetNumber),
//                   )
//                       .then((value) {
//                     if (value == ManagerState.SUCCESS) {
//                       if (args.navigateFromAddresses == true) {
//                       } else {
//                       }
//                       Navigator.of(context).pop();
//                     }
//                   });
//                 },
//                 txt: '${context.translate(AppStrings.ADD_ADDRESS)}',
//                 btnWidth: double.infinity,
//                 btnColor: AppStyle.yellowButton,
//               ),
//             )
//           ],
//           appBar: PreferredSize(
//             preferredSize: Size.fromHeight(60.0),
//             child: MainAppBar(
//               title: Text('${context.translate(AppStrings.ADD_ADDRESS)}'),
//               hasCart: false,
//             ),
//           ),
//           body: Observer<AreaResponse>(
//               onRetryClicked: () {
//               },
//               manager: areaGetManager,
//               onSuccess: (context, areaSnapShot) {
//                 return Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
//                   child: StreamBuilder<ManagerState>(
//                       initialData: ManagerState.IDLE,
//                       stream: addAddressManager.state$,
//                       builder:
//                           (context, AsyncSnapshot<ManagerState> stateSnapshot) {
//                         return FormsStateHandling(
//                           managerState: stateSnapshot.data,
//                           errorMsg: addAddressManager.errorDescription,
//                           onClickCloseErrorBtn: () {
//                             addAddressManager.inState.add(ManagerState.IDLE);
//                           },
//                           child: Container(
//                             child: Form(
//                               key: _formKey,
//                               autovalidateMode: _autoValidateMode,
//                               child: ListView(
//                                 children: [
//                                   SizedBox(
//                                     height: 20,
//                                   ),
//                                   if (prefs.userObj == null)
//                                     Column(
//                                       mainAxisAlignment: MainAxisAlignment.start,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         //// start name
//                                         Padding(
//                                           padding: const EdgeInsets.symmetric(horizontal: 15),
//                                           child: Text(
//                                             "${AppLocalizations.of(context)!.translate(AppStrings.NAME)}*",
//                                             style: AppFontStyle.blueTextH4,
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           height: 10,
//                                         ),
//                                         CustomTextFiled(
//                                           controller: _nameTextEditing,
//                                           obscureText: false,
//                                           currentFocus: nameFocus,
//                                           maxLines: 1,
//                                           onFieldSubmitted: (v) {
//                                             FocusScope.of(context)
//                                                 .requestFocus(emailFocus);
//                                           },
//                                           // labelText: "block_rq_str",
//                                           hintText:
//                                               '${AppLocalizations.of(context)!.translate(AppStrings.Type_Here)}',
//                                           validator: (value) {
//                                             if (value!.isEmpty) {
//                                               return "${AppLocalizations.of(context)!.translate('*required_str')}";
//                                             }
//                                             return null;
//                                           },
//                                           onChanged: (value) {
//                                             if (value.isNotEmpty) {
//                                               _name = value;
//                                             } else {
//                                               _name = '';
//                                             }
//                                           },
//                                           // keyboardType: TextInputType.emailAddress,
//                                         ),
//                                         //// end name
//                                         SizedBox(
//                                           height: 25,
//                                         ),
//                                         //// start email
//                                         Padding(
//                                           padding: const EdgeInsets.symmetric(horizontal: 15),
//                                           child: Text(
//                                             "${AppLocalizations.of(context)!.translate(AppStrings.EMAIL_ADDRESS_)}*",
//                                             style: AppFontStyle.blueTextH4,
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           height: 10,
//                                         ),
//                                         CustomTextFiled(
//                                           controller: _emailTextEditing,
//                                           keyboardType:
//                                               TextInputType.emailAddress,
//                                           obscureText: false,
//                                           currentFocus: emailFocus,
//                                           maxLines: 1,
//                                           onFieldSubmitted: (v) {
//                                             FocusScope.of(context)
//                                                 .requestFocus(phoneFocus);
//                                           },
//                                           hintText:
//                                               '${AppLocalizations.of(context)!.translate(AppStrings.Type_Here)}',
//                                           validator: (value) {
//                                             if (value!.isEmpty) {
//                                               return "${AppLocalizations.of(context)!.translate('*required_str')}";
//                                             } else if (!EmailValidator.validate(
//                                                 value)) {
//                                               return "${AppLocalizations.of(context)!.translate('EnterAValidEmail_str')}";
//                                             }
//                                             return null;
//                                           },
//                                           onChanged: (value) {
//                                             if (value.isNotEmpty) {
//                                               _email = value;
//                                             } else {
//                                               _email = '';
//                                             }
//                                           },
//                                         ),
//                                         //// end email
//                                         SizedBox(
//                                           height: 25,
//                                         ),
//                                         //// start phone
//                                         Padding(
//                                           padding: const EdgeInsets.symmetric(horizontal: 15),
//                                           child: Text(
//                                             "${AppLocalizations.of(context)!.translate(AppStrings.PHONE_NUMBER)}*",
//                                             style: AppFontStyle.blueTextH4,
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           height: 10,
//                                         ),
//                                         CustomTextFiled(
//                                           controller: _phoneTextEditing,
//                                           keyboardType: TextInputType.phone,
//                                           obscureText: false,
//                                           currentFocus: phoneFocus,
//                                           maxLines: 1,
//                                           onFieldSubmitted: (v) {
//                                             // FocusScope.of(context).requestFocus(phoneFocus);
//                                           },
//                                           hintText:
//                                               '${AppLocalizations.of(context)!.translate(AppStrings.Type_Here)}',
//                                           validator: (value) {
//                                             if (prefs.userObj == null) {
//                                               if (value!.isEmpty) {
//                                                 return "${AppLocalizations.of(context)!.translate('*required_str')}";
//                                               } else if (value.length != 8) {
//                                                 return '${AppLocalizations.of(context)!.translate(AppStrings.PHONE_MSG)}';
//                                               }
//                                             }
//                                             return null;
//                                           },
//                                           onChanged: (value) {
//                                             if (value.isNotEmpty) {
//                                               _phone = value;
//                                             } else {
//                                               _phone = '';
//                                             }
//                                           },
//                                         ),
//                                         //// end phone
//                                       ],
//                                     ),
//
//                                   //// start address name
//                                   if (prefs.userObj != null)
//                                     Column(
//                                       mainAxisAlignment: MainAxisAlignment.start,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Padding(
//                                           padding: const EdgeInsets.symmetric(horizontal: 15),
//
//                                           child: Text(
//                                             "${AppLocalizations.of(context)!.translate(AppStrings.ADDRESS_NAME_)}*",
//                                             style: AppFontStyle.blueTextH4,
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           height: 10,
//                                         ),
//                                         CustomTextFiled(
//                                           controller: _nameTextEditing,
//                                           obscureText: false,
//                                           currentFocus: nameFocus,
//                                           maxLines: 1,
//                                           onFieldSubmitted: (v) {
//                                             FocusScope.of(context)
//                                                 .requestFocus(emailFocus);
//                                           },
//                                           // labelText: "block_rq_str",
//                                           hintText:
//                                               '${AppLocalizations.of(context)!.translate(AppStrings.Type_Here)}',
//                                           validator: (value) {
//                                             if (value!.isEmpty) {
//                                               return "${AppLocalizations.of(context)!.translate('*required_str')}";
//                                             }
//                                             return null;
//                                           },
//                                           onChanged: (value) {
//                                             if (value.isNotEmpty) {
//                                               _name = value;
//                                             } else {
//                                               _name = '';
//                                             }
//                                           },
//                                           // keyboardType: TextInputType.emailAddress,
//                                         ),
//                                       ],
//                                     ),
//                                   //// end address name
//
//                                   SizedBox(
//                                     height: 25,
//                                   ),
//
//                                   //// start select area
//                                   Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 15),
//
//                                child:  Text(
//                                     "${AppLocalizations.of(context)!.translate(AppStrings.Area)}*",
//                                     style: AppFontStyle.blueTextH4,
//                                   ),),
//                                   SizedBox(
//                                     height: 10,
//                                   ),
//                                   Container(
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal: 15, vertical: 12),
//                                     decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(15),
//                                         border: Border.all(color: Colors.grey)),
//                                     child: ValueListenableBuilder<Area>(
//                                         valueListenable:
//                                             addAddressManager.selectAreaSubject,
//                                         builder: (context, areaValue, _) {
//                                           return CustomAnimatedOpenTile(
//                                             vsync: this,
//                                             headerTxt: '${areaValue.name}',
//                                             body: Container(
//                                               // height: MediaQuery.of(context).size.height * .45,
//                                               child: ListView.separated(
//                                                   physics:
//                                                       NeverScrollableScrollPhysics(),
//                                                   separatorBuilder:
//                                                       (context, index) {
//                                                     return Container(
//                                                       child: Divider(),
//                                                     );
//                                                   },
//                                                   shrinkWrap: true,
//                                                   itemCount:
//                                                       areaSnapShot.data!.length,
//                                                   // itemCount: areaSnapShot.data!.length,
//                                                   itemBuilder: (context, index) {
//                                                     return InkWell(
//                                                       onTap: () {
//                                                         addAddressManager
//                                                                 .selectAreaSubject
//                                                                 .value =
//                                                             areaSnapShot
//                                                                 .data![index];
//                                                         setState(() {});
//                                                       },
//                                                       child: Container(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                       .symmetric(
//                                                                   vertical: 7),
//                                                           child: Text(
//                                                               "${areaSnapShot.data![index].name}")),
//                                                     );
//                                                   }),
//                                             ),
//                                           );
//                                         }),
//                                   ),
//
//                                   //// end select area
//                                   SizedBox(
//                                     height: 25,
//                                   ),
// //// start Row of Block & street number
//
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       //// start select Block
//                                       Expanded(
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Padding(
//                                               padding: const EdgeInsets.symmetric(horizontal: 15),
//                                               child:Text(
//                                               "${AppLocalizations.of(context)!.translate(AppStrings.Block_no)}*",
//                                               style: AppFontStyle.blueTextH4,
//                                             ),),
//                                             SizedBox(
//                                               height: 10,
//                                             ),
//                                             CustomTextFiled(
//                                               controller: _blockTextEditing,
//                                               obscureText: false,
//                                               currentFocus: blockFocus,
//                                               maxLines: 1,
//                                               onFieldSubmitted: (v) {
//                                                 FocusScope.of(context)
//                                                     .requestFocus(
//                                                         streetNumberFocus);
//                                               },
//                                               // labelText: "block_rq_str",
//                                               hintText:
//                                                   '${AppLocalizations.of(context)!.translate(AppStrings.Type_Here)}',
//                                               validator: (value) {
//                                                 if (value!.isEmpty) {
//                                                   return "${AppLocalizations.of(context)!.translate('*required_str')}";
//                                                 }
//                                                 return null;
//                                               },
//                                               onChanged: (value) {
//                                                 if (value.isNotEmpty) {
//                                                   _block = value;
//                                                 } else {
//                                                   _block = '';
//                                                 }
//                                               },
//                                               // keyboardType: TextInputType.emailAddress,
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       //// end select Block
//                                       SizedBox(
//                                         width: 15,
//                                       ),
//                                       //// start select street Number
//                                       Expanded(
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                             Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 15),
//                             child: Text(
//                                               "${AppLocalizations.of(context)!.translate(AppStrings.STREET_NUMBER_)}*",
//                                               style: AppFontStyle.blueTextH4,
//                                             ),),
//                                             SizedBox(
//                                               height: 10,
//                                             ),
//                                             CustomTextFiled(
//                                               controller: _streetNumberTextEditing,
//                                               obscureText: false,
//                                               currentFocus: streetNumberFocus,
//                                               maxLines: 1,
//                                               onFieldSubmitted: (v) {
//                                                 FocusScope.of(context)
//                                                     .requestFocus(
//                                                         buildingNoFocus);
//                                               },
//                                               hintText:
//                                                   '${AppLocalizations.of(context)!.translate(AppStrings.Type_Here)}',
//                                               validator: (value) {
//                                                 if (value!.isEmpty) {
//                                                   return "${AppLocalizations.of(context)!.translate('*required_str')}";
//                                                 }
//                                                 return null;
//                                               },
//                                               onChanged: (value) {
//                                                 if (value.isNotEmpty) {
//                                                   _streetNumber = value;
//                                                 } else {
//                                                   _streetNumber = '';
//                                                 }
//                                               },
//                                               // keyboardType: TextInputType.emailAddress,
//                                             ),
//                                           ],
//                                         ),
//                                       )
//                                       //// end select street number
//                                     ],
//                                   ),
//
//                                   //// end Row of Block & street number
//
//                                   SizedBox(
//                                     height: 25,
//                                   ),
//
//                                   //// start Row of bulding & FLOOR number
//
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       //// start select Block
//                                       Expanded(
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                   Padding(
//                                   padding: const EdgeInsets.symmetric(horizontal: 15),
//                                   child: Text(
//                                               "${AppLocalizations.of(context)!.translate(AppStrings.BUILDING_NUMBER_)}*",
//                                               style: AppFontStyle.blueTextH4,
//                                             ),),
//                                             SizedBox(
//                                               height: 10,
//                                             ),
//                                             CustomTextFiled(
//                                               controller: _buildingNoTextEditing,
//                                               obscureText: false,
//                                               currentFocus: buildingNoFocus,
//                                               maxLines: 1,
//                                               onFieldSubmitted: (v) {
//                                                 FocusScope.of(context)
//                                                     .requestFocus(floorNoFocus);
//                                               },
//                                               hintText:
//                                                   '${AppLocalizations.of(context)!.translate(AppStrings.Type_Here)}',
//                                               validator: (value) {
//                                                 if (value!.isEmpty) {
//                                                   return "${AppLocalizations.of(context)!.translate('*required_str')}";
//                                                 }
//                                                 return null;
//                                               },
//                                               onChanged: (value) {
//                                                 if (value.isNotEmpty) {
//                                                   _buildingNo = value;
//                                                 } else {
//                                                   _buildingNo = '';
//                                                 }
//                                               },
//                                               // keyboardType: TextInputType.emailAddress,
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       //// end select Block
//                                       SizedBox(
//                                         width: 15,
//                                       ),
//                                       //// start select street Number
//                                       Expanded(
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Padding(
//                                               padding: const EdgeInsets.symmetric(horizontal: 15),
//                                               child: Text(
//                                                 "${AppLocalizations.of(context)!.translate(AppStrings.Floor_Str)}",
//                                                 style: AppFontStyle.blueTextH4,
//                                               ),
//                                             ),
//                                             SizedBox(
//                                               height: 10,
//                                             ),
//                                             CustomTextFiled(
//                                               controller: _floorNoEditing,
//                                               obscureText: false,
//                                               currentFocus: floorNoFocus,
//                                               maxLines: 1,
//                                               onFieldSubmitted: (v) {
//                                                 FocusScope.of(context)
//                                                     .requestFocus(avenueFocus);
//                                               },
//                                               hintText:
//                                                   '${AppLocalizations.of(context)!.translate(AppStrings.Type_Here)}',
//                                               onChanged: (value) {
//                                                 if (value.isNotEmpty) {
//                                                   _floorNo = value;
//                                                 } else {
//                                                   _floorNo = '';
//                                                 }
//                                               },
//                                               // keyboardType: TextInputType.emailAddress,
//                                             ),
//                                           ],
//                                         ),
//                                       )
//                                       //// end select street number
//                                     ],
//                                   ),
//
//                                   //// end Row of bulding & FLOOR number
//
//                                   SizedBox(
//                                     height: 15,
//                                   ),
//                                   //// start avenue
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       //// start select Block
//                                       Expanded(
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Padding(
//                                               padding: const EdgeInsets.symmetric(horizontal: 15),
//                                               child: Text(
//                                                 "${AppLocalizations.of(context)!.translate(AppStrings.AVENUE)}",
//                                                 style: AppFontStyle.blueTextH4,
//                                               ),
//                                             ),
//                                             SizedBox(
//                                               height: 10,
//                                             ),
//                                             CustomTextFiled(
//                                               controller: _avenueTextEditing,
//                                               obscureText: false,
//                                               currentFocus: avenueFocus,
//                                               maxLines: 1,
//                                               onFieldSubmitted: (v) {
//                                                 FocusScope.of(context)
//                                                     .requestFocus(
//                                                         otherInstructionsFocus);
//                                               },
//                                               hintText:
//                                                   '${AppLocalizations.of(context)!.translate(AppStrings.Type_Here)}',
//                                               onChanged: (value) {
//                                                 if (value.isNotEmpty) {
//                                                   _avenue = value;
//                                                 } else {
//                                                   _avenue = '';
//                                                 }
//                                               },
//                                               // keyboardType: TextInputType.emailAddress,
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       //// end select Block
//                                       SizedBox(
//                                         width: 15,
//                                       ),
//                                       //// start select street Number
//                                       Expanded(
//                                         child: Container(),
//                                       )
//                                       //// end select street number
//                                     ],
//                                   ),
//
//                                   //// end avenue
//
//                                   SizedBox(
//                                     height: 25,
//                                   ),
//
//                                   //// start Other Instructions
//                                   Padding(
//                                   padding: const EdgeInsets.symmetric(horizontal: 15),
//                                   child:Text(
//                                     "${AppLocalizations.of(context)!.translate(AppStrings.OTHER_INSTRUCTIONS)}",
//                                     style: AppFontStyle.blueTextH4,
//                                   ),),
//                                   SizedBox(
//                                     height: 10,
//                                   ),
//                                   CustomTextFiled(
//                                     controller: _otherInstructionsTextEditing,
//                                     isTextArea: true,
//                                     obscureText: false,
//                                     currentFocus: otherInstructionsFocus,
//                                     maxLines: 4,
//
//                                     onFieldSubmitted: (v) {},
//                                     hintText:
//                                         '${AppLocalizations.of(context)!.translate(AppStrings.Type_Here)}',
//                                     onChanged: (value) {
//                                       if (value.isNotEmpty) {
//                                         _otherInstructions = value;
//                                       } else {
//                                         _otherInstructions = '';
//                                       }
//                                     },
//                                     // keyboardType: TextInputType.emailAddress,
//                                   ),
//                                   //// end Other Instructions
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       }),
//                 );
//               })),
//     );
//   }
// }
