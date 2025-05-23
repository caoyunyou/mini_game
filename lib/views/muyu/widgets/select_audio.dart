import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:mini_game/views/muyu/models/audio_option.dart';
import 'package:mini_game/l10n/generated/l10n.dart';

class AudioOptionItem extends StatelessWidget {
  final AudioOption option;
  final bool active;

  const AudioOptionItem({
    super.key,
    required this.option,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: ListTile(
        title: Text(
          option.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: !active ? null : Colors.blue,
          ),
        ),
        trailing: IconButton(
          onPressed: () => _tempPlay(option.src),
          icon: const Icon(Icons.record_voice_over_rounded, color: Colors.blue),
        ),
      ),
    );
  }

  // 播放音乐一次：用于试听
  void _tempPlay(String src) async {
    AudioPool pool = await AudioPool.createFromAsset(path: src, maxPlayers: 1);
    await pool.start();
  }
}

class AudioOptionPanel extends StatelessWidget {
  final List<AudioOption> audioOptions;
  final ValueChanged<int> onSelect;
  final int activeIndex;

  const AudioOptionPanel({
    super.key,
    required this.audioOptions,
    required this.activeIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    const TextStyle labelStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );

    return Material(
      child: SizedBox(
        height: 300,
        child: Column(
          children: [
            Container(
              height: 46,
              alignment: Alignment.center,
              child: Text(S.of(context).musicSelect, style: labelStyle),
            ),
            ...List.generate(audioOptions.length, _buildByIndex)
          ],
        ),
      ),
    );
  }

  Widget _buildByIndex(int index) {
    bool active = index == activeIndex;
    return GestureDetector(
      onTap: () => onSelect(index),
      child: AudioOptionItem(option: audioOptions[index], active: active),
    );
  }
}
