import 'package:flutter/material.dart';

// import 'package:flutter_deer/order/page/order_page.dart';
// import 'package:flutter_deer/res/resources.dart';

// import 'package:flutter_deer/routers/fluro_navigator.dart';
// import 'package:flutter_deer/statistics/statistics_router.dart';

// import 'package:flutter_deer/util/image_utils.dart';
// import 'package:flutter_deer/util/screen_utils.dart';
// import 'package:flutter_deer/util/theme_utils.dart';
// import 'package:flutter_deer/widgets/load_image.dart';
import 'my_card.dart';
import 'my_flexible_space_bar.dart';

/// design/5统计/index.html
class StatisticsPage extends StatefulWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        key: const Key('statistic_list'),
        physics: const ClampingScrollPhysics(),
        slivers: _sliverBuilder(),
      ),
    );
  }

  bool isDark = false;

  List<Widget> _sliverBuilder() {
    isDark = false;
    return <Widget>[
      SliverAppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        expandedHeight: 100.0,
        pinned: true,
        flexibleSpace: MyFlexibleSpaceBar(
          background: Container(
                  height: 115.0,
                  color: Colours.dark_bg_color,
                ),
          //     : LoadAssetImage(
          //         'statistic/statistic_bg',
          //         width: 100,
          //         height: 115.0,
          //         fit: BoxFit.fill,
          //       ),
          centerTitle: true,
          titlePadding:
              const EdgeInsetsDirectional.only(start: 16.0, bottom: 14.0),
          collapseMode: CollapseMode.pin,
          title: Text(
            '统计',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      SliverPersistentHeader(
        pinned: true,
        delegate: SliverAppBarDelegate(
          DecoratedBox(
            decoration: BoxDecoration(
              color: isDark ? Colours.dark_bg_color : null,
              image:
              DecorationImage(
                      image: new AssetImage('images/statistic_bg1.png'),
                      fit: BoxFit.fill,
                    ),
            ),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.center,
              height: 120.0,
              child: MyCard(
                child: Row(
                  children: const <Widget>[
                    _StatisticsTab('新订单(单)', 'xdd', '80'),
                    _StatisticsTab('待配送(单)', 'dps', '80'),
                    _StatisticsTab('今日交易额(元)', 'jrjye', '8000.00'),
                  ],
                ),
              ),
            ),
          ),
          120.0,
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Text('数据走势'),

              _StatisticsItem('订单统计', 'sjzs', 1),

              _StatisticsItem('交易额统计', 'jyetj', 2),

              _StatisticsItem('商品统计', 'sptj', 3),
            ],
          ),
        ),
      )
    ];
  }
}

class _StatisticsItem extends StatelessWidget {
  const _StatisticsItem(this.title, this.img, this.index, {Key? key})
      : super(key: key);

  final String title;
  final String img;
  final int index;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.14,
      child: GestureDetector(
        onTap: () {
          if (index == 1 || index == 2) {
            // NavigatorUtils.push(context, '${StatisticsRouter.orderStatisticsPage}?index=$index');
          } else {
            // NavigatorUtils.push(context, StatisticsRouter.goodsStatisticsPage);
          }
        },
        child: MyCard(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(title),
                      // Text(title, style: TextStyles.textBold14),
                      // const LoadAssetImage('statistic/icon_selected',
                      //     height: 16.0, width: 16.0)
                    ],
                  ),
                ),
                // Expanded(
                //     child: LoadAssetImage('statistic/$img', fit: BoxFit.fill))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatisticsTab extends StatelessWidget {
  const _StatisticsTab(this.title, this.img, this.content);

  final String title;
  final String img;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MergeSemantics(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // LoadAssetImage('statistic/$img', width: 40.0, height: 40.0),
            Text(title, style: Theme.of(context).textTheme.subtitle2),
            Text(content, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverAppBarDelegate(this.widget, this.height);

  final Widget widget;
  final double height;

  // minHeight 和 maxHeight 的值设置为相同时，header就不会收缩了
  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return widget;
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return true;
  }
}

// class LoadAssetImage extends StatelessWidget {
//
//   const LoadAssetImage(this.image, {
//     Key? key,
//     this.width,
//     this.height,
//     this.cacheWidth,
//     this.cacheHeight,
//     this.fit,
//     this.format = ImageFormat.png,
//     this.color
//   }): super(key: key);
//
//   final String image;
//   final double? width;
//   final double? height;
//   final int? cacheWidth;
//   final int? cacheHeight;
//   final BoxFit? fit;
//   final ImageFormat format;
//   final Color? color;
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Image.asset(
//       ImageUtils.getImgPath(image, format: format),
//       height: height,
//       width: width,
//       cacheWidth: cacheWidth,
//       cacheHeight: cacheHeight,
//       fit: fit,
//       color: color,
//       /// 忽略图片语义
//       excludeFromSemantics: true,
//     );
//   }
// }