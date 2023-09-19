import 'dart:async';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import '../constants/lottie_path.dart';

class ShillingScaffold extends ConsumerStatefulWidget {
  final Stream<bool>? loadingStream;
  final Color? appBarColor;
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;
  final String? appBarTitle;
  final bool hasBackButton;
  final List<Widget>? trailing;
  final Widget? leading;
  final Widget? body;
  final AppBar? appBar;
  final CrossAxisAlignment crossAxisAlignment;

  const ShillingScaffold({
    this.loadingStream,
    this.appBarColor,
    this.backgroundColor,
    this.bottomNavigationBar,
    this.hasBackButton = true,
    this.appBarTitle,
    this.trailing,
    this.leading,
    this.body,
    this.appBar,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ShillingScaffold> createState() => _ShillingScaffoldState();
}

class _ShillingScaffoldState extends ConsumerState<ShillingScaffold> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.loadingStream,
        builder: (context, AsyncSnapshot<bool> snapshot)  {
          return GestureDetector(
            onTap: (){
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: WillPopScope(
              onWillPop: () async => false,
              child: BlurryModalProgressHUD(
                inAsyncCall: snapshot.data ?? false,
                opacity: 0.8,
                color: Colors.black,
                blurEffectIntensity: 2,
                progressIndicator: Lottie.asset(
                    LottiePath.loader,
                    repeat: true,
                    animate: true,
                    width: 200,
                    height: 200
                ),
                child: Scaffold(
                  backgroundColor: widget.backgroundColor,
                  appBar: widget.appBar ??
                      AppBar(
                        title: widget.appBarTitle != null
                            ? Text(
                          widget.appBarTitle!,
                          // style: Theme.of(context).brightness == Brightness.dark
                          //     ? AppTextStyles.white(18, weight: FontWeight.w700)
                          //     : AppTextStyles.black(18, weight: FontWeight.w700),
                        )
                            : null,
                        actions: widget.trailing,
                        centerTitle: true,
                        leading: widget.leading != null ? widget.leading : widget.hasBackButton
                            ? InkWell(
                          onTap: () {
                            // AppNavigator.goBack(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                          ),
                        )
                            : SizedBox(),
                      ),
                  body: widget.body,
                  bottomNavigationBar: widget.bottomNavigationBar,
                ),
              ),
            ),
          );
        }
    );
  }
}
