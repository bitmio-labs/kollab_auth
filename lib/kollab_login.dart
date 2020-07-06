import 'package:flutter/material.dart';
import 'kollab_header.dart';

class HeaderDetailWidget extends StatelessWidget {
  final Widget detail;
  final Image logo;
  final Image background;
  final double headerHeight;
  final double logoHeight;

  HeaderDetailWidget(
      {this.detail,
      this.background,
      this.logo,
      this.headerHeight = 300,
      this.logoHeight = 110});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              if (background != null)
                Header(
                  height: headerHeight,
                  logoHeight: logoHeight,
                  background: background,
                  logo: logo,
                ),
              detail
            ],
          ),
        ),
      ),
    );
  }
}
