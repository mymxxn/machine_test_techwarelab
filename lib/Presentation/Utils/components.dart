import 'package:flutter/material.dart';

class Components {
  static commonTextfield(
          {required String txt,
          required TextEditingController controller,
          required TextInputType inputtype,
          Function(dynamic)? onChanged,
          bool obscureText = false}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            txt,
            style: const TextStyle(color: Colors.black87, fontSize: 15),
          ),
          const SizedBox(
            height: 4,
          ),
          TextField(
            obscureText: obscureText,
            controller: controller,
            keyboardType: inputtype,
            onChanged: onChanged,
            textInputAction: TextInputAction.none,
            decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                isCollapsed: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.black87,
                  ),
                )),
          )
        ],
      );
  static commonDialog(BuildContext context, String title, Widget content,
      {List<Widget>? actions, Function()? ontapOfClose}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          insetPadding: EdgeInsets.all(10),
          actions: actions != null && actions.isNotEmpty ? actions : null,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          title: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      title,
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                    ),
                  ),
                  InkWell(
                    onTap: ontapOfClose == null
                        ? () {
                            Navigator.pop(context);
                          }
                        : ontapOfClose,
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.black87,
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  )
                ],
              ),
              Divider(
                color: Colors.grey,
              ),
            ],
          ),
          content: SizedBox(
              width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height,
              child: content),
        );
      },
    );
  }
}
