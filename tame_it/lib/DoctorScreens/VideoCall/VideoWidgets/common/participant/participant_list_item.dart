import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tame_it/values/values.dart';
import 'package:videosdk/videosdk.dart';

class ParticipantListItem extends StatefulWidget {
  final Participant participant;
  const ParticipantListItem({Key? key, required this.participant})
      : super(key: key);

  @override
  State<ParticipantListItem> createState() => _ParticipantListItemState();
}

class _ParticipantListItemState extends State<ParticipantListItem> {
  Stream? videoStream;
  Stream? audioStream;

  @override
  void initState() {
    widget.participant.streams.forEach((key, Stream stream) {
      if (stream.kind == "video") {
        videoStream = stream;
      } else if (stream.kind == 'audio') {
        audioStream = stream;
      }
      log("Stream: " + stream.kind.toString());
    });

    super.initState();
    addParticipantListener(widget.participant);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
      decoration: BoxDecoration(
          color: AppColors.black600, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.black500,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: AppColors.black500),
            ),
            child: const Icon(Icons.person),
          ),
          Expanded(
              child: Text(
            widget.participant.isLocal ? "You" : widget.participant.displayName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          )),
          Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: audioStream != null ? AppColors.black600 : AppColors.redShade5,
              border: Border.all(color: audioStream != null ? AppColors.black500 : AppColors.redShade5),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(audioStream != null ? Icons.mic : Icons.mic_off),
          ),
          Container(
            // margin: EdgeInsets.only(right: 10),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: videoStream != null ? AppColors.black600 : AppColors.redShade5,
              border: Border.all(color: videoStream != null ? AppColors.black500 : AppColors.redShade5),
              borderRadius: BorderRadius.circular(30),
            ),
            child: SvgPicture.asset(videoStream != null
                ? "assets/images/ic_video.svg"
                : "assets/images/ic_video_off.svg"),
          ),
        ],
      ),
    );
  }

  void addParticipantListener(Participant participant) {
    participant.on(Events.streamEnabled, (Stream _stream) {
      if (mounted) {
        setState(() {
          if (_stream.kind == "video") {
            videoStream = _stream;
          } else if (_stream.kind == 'audio') {
            audioStream = _stream;
          }
        });
      }
    });

    participant.on(Events.streamDisabled, (Stream _stream) {
      if (mounted) {
        setState(() {
          if (_stream.kind == "video") {
            videoStream = null;
          } else if (_stream.kind == 'audio') {
            audioStream = null;
          }
        });
      }
    });
  }
}
