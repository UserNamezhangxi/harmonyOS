@Entry
@Component
struct Index {
  myScroller: Scroller = new Scroller()
  @State currentOffset: number = 0

  build() {
    Column() {
      Scroll(this.myScroller) {
        Column({ space: 10 }) {
          ForEach([1, 2, 3, 4, 5, 6], (item: number, index: number) => {
            Text(item + '').backgroundColor(Color.Pink).margin(20).width('100%').height(60)
          })
        }
      }
      .width('100%')
      .height(300)
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Off)
      .scrollBarColor('#ff0000')
      .scrollBarWidth(10)
      .edgeEffect(EdgeEffect.Spring)

      Button('返回顶部').margin(20).onClick((event: ClickEvent) => {
        this.myScroller.scrollEdge(Edge.Top)
      })
      Button('获取已经滚动的距离').margin(20).onClick((event: ClickEvent) => {
        this.currentOffset = this.myScroller.currentOffset().yOffset
        AlertDialog.show({
          title:"滚动距离",
          message:"当前滚动距离 " + this.currentOffset
        })

      })
      Button('返回指定位置').margin(20).onClick((event: ClickEvent) => {
        this.myScroller.scrollTo({
          yOffset:120,
          xOffset:0
        })
      })
    }
  }
}