import 'package:flutter/material.dart';

class CheckBoxWidgetDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CheckBoxState();
  }
}

class _CheckBoxState extends State<CheckBoxWidgetDemo> {
  bool _switchSelected = false; //维护单选开关状态
  bool _checkboxSelected = true; //维护复选框状态
  var groupValue = 0;

  var _dataList = [];

  var radioText = "";
  var _checkText = [];

  @override
  void initState() {
    super.initState();
    _dataList.add(FMRadioBean(1, "选项1", false));
    _dataList.add(FMRadioBean(2, "选项2", false));
    _dataList.add(FMRadioBean(3, "选项3", false));
    _dataList.add(FMRadioBean(4, "选项4", false));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Switch(
                  activeColor: Colors.blue,
                  value: _switchSelected,
                  onChanged: (value) {
                    setState(() {
                      _switchSelected = value;
                    });
                  }),
              Text(_switchSelected ? "Switch 开" : "Switch 关")
            ],
          ),
          Row(
            children: [
              Checkbox(
                  value: _checkboxSelected,
                  activeColor: Colors.blue,
                  onChanged: (value) {
                    setState(() {
                      _checkboxSelected = value ?? false;
                    });
                  }),
              Text(_checkboxSelected ? "Checkbox 选中" : "Checkbox 未选中")
            ],
          ),
          Column(
            children: [
              _radioCheckBox(_dataList[0]),
              _radioCheckBox(_dataList[1]),
              _radioCheckBox(_dataList[2]),
              _radioCheckBox(_dataList[3])
            ],
          ),
          Text(radioText),
          Column(
            children: [
              _checkCheckBox(_dataList[0]),
              _checkCheckBox(_dataList[1]),
              _checkCheckBox(_dataList[2]),
              _checkCheckBox(_dataList[3])
            ],
          ),
          Text(_checkText.toString())
        ],
      ),
    );
  }

  Row _radioCheckBox(FMRadioBean fmRadioBean) {
    return Row(
      children: [
        Radio(
            visualDensity: VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity),
            value: fmRadioBean.index,
            activeColor: Colors.red,
            groupValue: groupValue,
            onChanged: (value) {
              setState(() {
                groupValue = fmRadioBean.index;
                radioText = fmRadioBean.text;
              });
            }),
        Text(fmRadioBean.text)
      ],
    );
  }

  Row _checkCheckBox(FMRadioBean fmRadioBean) {
    return Row(
      children: [
        Checkbox(
            visualDensity: VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity),
            value: fmRadioBean.isSelect,
            activeColor: Colors.blue,
            onChanged: (value) {
              setState(() {
                if (value == true) {
                  fmRadioBean.isSelect = true;
                  _checkText.add(fmRadioBean.text);
                } else {
                  fmRadioBean.isSelect = false;
                  _checkText.remove(fmRadioBean.text);
                }
              });
            }),
        Text(fmRadioBean.text)
      ],
    );
  }
}

class FMRadioBean {
  int index;
  String text;
  bool isSelect;

  FMRadioBean(this.index, this.text, this.isSelect);
}

/// Radio 属性
/// value	@required 此单选按钮表示的值
/// groupValue	@required 选中
/// onChanged	@required 点击事件
/// mouseCursor	鼠标光标
/// activeColor	选中时填充颜色
/// focusColor	聚焦颜色
/// hoverColor	悬停颜色
/// materialTapTargetSize	内边距，默认最小点击区域为 48 * 48，MaterialTapTargetSize.shrinkWrap 为组件实际大小
/// visualDensity	布局紧凑设置
/// focusNode	焦点控制，Flutter 组件之 FocusNode 详解
/// autofocus	自动聚焦，默认为 false
