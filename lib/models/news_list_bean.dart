class NewsListBean {
  //资讯类型 0:资讯无图 1:资讯有图 2：3d广告
  final int type;
  final bool isFirst;
  final String title;
  final String image;

  NewsListBean(this.type, this.title, this.image, {this.isFirst = false});
}
