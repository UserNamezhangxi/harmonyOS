@Entry
@Component
struct Page2 {
  @State message: string = '个人中心';

  build() {
    RelativeContainer() {
      Text(this.message)
        .id('Page2HelloWorld')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
    }
    .height('100%')
    .width('100%')
  }
}