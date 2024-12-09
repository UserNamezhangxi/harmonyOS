@Entry
@Component
struct Index {
  build() {
    // 设置组件间的间距
    Column({ space: 10 }) {
      // 正圆
      Image($r('app.media.avator')).width(100).height(100).borderRadius(50)
      // 胶囊
      Image($r('app.media.avator')).width(150).height(100).borderRadius(50)

      // 背景尺寸
      Image($r('app.media.avator'))
        .width(150)
        .height(100)
        .backgroundImagePosition(Alignment.Center)
        .backgroundImageSize(ImageSize.Contain)

      // 背景图
      Text('文字内容文本')
        .width(100)
        .height(50)
        .backgroundImage($r('app.media.app_icon'), ImageRepeat.XY)
        .backgroundColor('#ffff00')
      // 背景图居中
      Text('背景图居中')
        .width(100)
        .height(50)
        .backgroundImage($r('app.media.app_icon'))
        .backgroundColor('#ffff00')
        .backgroundImagePosition(Alignment.Center)
      // 背景图自定义position
      Text('背景图居中')
        .width(100)
        .height(50)
        .backgroundImage($r('app.media.app_icon'))
        .backgroundColor('#ffff00')
        .backgroundImagePosition({ x:vp2px(10),y:vp2px(10) }) // 推荐使用vp2px适配不同屏幕


    }
    .justifyContent(FlexAlign.SpaceAround)
    .padding(10)
    .height('100%')
    .width('100%')
    .backgroundColor(Color.Pink)
    .alignItems(HorizontalAlign.Start)
  }
}