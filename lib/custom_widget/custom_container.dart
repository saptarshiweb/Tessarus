import 'package:flutter/material.dart';
import 'package:tessarus_volunteer/custom_widget/custom_modal_routes.dart';

Widget volunteerDisplay(BuildContext context, String name, String email,
    String phone, String access, String id) {
  String vol(String access) {
    if (access == '4') {
      return 'Super Admin';
    } else if (access == '3') {
      return 'Admin';
    } else if (access == '2') {
      return 'Cashier';
    }
    return 'Volunteer';
  }

  return Padding(
    padding: const EdgeInsets.only(top: 3, bottom: 3),
    child: ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          shadowColor: Colors.grey.shade900,
          surfaceTintColor: Colors.grey,
          backgroundColor: Colors.grey.shade100),
      child: Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 12, left: 2, right: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  phone,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  email,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  vol(access),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange),
                    onPressed: () {},
                    child: const Text('Edit')),
                const SizedBox(width: 8),
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {
                      showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (BuildContext context) {
                            return confirm(id,context);
                          });
                    },
                    child: const Text('Delete')),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
