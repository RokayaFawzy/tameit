import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tame_it/values/values.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';
import '../../../utils/spacer.dart';


// Meeting ActionBar
class MeetingActionBar extends StatelessWidget {
  // control states
  final bool isMicEnabled, isCamEnabled, isScreenShareEnabled;
  final String recordingState;

  // callback functions
  final void Function() onCallEndButtonPressed,
      onCallLeaveButtonPressed,
      onMicButtonPressed,
      onCameraButtonPressed,
      onChatButtonPressed;

  final void Function(String) onMoreOptionSelected;

  final void Function(TapDownDetails) onSwitchMicButtonPressed;
  const MeetingActionBar({
    Key? key,
    required this.isMicEnabled,
    required this.isCamEnabled,
    required this.isScreenShareEnabled,
    required this.recordingState,
    required this.onCallEndButtonPressed,
    required this.onCallLeaveButtonPressed,
    required this.onMicButtonPressed,
    required this.onSwitchMicButtonPressed,
    required this.onCameraButtonPressed,
    required this.onMoreOptionSelected,
    required this.onChatButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          PopupMenuButton(
              position: PopupMenuPosition.under,
              padding: const EdgeInsets.all(0),
              color: AppColors.black700,
              icon: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.redShade5),
                  color: AppColors.redShade5,
                ),
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.call_end,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              offset: const Offset(0, -185),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onSelected: (value) => {
                    if (value == "leave")
                      onCallLeaveButtonPressed()
                    else if (value == "end")
                      onCallEndButtonPressed()
                  },
              itemBuilder: (context) => <PopupMenuEntry>[
                    _buildMeetingPoupItem(
                      "leave",
                      "Leave",
                      "Only you will leave the call",
                      SvgPicture.asset("assets/images/ic_leave.svg"),
                    ),
                    const PopupMenuDivider(),
                    _buildMeetingPoupItem(
                      "end",
                      "End",
                      "End call for all participants",
                      SvgPicture.asset("assets/images/ic_end.svg"),
                    ),
                  ]),

          // Mic Control
          TouchRippleEffect(
            borderRadius: BorderRadius.circular(12),
            rippleColor: isMicEnabled ? AppColors.black1 : Colors.white,
            onTap: onMicButtonPressed,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.black2),
                color: isMicEnabled ? AppColors.black1 : Colors.white,
              ),
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Icon(
                    isMicEnabled ? Icons.mic : Icons.mic_off,
                    size: 30,
                    color: isMicEnabled ? Colors.white : AppColors.black1,
                  ),
                  GestureDetector(
                      onTapDown: (details) =>
                          {onSwitchMicButtonPressed(details)},
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Icon(
                          Icons.arrow_drop_down,
                          color: isMicEnabled ? Colors.white : AppColors.black1,
                        ),
                      )),
                ],
              ),
            ),
          ),

          // Camera Control
          TouchRippleEffect(
            borderRadius: BorderRadius.circular(12),
            rippleColor: AppColors.black1,
            onTap: onCameraButtonPressed,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.black2),
                color: isCamEnabled ? AppColors.black1 : Colors.white,
              ),
              padding: const EdgeInsets.all(10),
              child: SvgPicture.asset(
                isCamEnabled
                    ? "assets/images/ic_video.svg"
                    : "assets/images/ic_video_off.svg",
                width: 26,
                height: 26,
                color: isCamEnabled ? Colors.white : AppColors.black1,
              ),
            ),
          ),

          TouchRippleEffect(
            borderRadius: BorderRadius.circular(12),
            rippleColor: AppColors.black1,
            onTap: onChatButtonPressed,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.black2),
                color: AppColors.black1,
              ),
              padding: const EdgeInsets.all(10),
              child: SvgPicture.asset(
                "assets/images/ic_chat.svg",
                width: 26,
                height: 26,
                color: Colors.white,
              ),
            ),
          ),

          // More options
          PopupMenuButton(
              position: PopupMenuPosition.under,
              padding: const EdgeInsets.all(0),
              color: AppColors.black700,
              icon: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.black2),
                  // color: red,
                ),
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.more_vert,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              offset: const Offset(0, -250),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onSelected: (value) => {onMoreOptionSelected(value.toString())},
              itemBuilder: (context) => <PopupMenuEntry>[
                    _buildMeetingPoupItem(
                      "recording",
                      recordingState == "RECORDING_STARTED"
                          ? "Stop Recording"
                          : recordingState == "RECORDING_STARTING"
                              ? "Recording is starting"
                              : "Start Recording",
                      null,
                      SvgPicture.asset("assets/images/ic_recording.svg"),
                    ),
                    const PopupMenuDivider(),
                    _buildMeetingPoupItem(
                      "screenshare",
                      isScreenShareEnabled
                          ? "Stop Screen Share"
                          : "Start Screen Share",
                      null,
                      SvgPicture.asset("assets/images/ic_screen_share.svg"),
                    ),
                    const PopupMenuDivider(),
                    _buildMeetingPoupItem(
                      "participants",
                      "Participants",
                      null,
                      SvgPicture.asset("assets/images/ic_participants.svg"),
                    ),
                  ]),
        ],
      ),
    );
  }

  PopupMenuItem<dynamic> _buildMeetingPoupItem(
      String value, String title, String? description, Widget leadingIcon) {
    return PopupMenuItem(
      value: value,
      padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
      child: Row(children: [
        leadingIcon,
        const HorizontalSpacer(12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            if (description != null) const VerticalSpacer(4),
            if (description != null)
              Text(
                description,
                style: const TextStyle(
                    fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.black400),
              )
          ],
        )
      ]),
    );
  }
}
