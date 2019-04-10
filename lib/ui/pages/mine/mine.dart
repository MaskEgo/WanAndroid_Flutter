import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/events/change_theme_color_event.dart';
import 'package:wanandroid_flutter/utils/EventBusUtils.dart';
import 'package:wanandroid_flutter/utils/sp_util.dart';
import 'package:wanandroid_flutter/utils/theme_util.dart';
import 'package:wanandroid_flutter/utils/view_utils.dart';

class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MineState();
}

class _MineState extends State<MinePage> {


  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        body: _buildItem(),
        headerSliverBuilder: (context, isScrol) {
          return [ViewUtils.creatExpendAppBar()];
        });
  }

  _buildItem() {
    return ListView(
      children: <Widget>[
        new ExpansionTile(
          title: new Row(
            children: <Widget>[
              Icon(
                Icons.color_lens,
                color: Colors.grey,
              ),
              Padding(
                padding: EdgeInsets.only(left: 30.0),
                child: Text('主题'),
              )
            ],
          ),
          children: <Widget>[
             Wrap(
              children: ThemeUtil.supportColors.keys.map((String key) {
                Color color = ThemeUtil.supportColors[key];
                return  InkWell(
                  onTap: () {
                    SpUtil.setColorTheme(key);
                    EventBusUtils.eventBus.fire( ChangeThemeColorEvent(color: color));
                  },
                  child:  Container(
                    margin: EdgeInsets.all(5.0),
                    width: 36.0,
                    height: 36.0,
                    color: color,
                  ),
                );
              }).toList(),
            )
          ],
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('设置'),
          trailing: Icon(Icons.arrow_forward_ios,size: 18,),
        ),
        ListTile(
          leading: Icon(Icons.sms),
          title: Text('关于'),
          trailing: Icon(Icons.arrow_forward_ios,size: 18,),
        ),
        ListTile(
          leading: Icon(Icons.assignment_ind),
          title: Text('登入'),
          trailing: Icon(Icons.arrow_forward_ios,size: 18,),
        ),
      ],
    );
  }
}
