@Entry
@Component
struct Index {
  build() {
    // 设置组件间的间距
    Column() {
      // 顶部
      Row() {
        Image($r('app.media.jd_cancel')).width(20)
        Text('帮助')
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width("100%")

      // Logo
      Image($r('app.media.jd_logo')).width(200).margin({ top: 30 })

      // 输入框
      Row() {
        Text('国家/都去').layoutWeight(1)
        Text('中国（+86）')
        Image($r('app.media.arr')).width(20)
      }
      .width('100%')
      .backgroundColor('#fff')
      .height(40)
      .borderRadius(20)
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({ left: 10, right: 10 })

      TextInput({
        placeholder: '请输入手机号'
      })
        .backgroundColor('#fff')
        .margin({ top: 10 })
        .height(40)
        .borderRadius(20)
        .placeholderColor('#CCC')


      Row() {
        Checkbox().width(14)
        Text() {
          Span('我已经同意')
          Span('《协议A》').fontColor('#a0f')
          Span('《协议B》').fontColor('#a0f')
          Span('巴巴爸爸吧啦啦啦啦')
        }
      }.alignItems(VerticalAlign.Top).margin({ top: 20 })

      Button('登录').width('100%').margin({ top: 20 })

      Row() {
        Text('新用户注册')
        Text('新用户注册')
        Text('新用户注册')
      }
      .width('100%')
      .margin({ top: 20 })
      .justifyContent(FlexAlign.SpaceAround)

      Blank() // 弹簧

      Column() {
        Text('abdeffsdfsd').height(22).margin({bottom:25})
        Row() {
          Image($r('app.media.app_icon')).width(30)
          Image($r('app.media.app_icon')).width(30)
          Image($r('app.media.app_icon')).width(30)
          Image($r('app.media.app_icon')).width(30)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceAround)
      }
      .margin({bottom:25})
      .width('100%')
      .backgroundColor('#ff0000')

    }
    .width('100%')
    .height('100%')
    .padding(10)
    .backgroundImage($r('app.media.jd_bg'))
    .backgroundImageSize(ImageSize.Cover)
  }
}