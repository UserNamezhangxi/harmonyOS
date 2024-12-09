
@Component
struct GrandSonCom {
  @Consume themeColor:string
  build() {
    Column() {
      Text('我是孙子 ' + this.themeColor)
    }.backgroundColor(Color.Green)
    .width('40%')
    .height(100)
    .margin({top:30})
    .onClick(() => {
      this.themeColor = 'red'
    })

  }
}

@Component
struct ChildCom {
  build() {
    Column() {
      Text('我是儿子')
      GrandSonCom()
    }
    .backgroundColor(Color.Pink)
      .width('80%')
      .height(200)
  }
}


@Entry
@Component
struct Index {
  @Provide themeColor:string = 'yellow'
  build() {
    Column({ space: 10 }) {
      Text('父组件' + this.themeColor )
      ChildCom()
      ChildCom()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.Gray)
  }
}
