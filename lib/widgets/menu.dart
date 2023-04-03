import 'package:flutter/material.dart';

/// 菜单系列组件
class MenuDemo extends StatefulWidget {
  const MenuDemo({super.key});

  @override
  State<MenuDemo> createState() => _MenuDemoState();
}

class _MenuDemoState extends State<MenuDemo> {

  MenuEntry? _lastSelection;
  final FocusNode _buttonFocusNode = FocusNode(debugLabel: 'Menu Button');

  Color get backgroundColor => _backgroundColor;
  Color _backgroundColor = Colors.red;
  set backgroundColor(Color value) {
    if (_backgroundColor != value) {
      setState(() {
        _backgroundColor = value;
      });
    }
  }

  bool get showingMessage => _showingMessage;
  bool _showingMessage = false;
  set showingMessage(bool value) {
    if (_showingMessage != value) {
      setState(() {
        _showingMessage = value;
      });
    }
  }

  @override
  void dispose() {
    _buttonFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        MenuBar(
            style: MenuStyle(
              backgroundColor:
                  MaterialStateColor.resolveWith((states) => Colors.white),
            ),
            children: [
          
              SubmenuButton(
                  menuChildren: _meunList(), child: const Text("菜单1")),
              SubmenuButton(
                  menuChildren: _meunList(), child: const Text("菜单2")),
              SubmenuButton(
                  menuChildren: _meunList(), child: const Text("菜单3")),
              MenuAnchor(
                childFocusNode: _buttonFocusNode,
                menuChildren: _meunList(),
                builder: (BuildContext context, MenuController controller,
                    Widget? child) {
                  return TextButton(
                    focusNode: _buttonFocusNode,
                    onPressed: () {
                      if (controller.isOpen) {
                        controller.close();
                      } else {
                        controller.open();
                      }
                    },
                    child: const Text('OPEN MENU'),
                  );
                },
              ),
            ]),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            color: backgroundColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    showingMessage ? 'menu demo' : '',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                Text(_lastSelection != null
                    ? 'Last Selected: ${_lastSelection!.label}'
                    : ''),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _activate(MenuEntry selection) {
    setState(() {
      _lastSelection = selection;
    });

    switch (selection) {
      case MenuEntry.about:
        showAboutDialog(
          context: context,
          applicationName: 'MenuBar Sample',
          applicationVersion: '1.0.0',
        );
        break;
      case MenuEntry.hideMessage:
      case MenuEntry.showMessage:
        showingMessage = !showingMessage;
        break;
      case MenuEntry.colorMenu:
        break;
      case MenuEntry.colorRed:
        backgroundColor = Colors.red;
        break;
      case MenuEntry.colorGreen:
        backgroundColor = Colors.green;
        break;
      case MenuEntry.colorBlue:
        backgroundColor = Colors.blue;
        break;
    }
  }

  List<Widget> _meunList() {
    return <Widget>[
      MenuItemButton(
        child: Text(MenuEntry.about.label),
        onPressed: () => _activate(MenuEntry.about),
      ),
      if (_showingMessage)
        MenuItemButton(
          onPressed: () => _activate(MenuEntry.hideMessage),
          child: Text(MenuEntry.hideMessage.label),
        ),
      if (!_showingMessage)
        MenuItemButton(
          onPressed: () => _activate(MenuEntry.showMessage),
          child: Text(MenuEntry.showMessage.label),
        ),
      SubmenuButton(
        leadingIcon: const Icon(Icons.ac_unit_sharp),
        menuChildren: <Widget>[
          MenuItemButton(
            onPressed: () => _activate(MenuEntry.colorRed),
            child: Text(MenuEntry.colorRed.label),
          ),
          MenuItemButton(
            onPressed: () => _activate(MenuEntry.colorGreen),
            child: Text(MenuEntry.colorGreen.label),
          ),
          MenuItemButton(
            onPressed: () => _activate(MenuEntry.colorBlue),
            child: Text(MenuEntry.colorBlue.label),
          ),
        ],
        child: const Text('Background Color'),
      ),
    ];
  }

}

enum MenuEntry {
  about('About'),
  showMessage('Show Message'),
  hideMessage('Hide Message'),
  colorMenu('Color Menu'),
  colorRed('Red Background'),
  colorGreen('Green Background'),
  colorBlue('Blue Background');

  final String label;
  const MenuEntry(this.label);
}