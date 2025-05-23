import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mini_game/views/muyu/models/merit_record.dart';
import 'package:mini_game/l10n/generated/l10n.dart';

DateFormat format = DateFormat("yyyy-MM-dd HH:mm:ss");

class RecordHistory extends StatelessWidget {
  final List<MeritRecord> records;

  const RecordHistory({super.key, required this.records});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: _buildAppBar(context),
      body: ListView.builder(
        itemBuilder: _builderItem,
        itemCount: records.length,
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) => AppBar(
    title: Text(
      S.of(context).meritRecord,
      style: TextStyle(color: Colors.black, fontSize: 16),
    ),
    backgroundColor: Colors.white,
  );

  Widget? _builderItem(BuildContext context, int index) {
    MeritRecord merit = records[index];
    String date = format.format(
      DateTime.fromMillisecondsSinceEpoch(merit.timestamp),
    );
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue,
        backgroundImage: AssetImage(merit.muyuImage),
      ),
      title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(merit.muyuName,),
            Text('${S.of(context).merit} +${merit.value}',style: TextStyle(color: merit.meritType.color),),
          ],
      ),
      subtitle: Text(merit.audio),
      trailing: Text(
        date,
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      ),
    );
  }
}
