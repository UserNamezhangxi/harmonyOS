import { faceDetector } from '@kit.CoreVisionKit'

// 定义接口
interface ImageCount {
  url: string
  count: number
}


@Entry
@Component
struct Index {
  @State images: ImageCount[] = [
    { url: 'app.media.bg_00', count: 0 },
    { url: 'app.media.bg_01', count: 0 },
    { url: 'app.media.bg_02', count: 0 },
    { url: 'app.media.bg_03', count: 0 },
    { url: 'app.media.bg_04', count: 0 },
    { url: 'app.media.bg_05', count: 0 }
  ]
  @State phoneArr: string[] = ['app.media.phone0', 'app.media.phone1', 'app.media.phone2']
  @State randomIndex: number = 0 // 点击立即抽卡随机出一个卡片
  @State maskOpacity: number = 0 // 控制抽到卡片的透明度
  @State maskZIndex: number = -1 // 控制卡片层级
  @State imageScaleX: number = 0 // 遮罩层图片缩放X，Y
  @State imageScaleY: number = 0
  @State phone: string = ''
  @State isGet: boolean = false // 是否抽中6个卡片（大奖）

  build() {
    Stack() {
      Column() {
        Grid() {
          ForEach(this.images, (item: ImageCount, index: number) => {
            GridItem() {
              Badge({
                position: BadgePosition.RightTop,
                count: item.count,
                style: {
                  fontSize: 12, // 文字大小
                  badgeSize: 16, // 圆形大小
                  badgeColor: Color.Red // 背景色
                }
              }) {
                Image(item.count > 0 ? $r(item.url) : $r('app.media.bg'))
                  .padding(5)
                  .borderRadius(5)
                  .backgroundColor('#EEEEEE')
              }
            }.padding(4)
          })
        }
        .width('100%')
        .columnsTemplate('1fr 1fr 1fr')
        .rowsTemplate('1fr 1fr')
        .height(300)
        .rowsGap(3)
        .columnsGap(3)

        Button('立即抽卡')
          .margin(10)
          .width('50%')
          .backgroundColor(Color.Brown)
          .onClick(() => {
            this.randomIndex = Math.floor(Math.random() * 6)
            this.maskOpacity = 1
            this.maskZIndex = 1

            this.imageScaleX = 1
            this.imageScaleY = 1

            this.images[this.randomIndex] = {
              url: 'app.media.bg_0' + this.randomIndex, count: this.images[this.randomIndex].count + 1
            }
          })
      }.width('100%')

      Column({ space: 20 }) {
        Text('获得生肖卡').fontSize(20).fontColor(Color.White).margin(20)
        Image($r(this.images[this.randomIndex].url))
          .width(200)
          .height(320)
          .borderRadius(10)
          .scale({
            x: this.imageScaleX,
            y: this.imageScaleY
          })
          .animation({
            duration: 500
          })
        Button('开心收下')
          .backgroundColor(Color.Transparent)
          .border({
            width: 1,
            color: '#ffffff'
          })
          .width('50%')
          .margin(30)
          .onClick(() => {
            this.maskZIndex = -1
            this.maskOpacity = 0

            this.imageScaleX = 0
            this.imageScaleY = 0

            // 收下卡片后判断是否集齐6张卡
            let num = this.images.findIndex((item: ImageCount, index: number) => {
              return item.count == 0
            })
            this.isGet = num == -1
            console.log('isget ', this.isGet)
            if (this.isGet) {
              let randomPhoneIndex: number = Math.floor(Math.random() * 3)
              this.phone = this.phoneArr[randomPhoneIndex]
            }
          })
      }
      .backgroundColor('#F8000000')
      .width('100%')
      .height('100%')
      .zIndex(this.maskZIndex)
      .justifyContent(FlexAlign.Center)
      .opacity(this.maskOpacity)
      .animation({
        duration: 200 // 增加动画
      })

      // 抽到手机
      if (this.isGet) {
        Column({ space: 20 }) {
          Text('恭喜抽中手机了').fontSize(20).fontColor(Color.White).margin(20)
          Image($r(this.phone))
            .width(200)
            .height(320)
            .borderRadius(10)
          Button('在来一次')
            .backgroundColor(Color.Transparent)
            .border({
              width: 1,
              color: '#ffffff'
            })
            .width('50%')
            .margin(30)
            .onClick(() => {
              this.maskZIndex = -1
              this.maskOpacity = 0

              this.imageScaleX = 0
              this.imageScaleY = 0

              this.isGet = false

              this.images = [
                { url: 'app.media.bg_00', count: 0 },
                { url: 'app.media.bg_01', count: 0 },
                { url: 'app.media.bg_02', count: 0 },
                { url: 'app.media.bg_03', count: 0 },
                { url: 'app.media.bg_04', count: 0 },
                { url: 'app.media.bg_05', count: 0 }
              ]
            })
        }
        .backgroundColor('#F8000000')
        .width('100%')
        .height('100%')
        .zIndex(22)
        .justifyContent(FlexAlign.Center)
      }
    }
  }
}