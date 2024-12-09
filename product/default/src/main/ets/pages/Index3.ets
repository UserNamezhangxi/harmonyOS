@Entry
@Component
struct Index {
  build() {
    // 设置组件间的间距
    Column() {
      Row() {
        Column() {
          Text('玩一玩')
          Text('签到兑好礼|超多大奖超玩')
            .fontSize(10)
            .fontColor('#ccc')
            .margin({
              top: 5
            })
        }.alignItems(HorizontalAlign.Start)

        Row() {
          Image($r('app.media.avator')).width(30).height(30)
          Image($r('app.media.arr')).width(30).height(30)
        }
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .borderRadius(6)
      .padding(10)
      .backgroundColor('#aaa')
      .width('100%')

      Row() {
        Text('左侧').backgroundColor(Color.Orange).layoutWeight(2)
        Text('右侧').backgroundColor(Color.Pink).layoutWeight(1)
      }
      .width(300)
    }
    .width('100%')
    .padding(10)
  }
}