import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

PublishSubject<bool> _switchSubject = PublishSubject();
Stream<bool> get switch$ => _switchSubject.stream;
Sink<bool> get inSwitch => _switchSubject.sink;
late AnimationController controller;

class ForgetPasswordCountDownTimer extends StatefulWidget {
  final VoidCallback onResendClicked;

  const ForgetPasswordCountDownTimer({Key? key, required this.onResendClicked})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ForgetPasswordCountDownTimerState();
  }
}

class _ForgetPasswordCountDownTimerState
    extends State<ForgetPasswordCountDownTimer>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(minutes: 3));
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Countdown(
          animation: StepTween(
            begin: 3 * 60,
            end: 0,
          ).animate(controller),
        ),
      ),
    );
    // return StreamBuilder<bool>(
    //     initialData: false,
    //     stream: switch$,
    //     builder: (context, switchSnapshot) {
    //       return switchSnapshot.data!
    //           ? FadeIn(
    //               child: Center(
    //                 child: RaisedButton(
    //                     color: Colors.blue[800],
    //                     shape: RoundedRectangleBorder(
    //                       borderRadius: BorderRadius.all(
    //                         Radius.circular(10.0),
    //                       ),
    //                     ),
    //                     child: Text(
    //                       'Resend Code',
    //                       // '${context.translate('Resend_str')}',
    //                       style: TextStyle(
    //                         color: Colors.white,
    //                       ),
    //                     ),
    //                     onPressed: () {
    //                       controller.reset();
    //                       controller.forward();
    //                       widget.onResendClicked();
    //                       inSwitch.add(false);
    //                     }),
    //               ),
    //             )
    //           : Container(
    //               child: Center(
    //                 child: Countdown(
    //                   animation: StepTween(
    //                     begin: 3 * 60,
    //                     end: 0,
    //                   ).animate(controller),
    //                 ),
    //               ),
    //             );
    //     });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class Countdown extends AnimatedWidget {
  final Animation<int> animation;

  Countdown({
    Key? key,
    required this.animation,
  }) : super(key: key, listenable: animation);

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);
    onDone();

    String timerText =
        // '${clockTimer.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(clockTimer.inSeconds.remainder(60) % 60).toString().padLeft(2, '0')}';
        '${clockTimer.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(clockTimer.inSeconds.remainder(60) % 60).toString().padLeft(2, '0')}';

    return Text(
      // "${context.translate('ResendIn_str')} $timerText",
      // "Resend In ($timerText)",
      "($timerText)",
      style: TextStyle(
        fontSize: 14,

        // color: Colors.black,
      ),
    );
  }

  onDone() {
    Duration timeLeft = Duration(seconds: animation.value);

    if (timeLeft.inSeconds == 0) {
      inSwitch.add(true);
      // Future.delayed(Duration(milliseconds: 1000), () {
      //   // if (widget.onDone != null) widget.onDone();
      //   print('xXx Time is End');

      // });
    }
  }
}
