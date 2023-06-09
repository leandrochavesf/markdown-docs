import 'package:flutter/material.dart';
import 'package:markdown_docs/widgets/widgets.dart';
import 'package:markdown_widget/markdown_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.useLightMode,
    required this.handleBrightnessChange,
  });

  final bool useLightMode;
  final void Function(bool useLightMode) handleBrightnessChange;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String? docsContentPath = 'assets/home_content.md';
  String? data;

  final TocController tocController = TocController();

  @override
  void initState() {
    loadData();
    super.initState();
  }

  Widget buildTocWidget() => TocWidget(controller: tocController);

  // TODO: create a widget for toc list
  // Widget buildTocListWidget({double? fontSize}) {
  //   return Container(
  //     width: v300,
  //     padding: EdgeInsets.only(top: v140, left: v20),
  //     child: TocWidget(
  //       controller: controller,
  //       itemBuilder: (data) {
  //         return TocItemWidget(
  //           isCurrent: data.index == data.currentIndex,
  //           toc: data.toc,
  //           fontSize: fontSize ?? v12,
  //           onTap: () {
  //             data.refreshIndexCallback.call(data.toc.widgetIndex);
  //             controller.jumpToIndex(data.toc.widgetIndex);
  //           },
  //         );
  //       },
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        useLightMode: widget.useLightMode,
        handleBrightnessChange: widget.handleBrightnessChange,
      ),
      body: data == null
          ? const Center(child: CircularProgressIndicator())
          : Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Expanded(child: buildTocWidget()),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    child: BuildMarkdownWidget(
                        data: data!, tocController: tocController),
                  ),
                ),
              ],
            ),
    );
  }

  void loadData() {
    DefaultAssetBundle.of(context).loadString(docsContentPath!).then((data) {
      this.data = data;
      refresh();
    });
  }

  void refresh() {
    if (mounted) setState(() {});
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
    required this.widget,
  });

  final HomePage widget;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(50.0),
      child: Container(
        height: 70.0,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        decoration: const BoxDecoration(
          color: Colors.black87,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: const [
                Text(
                  'Company',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                Text(
                  ' Developers',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            BrightnessButton(
              handleBrightnessChange: widget.handleBrightnessChange,
            ),
          ],
        ),
      ),
    );
  }
}
