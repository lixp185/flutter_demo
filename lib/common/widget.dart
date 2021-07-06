

class WidgetInfo {


  // todo ThemeData({
  //   Brightness brightness, // 应用整体主题的亮度。用于按钮之类的小部件，以确定在不使用主色或强调色时选择什么颜色。
  //   MaterialColor primarySwatch,// 定义一个单一的颜色以及十个色度的色块。
  //   Color primaryColor, // 应用程序主要部分的背景颜色(toolbars、tab bars 等)
  //   Brightness primaryColorBrightness, // primaryColor的亮度。用于确定文本的颜色和放置在主颜色之上的图标(例如工具栏文本)。
  //   Color primaryColorLight, // primaryColor的浅色版
  //   Color primaryColorDark, // primaryColor的深色版
  //   Color accentColor, // 小部件的前景色(旋钮、文本、覆盖边缘效果等)。
  //   Brightness accentColorBrightness, // accentColor的亮度。
  //   Color canvasColor, //  MaterialType.canvas 的默认颜色
  //   Color scaffoldBackgroundColor, // Scaffold的默认颜色。典型Material应用程序或应用程序内页面的背景颜色。
  //   Color bottomAppBarColor, // BottomAppBar的默认颜色
  //   Color cardColor, // Card的颜色
  //   Color dividerColor, // Divider和PopupMenuDivider的颜色，也用于ListTile之间、DataTable的行之间等。
  //   Color highlightColor, // 选中在泼墨动画期间使用的突出显示颜色，或用于指示菜单中的项。
  //   Color splashColor,  // 墨水飞溅的颜色。InkWell
  //   InteractiveInkFeatureFactory splashFactory, // 定义由InkWell和InkResponse反应产生的墨溅的外观。
  //   Color selectedRowColor, // 用于突出显示选定行的颜色。
  //   Color unselectedWidgetColor, // 用于处于非活动(但已启用)状态的小部件的颜色。例如，未选中的复选框。通常与accentColor形成对比。也看到disabledColor。
  //   Color disabledColor, // 禁用状态下部件的颜色，无论其当前状态如何。例如，一个禁用的复选框(可以选中或未选中)。
  //   Color buttonColor, // RaisedButton按钮中使用的Material 的默认填充颜色。
  //   ButtonThemeData buttonTheme, // 定义按钮部件的默认配置，如RaisedButton和FlatButton。
  //   Color secondaryHeaderColor, // 选定行时PaginatedDataTable标题的颜色。
  //   Color textSelectionColor, // 文本框中文本选择的颜色，如TextField
  //   Color cursorColor, // 文本框中光标的颜色，如TextField
  //   Color textSelectionHandleColor,  // 用于调整当前选定的文本部分的句柄的颜色。
  //   Color backgroundColor, // 与主色形成对比的颜色，例如用作进度条的剩余部分。
  //   Color dialogBackgroundColor, // Dialog 元素的背景颜色
  //   Color indicatorColor, // 选项卡中选定的选项卡指示器的颜色。
  //   Color hintColor, // 用于提示文本或占位符文本的颜色，例如在TextField中。
  //   Color errorColor, // 用于输入验证错误的颜色，例如在TextField中
  //   Color toggleableActiveColor, // 用于突出显示Switch、Radio和Checkbox等可切换小部件的活动状态的颜色。
  //   String fontFamily, // 文本字体
  //   TextTheme textTheme, // 文本的颜色与卡片和画布的颜色形成对比。
  //   TextTheme primaryTextTheme, // 与primaryColor形成对比的文本主题
  //   TextTheme accentTextTheme, // 与accentColor形成对比的文本主题。
  //   InputDecorationTheme inputDecorationTheme, // 基于这个主题的 InputDecorator、TextField和TextFormField的默认InputDecoration值。
  //   IconThemeData iconTheme, // 与卡片和画布颜色形成对比的图标主题
  //   IconThemeData primaryIconTheme, // 与primaryColor形成对比的图标主题
  //   IconThemeData accentIconTheme, // 与accentColor形成对比的图标主题。
  //   SliderThemeData sliderTheme,  // 用于呈现Slider的颜色和形状
  //   TabBarTheme tabBarTheme, // 用于自定义选项卡栏指示器的大小、形状和颜色的主题。
  //   CardTheme cardTheme, // Card的颜色和样式
  //   ChipThemeData chipTheme, // Chip的颜色和样式
  //   TargetPlatform platform,
  //   MaterialTapTargetSize materialTapTargetSize, // 配置某些Material部件的命中测试大小
  //   PageTransitionsTheme pageTransitionsTheme,
  //   AppBarTheme appBarTheme, // 用于自定义Appbar的颜色、高度、亮度、iconTheme和textTheme的主题。
  //   BottomAppBarTheme bottomAppBarTheme, // 自定义BottomAppBar的形状、高度和颜色的主题。
  //   ColorScheme colorScheme, // 拥有13种颜色，可用于配置大多数组件的颜色。
  //   DialogTheme dialogTheme, // 自定义Dialog的主题形状
  //   Typography typography, // 用于配置TextTheme、primaryTextTheme和accentTextTheme的颜色和几何TextTheme值。
  //   CupertinoThemeData cupertinoOverrideTheme
  // })

  // const ButtonStyle({
  //   this.textStyle, //字体样式
  //   this.backgroundColor, //背景色
  //   this.foregroundColor, //前景色
  //   this.overlayColor, // 高亮色，按钮处于focused, hovered, or pressed时的颜色
  //   this.shadowColor, // 阴影颜色
  //   this.elevation, // 阴影值
  //   this.padding, // padding
  //   this.minimumSize, //最小尺寸
  //   this.side, //边框
  //   this.shape, //形状
  //   this.mouseCursor, //鼠标指针的光标进入或悬停在此按钮的[InkWell]上时。
  //   this.visualDensity, // 按钮布局的紧凑程度
  //   this.tapTargetSize, // 响应触摸的区域
  //   this.animationDuration, //[shape]和[elevation]的动画更改的持续时间。
  //   this.enableFeedback, // 检测到的手势是否应提供声音和/或触觉反馈。例如，在Android上，点击会产生咔哒声，启用反馈后，长按会产生短暂的振动。通常，组件默认值为true。
  // });
  //
}