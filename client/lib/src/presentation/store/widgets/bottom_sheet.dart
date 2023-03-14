import 'package:coffee/src/controls/extension/string_extension.dart';
import 'package:coffee/src/data/data_app.dart';
import 'package:flutter/material.dart';

import '../../../data/models/store.dart';
import '../../login/widgets/custom_button.dart';

final store = Store(
  image:
      "https://www.highlandscoffee.com.vn/vnt_upload/news/02_2020/83739091_2845644318849727_1748210367038750720_o_1.png",
  name: "Sala 2",
  address: "Quận 2 - Hồ Chí Minh",
  phone: "0334168888",
  startDay: const TimeOfDay(hour: 7, minute: 0),
  endDay: const TimeOfDay(hour: 22, minute: 0),
);

void showStoreBottomSheet(BuildContext context) {
  showModalBottomSheet(
    isScrollControlled: true,
    useSafeArea: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    context: context,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(store.image),
                    const SizedBox(height: 20),
                    Text(
                      store.name,
                      style: const TextStyle(
                        color: Color(0xff4F2C1F),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(store.address),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          const Icon(Icons.call),
                          const SizedBox(width: 5),
                          Text(store.phone),
                        ],
                      ),
                    ),
                    const Divider(),
                    const SizedBox(height: 10),
                    Text(
                      "hour".translate(context),
                      style: const TextStyle(
                        color: Color(0xff4F2C1F),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shrinkWrap: true,
                      itemCount: dayInWeek.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            if (index != 0)
                              const Divider(indent: 15, endIndent: 15),
                            Row(
                              children: [
                                Text(
                                  dayInWeek[index],
                                  style: const TextStyle(
                                    color: Color(0xff4F2C1F),
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  store.rangeTime(),
                                  style: const TextStyle(
                                    color: Color(0xff4F2C1F),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: customButton(
                text: "order_here".translate(context).toUpperCase(),
                isOnPress: true,
                onPress: () {},
              ),
            ),
          ],
        ),
      );
    },
  );
}
