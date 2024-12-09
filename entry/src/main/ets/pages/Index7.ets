@Extend(Text)
function textFn() {
  .fontSize(20)
  .fontColor(Color.Black)
  .fontWeight(700)
}

@Extend(Text)
function bannerItem(msg: string, color: ResourceColor) {
  .fontSize(20)
  .fontColor(Color.Black)
  .fontWeight(700)
  .backgroundColor(color)
  .onClick(() => {
    AlertDialog.show({
      message: msg
    })
  })
}


// 不支持传递参数
@Styles
function commonStyle() {
  .width(100)
  .height(100)
}

@Builder
function navItem(imgAddr:ResourceStr, name:string) {
  Column() {
    Image(imgAddr).width(50)
    Text(name)
  }
}


@Entry
@Component
struct Index {
  @State myColor: ResourceColor = Color.Pink

  // 如果组件内引用了this 的参数，那么需要定义在组件内部
  @Styles
  setBg() {
    .backgroundColor(this.myColor)
    .onClick(() => {
      this.myColor = Color.Orange
    })
  }

  @State reviewVotes: number = 1
  @State isCheck: boolean = false

  build() {
    Column() {
      Text('@Extend 扩展组件（事件、样式）')
        .textFn() // 相当于抽取公共样式

      Swiper() {
        Text('1').bannerItem('轮播图1号', Color.Brown)
        Text('2').bannerItem('轮播图2号', Color.Gray)
        Text('3').bannerItem('轮播图3号', Color.Green)
      }
      .width('100%')
      .height(100)
      .loop(true)
      .autoPlay(true)
      .interval(3000)
      .vertical(false)
      .aspectRatio(2) // 不同手机适配相同的宽高比例
      // .indicator(true)
      .indicator(Indicator.dot().selectedItemWidth(30).itemWidth(15).color(Color.Grey))

      Column({ space: 10 }) {
        Text('@Style')
          .commonStyle() // 样式抽取
          .setBg()       // 组件内样式抽取
        Column()
          .commonStyle()
          .setBg()
        Button()
          .commonStyle()
          .setBg()
      }

      Row({space:10}) {
        navItem($r('app.media.startIcon'),'菜鸟') // 抽取相同的 组件
        navItem($r('app.media.startIcon'),'青菜')
        navItem($r('app.media.startIcon'),'鸟叔')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceAround)
    }
  }
}