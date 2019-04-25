# 第一个Futter应用

[TOC]

##  1.程序计数器代码解析

### 1.1 示例

代码是在 **lib/main.dart** 文件中

```dart
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
```

### 1.2 代码分析

1. 导入包

   ```dart
   import 'package:flutter/material.dart';
   ```

2. 应用入口

   ```dart
   void main() => runApp(new MyApp());
   ```

3. 应用结构

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      //应用名称  
      title: 'Flutter Demo', 
      theme: new ThemeData(
        //蓝色主题  
        primarySwatch: Colors.blue,
      ),
      //应用首页路由  
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
```

- `MyApp`类代表Flutter应用，它继承了 `StatelessWidget`类，这也就意味着应用本身也是一个widget。
- 在Flutter中，大多数东西都是widget，包括对齐(alignment)、填充(padding)和布局(layout)。
- Flutter在构建页面时，会调用组件的`build`方法，widget的主要工作是提供一个build()方法来描述如何构建UI界面（通常是通过组合、拼装其它基础widget）。
- `MaterialApp` 是Material库中提供的Flutter APP框架，通过它可以设置应用的名称、主题、语言、首页及路由列表等。`MaterialApp`也是一个widget。
- `Scaffold` 是Material库中提供的页面脚手架，它包含导航栏和Body以及FloatingActionButton（如果需要的话）。 本书后面示例中，路由默认都是通过`Scaffold`创建。
- `home` 为Flutter应用的首页，它也是一个widget。

4. 首页

```dart
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 ...
}
```

`MyHomePage` 是应用的首页，它继承自`StatefulWidget`类，表示它是一个有状态的widget（Stateful widget）。现在，我们可以简单认为Stateful widget 和Stateless widget有两点不同：

1. Stateful widget可以拥有状态，这些状态在widget生命周期中是可以变的，而Stateless widget是不可变的。

2. Stateful widget至少由两个类组成：

   - 一个`StatefulWidget`类。
   - 一个 State类； `StatefulWidget`类本身是不变的，但是 State类中持有的状态在widget生命周期中可能会发生变化。

   `_MyHomePageState`类是`MyHomePage`类对应的状态类。看到这里，细心的读者可能已经发现，和`MyApp` 类不同， `MyHomePage`类中并没有`build`方法，取而代之的是，`build`方法被挪到了`_MyHomePageState`方法中，至于为什么这么做，先留个疑问，在分析完完整代码后再来解答。

接下来，我们看看`_MyHomePageState`中都包含哪些东西：

1. 状态。

   ```dart
   int _counter = 0;
   ```

   `_counter` 为保存屏幕右下角带“➕”号按钮点击次数的状态。

2. 设置状态的自增函数。

   ```dart
   void _incrementCounter() {
     setState(() {
        _counter++;
     });
   }
   ```

   当按钮点击时，会调用此函数，该函数的作用是先自增`_counter`，然后调用`setState` 方法。`setState`方法的作用是通知Flutter框架，有状态发生了改变，Flutter框架收到通知后，会执行`build`方法来根据新的状态重新构建界面， Flutter 对此方法做了优化，使重新执行变的很快，所以你可以重新构建任何需要更新的东西，而无需分别去修改各个widget。

3. 构建UI界面

   构建UI界面的逻辑在`build`方法中，当`MyHomePage`第一次创建时，`_MyHomePageState`类会被创建，当初始化完成后，Flutter框架会调用Widget的`build`方法来构建widget树，最终将widget树渲染到设备屏幕上。所以，我们看看`_MyHomePageState`的`build`方法中都干了什么事：

   ```dart
     Widget build(BuildContext context) {
       return new Scaffold(
         appBar: new AppBar(
           title: new Text(widget.title),
         ),
         body: new Center(
           child: new Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               new Text(
                 'You have pushed the button this many times:',
               ),
               new Text(
                 '$_counter',
                 style: Theme.of(context).textTheme.display1,
               ),
             ],
           ),
         ),
         floatingActionButton: new FloatingActionButton(
           onPressed: _incrementCounter,
           tooltip: 'Increment',
           child: new Icon(Icons.add),
         ),
       );
     }
   ```

   - Scaffold 是 Material库中提供的一个widget, 它提供了默认的导航栏、标题和包含主屏幕widget树的body属性。widget树可以很复杂。
   - body的widget树中包含了一个`Center` widget，`Center` 可以将其子widget树对齐到屏幕中心， `Center` 子widget是一个`Column` widget，`Column`的作用是将其所有子widget沿屏幕垂直方向依次排列， 此例中`Column`包含两个 `Text`子widget，第一个`Text` widget显示固定文本 “You have pushed the button this many times:”，第二个`Text` widget显示`_counter`状态的数值。
   - floatingActionButton是页面右下角的带“➕”的悬浮按钮，它的`onPressed`属性接受一个回调函数，代表它本点击后的处理器，本例中直接将`_incrementCounter`作为其处理函数。

现在，我们将整个流程串起来：当右下角的floatingActionButton按钮被点击之后，会调用`_incrementCounter`，在`_incrementCounter`中，首先会自增`_counter`计数器（状态），然后`setState`会通知Flutter框架状态发生变化，接着，Flutter会调用`build`方法以新的状态重新构建UI，最终显示在设备屏幕上。

## 2.路由管理

主要作用是用于页面跳转

### 2.1 示例

在“计数器”示例的基础上，做如下修改：

1. 创建一个新路由，命名“NewRoute”

   ```dart
   class NewRoute extends StatelessWidget {
     @override
     Widget build(BuildContext context) {
       return Scaffold(
         appBar: AppBar(
           title: Text("New route"),
         ),
         body: Center(
           child: Text("This is new route"),
         ),
       );
     }
   }
   ```

   新路由继承自`StatelessWidget`，界面很简单，在页面中间显示一句"This is new route"。

2. 在`_MyHomePageState.build`方法中的`Column`的子widget中添加一个按钮（`FlatButton`） :

```dart
Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
      ... //省略无关代码
      FlatButton(
         child: Text("open new route"),
         textColor: Colors.blue,
         onPressed: () {
          //导航到新路由   
          Navigator.push( context,
           new MaterialPageRoute(builder: (context) {
                  return new NewRoute();
             }));
          },
         ),
       ],
 )
```

此时，便可以跳转页面了。

### 2.2 源码解析

#### 2.2.1 MaterialPageRoute

`MaterialPageRoute`继承自`PageRoute`类，`PageRoute`类是一个抽象类，表示占有整个屏幕空间的一个模态路由页面，它还定义了路由构建及切换时过渡动画的相关接口及属性。`MaterialPageRoute` 是Material组件库的一个Widget，它可以针对不同平台，实现与平台页面切换动画风格一致的路由切换动画：

- 对于Android，当打开新页面时，新的页面会从屏幕底部滑动到屏幕顶部；当关闭页面时，当前页面会从屏幕顶部滑动到屏幕底部后消失，同时上一个页面会显示到屏幕上。
- 对于iOS，当打开页面时，新的页面会从屏幕右侧边缘一致滑动到屏幕左边，直到新页面全部显示到屏幕上，而上一个页面则会从当前屏幕滑动到屏幕左侧而消失；当关闭页面时，正好相反，当前页面会从屏幕右侧滑出，同时上一个页面会从屏幕左侧滑入。

下面我们介绍一下`MaterialPageRoute` 构造函数的各个参数的意义：

```dart
  MaterialPageRoute({
    WidgetBuilder builder,
    RouteSettings settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  })
```

- `builder` 是一个WidgetBuilder类型的回调函数，它的作用是构建路由页面的具体内容，返回值是一个widget。我们通常要实现此回调，返回新路由的实例。

- `settings` 包含路由的配置信息，如路由名称、是否初始路由（首页）。

- `maintainState`：默认情况下，当入栈一个新路由时，原来的路由仍然会被保存在内存中，如果想在路由没用的时候释放其所占用的所有资源，可以设置`maintainState`为false。

- `fullscreenDialog`表示新的路由页面是否是一个全屏的模态对话框，在iOS中，如果`fullscreenDialog`为`true`，新页面将会从屏幕底部滑入（而不是水平方向）。

  #### 2.2.2  Navigator

`Navigator`是一个路由管理的widget，它通过一个栈来管理一个路由widget集合。通常当前屏幕显示的页面就是栈顶的路由。`Navigator`提供了一系列方法来管理路由栈，在此我们只介绍其最常用的两个方法：

##### Future push(BuildContext context, Route route)

将给定的路由入栈（即打开新的页面），返回值是一个`Future`对象，用以接收新路由出栈（即关闭）时的返回数据。

##### bool pop(BuildContext context, [ result ])

将栈顶路由出栈，`result`为页面关闭时返回给上一个页面的数据。

`Navigator` 还有很多其它方法，如`Navigator.replace`、`Navigator.popUntil`等，详情请参考API文档或SDK源码注释，在此不再赘述。下面我们还需要介绍一下路由相关的另一个概念“命名路由”。

### 2.3 命名路由

所谓命名路由（Named Route）即给路由起一个名字，然后可以通过路由名字直接打开新的路由。这为路由管理带来了一种直观、简单的方式。

#### 路由表

要想使用命名路由，我们必须先提供并注册一个路由表（routing table），这样应用程序才知道哪个名称与哪个路由Widget对应。路由表的定义如下：

```dart
Map<String, WidgetBuilder> routes；
```

它是一个`Map`， key 为路由的名称，是个字符串；value是个builder回调函数，用于生成相应的路由Widget。我们在通过路由名称入栈新路由时，应用会根据路由名称在路由表中找到对应的WidgetBuilder回调函数，然后调用该回调函数生成路由widget并返回。

#### 注册路由表

我们需要先注册路由表后，我们的Flutter应用才能正确处理命名路由的跳转。注册方式很简单，我们回到之前“计数器”的示例，然后在`MyApp`类的`build`方法中找到`MaterialApp`，添加`routes`属性，代码如下：

```dart
return new MaterialApp(
  title: 'Flutter Demo',
  theme: new ThemeData(
    primarySwatch: Colors.blue,
  ),
  //注册路由表
  routes:{
   "new_page":(context)=>NewRoute(),
  } ,
  home: new MyHomePage(title: 'Flutter Demo Home Page'),
);
```

现在我们就完成了路由表的注册。

#### 通过路由名打开新路由页

要通过路由名称来打开新路由，可以使用：

```
Future pushNamed(BuildContext context, String routeName)
```

`Navigator` 除了`pushNamed`方法，还有`pushReplacementNamed`等其他管理命名路由的方法，读者可以自行查看API文档。

接下来我们通过路由名来打开新的路由页，修改`FlatButton`的`onPressed`回调代码，改为：

```dart
onPressed: () {
  Navigator.pushNamed(context, "new_page");
  //Navigator.push(context,
  //  new MaterialPageRoute(builder: (context) {
  //  return new NewRoute();
  //}));  
},
```

热重载应用，再次点击“open new route”按钮，依然可以打开新的路由页。

#### 命名路由的优缺点

命名路由的最大优点是直观，我们可以通过语义化的字符串来管理路由。但其有一个明显的缺点：不能直接传递路由参数。举个例子，假设有一个新路由EchoRoute，它的功能是接受一个字符串参数`tip`，然后再在屏幕中心将`tip`的内容显示出来，代码如下：

```dart
class EchoRoute extends StatelessWidget {
  EchoRoute(this.tip);
  final String tip;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Echo route"),
      ),
      body: Center(
        //回显tip内容  
        child: Text(tip),
      ),
    );
  }
}
```

如果我们使用命名参数，就必须将路由提前注册到路由表中，所以就无法动态修改`tip`参数，如：

```dart
{
    "tip_widgets":(context)=>EchoRoute("内容固定")
}
```

综上所述，我们可以看到当路由需要参数时，使用命名路由则不够灵活。

##  3.包管理

一个完整的应用程序往往会依赖很多第三方包，正如在原生开发中，Android使用Gradle来管理依赖，iOS用Cocoapods或Carthage来管理依赖，而Flutter也有自己的依赖管理工具，本节我们主要介绍一下flutter如何使用配置文件`pubspec.yaml`（位于项目根目录）来管理第三方依赖包。

### 3.1示例

```yaml
name: flutter_in_action
description: First Flutter application.

version: 1.0.0+1

dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^0.1.2

dev_dependencies:
  flutter_test:
    sdk: flutter

flutter:
  uses-material-design: true
```

下面，我们逐一解释一下各个字段的意义：

- name：应用或包名称。
- description: 应用或包的描述、简介。
- version：应用或包的版本号。
- dependencies：应用或包依赖的其它包或插件。
- dev_dependencies：开发环境依赖的工具包（而不是flutter应用本身依赖的包）。
- flutter：flutter相关的配置选项。

如果我们的Flutter应用本身依赖某个包，我们需要将所依赖的包添加到`dependencies` 下，接下来我们通过一个例子来演示一下如何依赖、下载并使用第三方包。

### 3.2 Pub仓库

Pub（<https://pub.dartlang.org/> ）是Google官方的Dart Packages仓库，类似于node中的npm仓库，android中的jcenter，我们可以在上面查找我们需要的包和插件，也可以向pub发布我们的包和插件。我们将在后面的章节中介绍如何向pub发布我们的包和插件。

#### 示例

接下来，我们实现一个显示随机字符串的widget。有一个名为“english_words”的开源软件包，其中包含数千个常用的英文单词以及一些实用功能。我们首先在pub上找到english_words这个包，确定其最新的版本号和是否支持Flutter。

![english words](https://cdn.jsdelivr.net/gh/flutterchina/flutter-in-action@1.0/docs/imgs/english_words.png)

我们看到“english_words”包最新的版本是3.1.3，并且支持flutter，接下来：

1. 将english_words（3.1.3版本）添加到依赖项列表，如下：

   ```yaml
   dependencies:
     flutter:
       sdk: flutter
   
     cupertino_icons: ^0.1.0
     # 新添加的依赖
     english_words: ^3.1.3
   ```

2. 下载包

   在Android Studio的编辑器视图中查看pubspec.yaml时，单击右上角的 **Packages get** 。

   ![package get](https://cdn.jsdelivr.net/gh/flutterchina/flutter-in-action@1.0/docs/imgs/package_get.png)

这会将依赖包安装到您的项目。您可以在控制台中看到以下内容：

```shell
   flutter packages get
   Running "flutter packages get" in flutter_in_action...
   Process finished with exit code 0
```

你也可以在控制台，定位到当前工程目录，然后手动运行`flutter packages get` 命令来下载依赖包。

1. 引入`english_words`包。

   ```dart
   import 'package:english_words/english_words.dart';
   ```

   在输入时，Android Studio会自动提供有关库导入的建议选项。导入后该行代码将会显示为灰色，表示导入的库尚未使用。

2. 使用`english_words`包来生成随机字符串。

   ```dart
   class RandomWordsWidget extends StatelessWidget {
     @override
     Widget build(BuildContext context) {
      // 生成随机字符串
       final wordPair = new WordPair.random();
       return Padding(
         padding: const EdgeInsets.all(8.0),
         child: new Text(wordPair.toString()),
       );
     }
   }
   ```

   我们将`RandomWordsWidget` 添加到"计数器"示例的首页`MyHomePage` 的`Column`的子widget中。

3. 如果应用程序正在运行，请使用热重载按钮 (![lightning bolt icon](https://flutterchina.club/get-started/codelab/images/hot-reload-button.png)) 更新正在运行的应用程序。每次单击热重载或保存项目时，都会在正在运行的应用程序中随机选择不同的单词对。 这是因为单词对是在 `build` 方法内部生成的。每次热更新时，`build`方法都会被执行。

   ![image-20180822163100650](https://cdn.jsdelivr.net/gh/flutterchina/flutter-in-action@1.0/docs/imgs/image-20180822163100650.png)

### 3.3  其它依赖方式

上文所述的依赖方式是依赖pub仓库的。但我们还可以依赖本地包和git仓库。

- 依赖本地包

  如果我们正在本地开发一个包，包名为pkg1，我们可以通过下面方式依赖：

  ```yaml
  dependencies:
      pkg1:
          path: ../../code/pkg1
  ```

  路径可以是相对的，也可以是绝对的。

- 依赖Git：你也可以依赖存储在Git仓库中的包。如果软件包位于仓库的根目录中，请使用以下语法

  ```yaml
  dependencies:
    pkg1:
      git:
        url: git://github.com/xxx/pkg1.git
  ```

  上面假定包位于Git存储库的根目录中。如果不是这种情况，可以使用path参数指定相对位置，例如：

  ```yaml
  dependencies:
    package1:
      git:
        url: git://github.com/flutter/packages.git
        path: packages/package1
  ```

### 3.4  总结

本节介绍了引用、下载、使用一个包的整体流程，并在后面介绍了多种不同的引入方式，这些是Flutter开发中常用的，但Dart的dependencies还有一些其它依赖方式，完整的内容读者可以自行查看：<https://www.dartlang.org/tools/pub/dependencies> 。

## 4.资源管理

Flutter应用程序可以包含代码和 assets（有时称为资源）。assets是会打包到程序安装包中的，可在运行时访问。常见类型的assets包括静态数据（例如JSON文件）、配置文件、图标和图片（JPEG，WebP，GIF，动画WebP / GIF，PNG，BMP和WBMP）等。

### 4.1指定 assets

和包管理一样，Flutter也使用[`pubspec.yaml`](https://www.dartlang.org/tools/pub/pubspec)文件来管理应用程序所需的资源。举一个例子:

```
flutter:
  assets:
    - assets/my_icon.png
    - assets/background.png
```

`assets`指定应包含在应用程序中的文件。 每个asset都通过相对于`pubspec.yaml`文件所在位置的显式路径进行标识。asset的声明顺序是无关紧要的。asset的实际目录可以是任意文件夹（在本示例中是assets）。

在构建期间，Flutter将asset放置到称为 *asset bundle* 的特殊存档中，应用程序可以在运行时读取它们（但不能修改）。

### 4.2  Asset 变体（variant）

构建过程支持asset变体的概念：不同版本的asset可能会显示在不同的上下文中。 在`pubspec.yaml`的assets部分中指定asset路径时，构建过程中，会在相邻子目录中查找具有相同名称的任何文件。这些文件随后会与指定的asset一起被包含在asset bundle中。

例如，如果应用程序目录中有以下文件:

- …/pubspec.yaml
- …/graphics/my_icon.png
- …/graphics/background.png
- …/graphics/dark/background.png
- …etc.

然后`pubspec.yaml`文件中只需包含:

```
flutter:
  assets:
    - graphics/background.png
```

那么这两个`graphics/background.png`和`graphics/dark/background.png` 都将包含在您的asset bundle中。前者被认为是*main asset* （主资源），后者被认为是一种变体（variant）。

在选择匹配当前设备分辨率的图片时，Flutter会使用到asset变体（见下文），将来，Flutter可能会将这种机制扩展到本地化、阅读提示等方面。

### 4.3 加载 assets

您的应用可以通过[`AssetBundle`](https://docs.flutter.io/flutter/services/AssetBundle-class.html)对象访问其asset 。有两种主要方法允许从Asset bundle中加载字符串或图片(二进制)文件。

#### 4.3.1 加载文本assets

- 通过[`rootBundle`](https://docs.flutter.io/flutter/services/rootBundle.html) 对象加载：每个Flutter应用程序都有一个[`rootBundle`](https://docs.flutter.io/flutter/services/rootBundle.html)对象， 通过它可以轻松访问主资源包，直接使用`package:flutter/services.dart`中全局静态的`rootBundle`对象来加载asset即可。
- 通过 [`DefaultAssetBundle`](https://docs.flutter.io/flutter/widgets/DefaultAssetBundle-class.html) 加载：建议使用 [`DefaultAssetBundle`](https://docs.flutter.io/flutter/widgets/DefaultAssetBundle-class.html) 来获取当前BuildContext的AssetBundle。 这种方法不是使用应用程序构建的默认asset bundle，而是使父级widget在运行时动态替换的不同的AssetBundle，这对于本地化或测试场景很有用。

通常，可以使用`DefaultAssetBundle.of()`在应用运行时来间接加载asset（例如JSON文件），而在widget上下文之外，或其它`AssetBundle`句柄不可用时，可以使用`rootBundle`直接加载这些asset，例如：

```dart
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

Future<String> loadAsset() async {
  return await rootBundle.loadString('assets/config.json');
}
```

#### 4.3.2 加载图片

类似于原生开发，Flutter也可以为当前设备加载适合其分辨率的图像。

#####  声明分辨率相关的图片 assets

[`AssetImage`](https://docs.flutter.io/flutter/painting/AssetImage-class.html) 可以将asset的请求逻辑映射到最接近当前设备像素比例(dpi)的asset。为了使这种映射起作用，必须根据特定的目录结构来保存asset：

- …/image.png
- …/**M**x/image.png
- …/**N**x/image.png
- …etc.

其中M和N是数字标识符，对应于其中包含的图像的分辨率，也就是说，它们指定不同设备像素比例的图片。

主资源默认对应于1.0倍的分辨率图片。看一个例子：

- …/my_icon.png
- …/2.0x/my_icon.png
- …/3.0x/my_icon.png

在设备像素比率为1.8的设备上，`.../2.0x/my_icon.png` 将被选择。对于2.7的设备像素比率，`.../3.0x/my_icon.png`将被选择。

如果未在`Image` widget上指定渲染图像的宽度和高度，那么`Image` widget将占用与主资源相同的屏幕空间大小。 也就是说，如果`.../my_icon.png`是72px乘72px，那么`.../3.0x/my_icon.png`应该是216px乘216px; 但如果未指定宽度和高度，它们都将渲染为72像素×72像素（以逻辑像素为单位）。

`pubspec.yaml`中asset部分中的每一项都应与实际文件相对应，但主资源项除外。当主资源缺少某个资源时，会按分辨率从低到高的顺序去选择 ，也就是说1x中没有的话会在2x中找，2x中还没有的话就在3x中找。

##### 加载图片

要加载图片，可以使用 [`AssetImage`](https://docs.flutter.io/flutter/painting/AssetImage-class.html)类。例如，我们可以从上面的asset声明中加载背景图片：

```dart
Widget build(BuildContext context) {
  return new DecoratedBox(
    decoration: new BoxDecoration(
      image: new DecorationImage(
        image: new AssetImage('graphics/background.png'),
      ),
    ),
  );
}
```

注意，`AssetImage` 并非是一个widget， 它实际上是一个`ImageProvider`，有些时候你可能期望直接得到一个显示图片的widget，那么你可以使用`Image.asset()`方法，如：

```dart
Widget build(BuildContext context) {
  return Image.asset('graphics/background.png');
}
```

使用默认的 asset bundle 加载资源时，内部会自动处理分辨率等，这些处理对开发者来说是无感知的。 (如果使用一些更低级别的类，如 [`ImageStream`](https://docs.flutter.io/flutter/painting/ImageStream-class.html)或 [`ImageCache`](https://docs.flutter.io/flutter/painting/ImageCache-class.html) 时你会注意到有与缩放相关的参数)

##### 依赖包中的资源图片

要加载依赖包中的图像，必须给`AssetImage`提供`package`参数。

例如，假设您的应用程序依赖于一个名为“my_icons”的包，它具有如下目录结构：

- …/pubspec.yaml
- …/icons/heart.png
- …/icons/1.5x/heart.png
- …/icons/2.0x/heart.png
- …etc.

然后加载图像，使用:

```dart
 new AssetImage('icons/heart.png', package: 'my_icons')
```

或

```dart
new Image.asset('icons/heart.png', package: 'my_icons')
```

**注意：包在使用本身的资源时也应该加上package参数来获取**。

##### 打包包中的 assets

如果在`pubspec.yaml`文件中声明了期望的资源，它将会打包到相应的package中。特别是，包本身使用的资源必须在`pubspec.yaml`中指定。

包也可以选择在其`lib/`文件夹中包含未在其`pubspec.yaml`文件中声明的资源。在这种情况下，对于要打包的图片，应用程序必须在`pubspec.yaml`中指定包含哪些图像。 例如，一个名为“fancy_backgrounds”的包，可能包含以下文件：

- …/lib/backgrounds/background1.png
- …/lib/backgrounds/background2.png
- …/lib/backgrounds/background3.png

要包含第一张图像，必须在`pubspec.yaml`的assets部分中声明它：

```
flutter:
  assets:
    - packages/fancy_backgrounds/backgrounds/background1.png
```

`lib/`是隐含的，所以它不应该包含在资产路径中。

### 4.4 特定平台 assets

上面的资源都是flutter应用中的，这些资源只有在Flutter框架运行之后才能使用，如果要给我们的应用设置APP图标或者添加启动图，那我们必须使用特定平台的assets。

#### 设置APP图标

更新Flutter应用程序启动图标的方式与在本机Android或iOS应用程序中更新启动图标的方式相同。

- Android

  在Flutter项目的根目录中，导航到`.../android/app/src/main/res`目录，里面包含了各种资源文件夹（如`mipmap-hdpi`已包含占位符图像”ic_launcher.png”）。 只需按照[Android开发人员指南](https://developer.android.com/guide/practices/ui_guidelines/icon_design_launcher.html#size)中的说明， 将其替换为所需的资源，并遵守每种屏幕密度（dpi）的建议图标大小标准。

  ![Android icon location](https://flutterchina.club/images/assets-and-images/android-icon-path.png)

  > **注意:** 如果您重命名.png文件，则还必须在您`AndroidManifest.xml`的`<application>`标签的`android:icon`属性中更新名称。

- iOS

  在Flutter项目的根目录中，导航到`.../ios/Runner`。该目录中`Assets.xcassets/AppIcon.appiconset`已经包含占位符图片。 只需将它们替换为适当大小的图片。保留原始文件名称。

  ![iOS icon location](https://flutterchina.club/images/assets-and-images/ios-icon-path.png)

#### 更新启动页

![Launch screen](https://flutterchina.club/images/assets-and-images/launch-screen.png)

在Flutter框架加载时，Flutter会使用本地平台机制绘制启动页。此启动页将持续到Flutter渲染应用程序的第一帧时。

> **注意:** 这意味着如果您不在应用程序的`main()`方法中调用[runApp](https://docs.flutter.io/flutter/widgets/runApp.html) 函数 （或者更具体地说，如果您不调用[`window.render`](https://docs.flutter.io/flutter/dart-ui/Window/render.html)去响应[`window.onDrawFrame`](https://docs.flutter.io/flutter/dart-ui/Window/onDrawFrame.html)）的话， 启动屏幕将永远持续显示。

###### Android

要将启动屏幕（splash screen）添加到您的Flutter应用程序， 请导航至`.../android/app/src/main`。在`res/drawable/launch_background.xml`，通过自定义drawable来实现自定义启动界面（你也可以直接换一张图片）。

###### iOS

要将图片添加到启动屏幕（splash screen）的中心，请导航至`.../ios/Runner`。在`Assets.xcassets/LaunchImage.imageset`， 拖入图片，并命名为`LaunchImage.png`、`LaunchImage@2x.png`、`LaunchImage@3x.png`。 如果你使用不同的文件名，那您还必须更新同一目录中的`Contents.json`文件，图片的具体尺寸可以查看苹果官方的标准。

您也可以通过打开Xcode完全自定义storyboard。在Project Navigator中导航到`Runner/Runner`然后通过打开`Assets.xcassets`拖入图片，或者通过在LaunchScreen.storyboard中使用Interface Builder进行自定义。

![Adding launch icons in Xcode](https://flutterchina.club/images/assets-and-images/ios-launchscreen-xcode.png)

## 5.Dart线程模型及异常捕获

### 5.1  Dart单线程模型

在Java和OC中，如果程序发生异常且没有被捕获，那么程序将会终止，但在Dart或JavaScript中则不会，究其原因，这和它们的运行机制有关系，Java和OC都是多线程模型的编程语言，任意一个线程触发异常且没被捕获时，整个进程就退出了。但Dart和JavaScript不同，它们都是单线程模型，运行机制很相似(但有区别)，下面我们通过Dart官方提供的一张图来看看dart大致运行原理：

![both-queues](https://cdn.jsdelivr.net/gh/flutterchina/flutter-in-action/docs/imgs/both-queues.png)

Dart 在单线程中是以消息循环机制来运行的，其中包含两个任务队列，一个是“微任务队列” **microtask queue**，另一个叫做“事件队列” **event queue**。从图中可以发现，微任务队列的执行优先级高于事件队列。

现在我们来介绍一下Dart线程运行过程，如上图中所示，入口函数 main() 执行完后，消息循环机制便启动了。首先会按照先进先出的顺序逐个执行微任务队列中的任务，当所有微任务队列执行完后便开始执行事件队列中的任务，事件任务执行完毕后再去执行微任务，如此循环往复，生生不息。

在Dart中，所有的外部事件任务都在事件队列中，如IO、计时器、点击、以及绘制事件等，而微任务通常来源于Dart内部，并且微任务非常少，之所以如此，是因为微任务队列优先级高，如果微任务太多，执行时间总和就越久，事件队列任务的延迟也就越久，对于GUI应用来说最直观的表现就是比较卡，所以必须得保证微任务队列不会太长。值得注意的是，我们可以通过`Future.microtask(…)`方法向微任务队列插入一个任务。

在事件循环中，当某个任务发生异常并没有被捕获时，程序并不会退出，而直接导致的结果是**当前任务**的后续代码就不会被执行了，也就是说一个任务中的异常是不会影响其它任务执行的。

### 5.2 Flutter异常捕获

Dart中可以通过`try/catch/finally`来捕获代码块异常，这个和其它编程语言类似，，如果读者不清楚，可以查看Dart语言文档，不在赘述，下面我们看看Flutter中的异常捕获。

#### 5.2.1 Flutter框架异常捕获

Flutter 框架为我们在很多关键的方法进行了异常捕获。这里举一个例子，当我们布局发生越界或不合规范时，Flutter就会自动弹出一个错误界面，这是因为Flutter已经在执行build方法时添加了异常捕获，最终的源码如下：

```dart
@override
void performRebuild() {
 ...
  try {
    //执行build方法  
    built = build();
  } catch (e, stack) {
    // 有异常时则弹出错误提示  
    built = ErrorWidget.builder(_debugReportException('building $this', e, stack));
  } 
  ...
}
```

可以看到，在发生异常时，Flutter默认的处理方式是弹一个ErrorWidget，但如果我们想自己捕获异常并上报到报警平台的话应该怎么做？我们进入`_debugReportException()`方法看看：

```dart
FlutterErrorDetails _debugReportException(
  String context,
  dynamic exception,
  StackTrace stack, {
  InformationCollector informationCollector
}) {
  //构建错误详情对象  
  final FlutterErrorDetails details = FlutterErrorDetails(
    exception: exception,
    stack: stack,
    library: 'widgets library',
    context: context,
    informationCollector: informationCollector,
  );
  //报告错误 
  FlutterError.reportError(details);
  return details;
}
```

我们发现，错误是通过`FlutterError.reportError`方法上报的，继续跟踪：

```dart
static void reportError(FlutterErrorDetails details) {
  ...
  if (onError != null)
    onError(details); //调用了onError回调
}
```

我们发现`onError`是`FlutterError`的一个静态属性，它有一个默认的处理方法 `dumpErrorToConsole`，到这里就清晰了，如果我们想自己上报异常，只需要提供一个自定义的错误处理回调即可，如：

```dart
void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    reportError(details);
  };
 ...
}
```

这样我们就可以处理那些Flutter为我们捕获的异常了，接下来我们看看如何捕获其它异常。

#### 5.2.2  其它异常捕获与日志收集

在Flutter中，还有一些Flutter没有为我们捕获的异常，如调用空对象方法异常、Future中的异常。在Dart中，异常分两类：同步异常和异步异常，同步异常可以通过`try/catch`捕获，而异步异常则比较麻烦，如下面的代码是捕获不了`Future`的异常的：

```dart
try{
    Future.delayed(Duration(seconds: 1)).then((e) => Future.error("xxx"));
}catch (e){
    print(e)
}
```

Dart中有一个`runZoned(...)` 方法，可以给执行对象指定一个Zone。Zone表示一个代码执行的环境范围，为了方便理解，读者可以将Zone类比为一个代码执行沙箱，不同沙箱的之间是隔离的，沙箱可以捕获、拦截或修改一些代码行为，如Zone中可以捕获日志输出、Timer创建、微任务调度的行为，同时Zone也可以捕获所有未处理的异常。下面我们看看`runZoned(...)`方法定义：

```dart
R runZoned<R>(R body(), {
    Map zoneValues, 
    ZoneSpecification zoneSpecification,
    Function onError,
})
```

- zoneValues: Zone 的私有数据，可以通过实例`zone[key]`获取，可以理解为每个“沙箱”的私有数据。

- zoneSpecification：Zone的一些配置，可以自定义一些代码行为，比如拦截日志输出行为等，举个例子：

  下面是拦截应用中所有调用`print`输出日志的行为。

  ```dart
  main() {
    runZoned(() => runApp(MyApp()), zoneSpecification: new ZoneSpecification(
        print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
          parent.print(zone, "Intercepted: $line");
        }),
    );
  }
  ```

  这样一来，我们APP中所有调用`print`方法输出日志的行为都会被拦截，通过这种方式，我们也可以在应用中记录日志，等到应用触发未捕获的异常时，将异常信息和日志统一上报。ZoneSpecification还可以自定义一些其他行为，读者可以查看API文档。

- onError：Zone中未捕获异常处理回调，如果开发者提供了onError回调或者通过`ZoneSpecification.handleUncaughtError`指定了错误处理回调，那么这个zone将会变成一个error-zone，该error-zone中发生未捕获异常(无论同步还是异步)时都会调用开发者提供的回调，如：

  ```dart
  runZoned(() {
      runApp(MyApp());
  }, onError: (Object obj, StackTrace stack) {
      var details=makeDetails(obj,stack);
      reportError(details);
  });
  ```

  这样一来，结合上面的`FlutterError.onError`我们就可以捕获我们Flutter应用中全部错误了！需要注意的是，error-zone内部发生的错误是不会跨越当前error-zone的边界的，如果想跨越error-zone边界去捕获异常，可以通过共同的“源”zone来捕获，如：

  ```dart
  var future = new Future.value(499);
  runZoned(() {
      var future2 = future.then((_) { throw "error in first error-zone"; });
      runZoned(() {
          var future3 = future2.catchError((e) { print("Never reached!"); });
      }, onError: (e) { print("unused error handler"); });
  }, onError: (e) { print("catches error of first error-zone."); });
  ```

### 5.3 总结

我们最终的异常捕获和上报代码如下：

```dart
void collectLog(String line){
    ... //收集日志
}
void reportErrorAndLog(FlutterErrorDetails details){
    ... //上报错误和日志逻辑
}

FlutterErrorDetails makeDetails(Object obj, StackTrace stack){
    ...// 构建错误信息
}

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    reportErrorAndLog(details);
  };
  runZoned(
    () => runApp(MyApp()),
    zoneSpecification: ZoneSpecification(
      print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
        collectLog(line); //手机日志
      },
    ),
    onError: (Object obj, StackTrace stack) {
      var details = makeDetails(obj, stack);
      reportErrorAndLog(details);
    },
  );
}
```