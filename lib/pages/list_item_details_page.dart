import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../providers/list_provider.dart';
import '../util/list_item_type.dart';
import '../widgets/counter_list_item.dart';
import '../widgets/detail_list_item.dart';

// ignore: must_be_immutable
class ListItemDetailsPage extends StatefulWidget {
  CounterListItem item;
  ListItemDetailsPage({super.key, required this.item});

  @override
  State<ListItemDetailsPage> createState() => _ListItemDetailsPageState();
}

class _ListItemDetailsPageState extends State<ListItemDetailsPage> {
  Widget _counterBuild(
      BuildContext context, ListProvider listProvider, CounterListItem item) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(item.title),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text(
                item.count.toString(),
                style: const TextStyle(fontSize: 128),
              ),
              Center(
                child: Column(children: [
                  CupertinoButton(
                    onPressed: () {
                      listProvider.increment(item);
                    },
                    child: const Icon(
                      CupertinoIcons.chevron_up,
                      size: 128,
                    ),
                  ),
                  CupertinoButton(
                    onPressed: () {
                      listProvider.decrement(item);
                    },
                    child: const Icon(
                      CupertinoIcons.chevron_down,
                      size: 128,
                    ),
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _listCounterBuild(
      BuildContext context, ListProvider listProvider, CounterListItem item) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(item.title),
        trailing: CupertinoButton(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 6.0),
          onPressed: () {
            listProvider.toggleEditing();
          },
          child: (listProvider.isEditing)
              ? const Text('Done',
                  style: TextStyle(fontWeight: FontWeight.bold))
              : const Icon(CupertinoIcons.create),
        ),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text(
                item.items.length.toString(),
                style: const TextStyle(fontSize: 128),
              ),
              Expanded(
                child: SizedBox(
                  height: 200.0,
                  child: ListView.builder(
                    itemCount: item.items.length,
                    itemBuilder: (context, int index) {
                      return DetailListItem(text: item.items[index]);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ListProvider listProvider = Provider.of<ListProvider>(context);
    return (widget.item.type == ListItemType.countOnly)
        ? _counterBuild(context, listProvider, widget.item)
        : _listCounterBuild(context, listProvider, widget.item);
  }
}
