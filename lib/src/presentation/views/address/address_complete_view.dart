import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/data/address.dart';
import '../../../utils/constants/colors.dart';
import '../../cubits/geo_address/geo_address_cubit.dart';
import '../../cubits/geo_address/geo_address_state.dart';
import '../../widgets/common_widgets.dart';

class AddressCompleteView extends StatefulWidget {
  final int? categoryID;
  final String? policeStationID;

  AddressCompleteView(
      {Key? key, required this.categoryID, required this.policeStationID})
      : super(key: key);

  @override
  @override
  State<AddressCompleteView> createState() =>
      _AddressCompleteViewState(categoryID,policeStationID);
}

class _AddressCompleteViewState extends State<AddressCompleteView> {
  TextEditingController mobileController = TextEditingController();
  List<Address>? list = [];
  List<Address>? listAddress = [];

  late var cubit = context.read<GetGeoAddressCubit>();
  final TextEditingController searchController = TextEditingController();

  final int? categoryID;
  final String? policeStationID;

  _AddressCompleteViewState(this.categoryID,this.policeStationID);

  @override
  void initState() {
    super.initState();
    cubit.getCompleteGeoAddress(categoryID, 1,int.parse(policeStationID!));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Scaffold(
        body: Flex(
          direction: Axis.vertical,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.90,
              padding: const EdgeInsets.only(top: 10.0),
              // Use a Material design search bar
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  // page = 1;
                  searchController.value = TextEditingValue(
                      text: value,
                      selection: TextSelection(
                          baseOffset: value.length,
                          extentOffset: value.length));

                  setState(() {
                    if (value.isNotEmpty) {
                      list = listAddress
                          ?.where((element) => element.locationName!
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                    } else {
                      list = listAddress;
                    }
                  });
                },
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: skyBlue, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: skyBlue,
                      width: 2.0,
                    ),
                  ),
                  filled: true,
                  //<-- SEE HERE
                  fillColor: skyBlue,
                  hintText: 'Search...',
                  iconColor: Colors.white,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      searchController.value = const TextEditingValue(
                          selection:
                              TextSelection(baseOffset: 0, extentOffset: 0));
                      setState(() {
                        list = listAddress;
                      });
                    },
                  ),
                  // Add a search icon or button to the search bar
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      // Perform the search here
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
            Flexible(
              child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: BlocConsumer<GetGeoAddressCubit, GeoAddressState>(
                      listener: (context, state) {
                    if (state is GeoAddressCompleteSuccessState) {
                      setState(() {
                        var response = state.response?.data;
                        list = response?.addressList;
                        listAddress = response?.addressList;
                      });
                    } else if (state is GeoAddressErrorState) {
                      snackBar(context, "${state.error?.message}");
                    }
                  }, builder: (context, state) {
                    if (state is GeoAddressLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is GeoAddressCompleteSuccessState) {
                      return (list?.length != null)
                          ? Container(
                              child: ListView.builder(
                              itemCount: list?.length,
                              itemBuilder: (context, index) {
                                Address? address = list?[index];
                                return widgetsAddress(
                                  onClick: (p0) {},
                                  address,
                                );
                              },
                            ))
                          : Container(
                              child: const Center(
                                child: Text("No data available !"),
                              ),
                            );
                    } else {
                      return Container();
                    }
                  })),
            )
          ],
        ),
      ),
    );
  }
}
