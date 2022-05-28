import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const double _kTextAndIconTabHeight = 72.0;

class MyTab extends StatelessWidget implements PreferredSizeWidget {
  /// Creates a material design [TabBar] tab.
  ///
  /// At least one of [text], [icon], and [child] must be non-null. The [text]
  /// and [child] arguments must not be used at the same time. The
  /// [iconMargin] is only useful when [icon] and either one of [text] or
  /// [child] is non-null.
  const MyTab({
    Key? key,
    this.text,
    this.icon,
    this.iconMargin = const EdgeInsets.only(bottom: 10.0),
    this.height,
    this.child,
    this.kTabHeight = 46.0,
  })  : assert(text != null || child != null || icon != null),
        assert(text == null || child == null),
        super(key: key);

  final double kTabHeight;

  /// The text to display as the tab's label.
  ///
  /// Must not be used in combination with [child].
  final String? text;

  /// The widget to be used as the tab's label.
  ///
  /// Usually a [Text] widget, possibly wrapped in a [Semantics] widget.
  ///
  /// Must not be used in combination with [text].
  final Widget? child;

  /// An icon to display as the tab's label.
  final Widget? icon;

  /// The margin added around the tab's icon.
  ///
  /// Only useful when used in combination with [icon], and either one of
  /// [text] or [child] is non-null.
  final EdgeInsetsGeometry iconMargin;

  /// The height of the [MyTab].
  ///
  /// If null, the height will be calculated based on the content of the [MyTab].  When `icon` is not
  /// null along with `child` or `text`, the default height is 72.0 pixels. Without an `icon`, the
  /// height is 46.0 pixels.
  final double? height;

  Widget _buildLabelText() {
    return child ??
        Text(
          text!,
          softWrap: false,
          overflow: TextOverflow.fade,
        );
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));

    final double calculatedHeight;
    final Widget label;
    if (icon == null) {
      calculatedHeight = kTabHeight;
      label = _buildLabelText();
    } else if (text == null && child == null) {
      calculatedHeight = kTabHeight;
      label = icon!;
    } else {
      calculatedHeight = _kTextAndIconTabHeight;
      label = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: iconMargin,
            child: icon,
          ),
          _buildLabelText(),
        ],
      );
    }

    return SizedBox(
      height: height ?? calculatedHeight,
      child: Center(
        widthFactor: 1.0,
        child: label,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('text', text, defaultValue: null));
    properties
        .add(DiagnosticsProperty<Widget>('icon', icon, defaultValue: null));
  }

  @override
  Size get preferredSize {
    if (height != null)
      return Size.fromHeight(height!);
    else if ((text != null || child != null) && icon != null)
      return const Size.fromHeight(_kTextAndIconTabHeight);
    else
      return Size.fromHeight(kTabHeight);
  }
}
