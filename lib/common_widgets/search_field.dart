import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SearchField extends StatelessWidget {
  bool? enabled = true;
  Widget widget;
  TextEditingController? controller;
  String? searchText;
  bool isFavoriteTab;
  Widget? suffix;
  Function(String)? onSubmit;
  SearchField({Key? key,required this.widget, this.enabled, this.controller,this.searchText,this.suffix, this.onSubmit, this.isFavoriteTab = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: SizedBox(
            height: size.height * 0.06,
            child: TextField(
              enabled: enabled,
              controller: controller,
              onChanged: onSubmit,
              style: TextStyle(
                fontSize: size.height * 0.025,
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 5),
                suffixIcon:  controller?.text.isNotEmpty == true ? suffix:null,
                labelText: searchText ?? 'Search Employee...',
                labelStyle: TextStyle(
                  fontSize: size.height * 0.02,
                ),
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(7),
                ),
                disabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(7)),
              ),
            ),
          ),
        ),
        SizedBox(
          width: size.width * 0.03,
        ),

        Expanded(
          flex: 1,
          child: Container(
            height: size.height * 0.055,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.blue),
            child: widget,
          ),
        ),
      ],
    );
  }
}
