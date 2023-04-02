import 'package:flutter/material.dart';
// import 'package:html/dom.dart' as dom;
// import 'package:http/http.dart' as http;

class PolicyPage extends StatefulWidget {
  const PolicyPage({Key? key}) : super(key: key);

  @override
  State<PolicyPage> createState() => _PolicyPageState();
}

class _PolicyPageState extends State<PolicyPage> {
  String? content;

  @override
  void initState() {
    // getContent();
    super.initState();
  }

  // Future getContent() async {
  //   WebScraper webScraper = WebScraper('https://www.highlandscoffee.com.vn');
  //   if (await webScraper.loadWebPage(
  //       '/vn/dieu-khoan-va-dieu-kien-ap-dung-cua-ung-dung-highlands-coffee.html')) {
  //     setState(() {
  //       content = webScraper
  //           .getElement('div#vnt-main > div.the-content', ['href'])[0]["title"];
  //       print(
  //           webScraper.getElement('div#vnt-main > div.the-content', ['href'])[0]
  //               ["title"]);
  //     });
  //   }
  // }

  // Future getContent() async {
  //   final url = Uri.parse(
  //       "https://www.highlandscoffee.com.vn/vn/dieu-khoan-va-dieu-kien-ap-dung-cua-ung-dung-highlands-coffee.html");
  //   final response = await http.get(url);
  //   dom.Document document = dom.Document.html(response.body);
  //   setState(() {
  //     content = document
  //         .querySelectorAll('div#vnt-main > div.the-content')
  //         .map((element) => element.innerHtml.trim())
  //         .toList()[0];
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: content == null
          ? Container()
          : SingleChildScrollView(child: Text(content!)),
    );
  }
}
