import image from '@ohos.multimedia.image'

@Entry
@Component
struct Index {
  @State titles: string[] = ['首页', '同城', '关注', '大学', '娱乐', '国产', '动画', '飞机', '交通', '政治', '科技']

  @State selectIndex:number = 0

  @Builder
  myBuilder(index: number, icon: ResourceStr, tabName: string) {
    Column() {
      if (index == this.selectIndex) {
        Image(icon).width(30)
      } else {
        Image(icon).width(30).fillColor(Color.Gray)
      }

      Text(tabName)
    }
  }

  @Builder
  centerBuilder() {
    Image($r('app.media.add')).width(30)
  }

  build() {
    // Column() {
    //   Tabs() {
    //     ForEach(this.titles, (item:string, index:number) => {
    //       TabContent() {
    //         Text(`${item}内容`).fontSize(16)
    //       }
    //       .tabBar(item)
    //     })
    //   }
    //   .barMode(BarMode.Scrollable)
    // }
    // .width('100%')
    // .height('100%')
    // .padding(10)
    // .backgroundImage($r('app.media.jd_bg'))
    // .backgroundImageSize(ImageSize.Cover)

    Column() {
      Tabs() {
        TabContent() {
          Text('购物车内容')
        }
        .tabBar(this.myBuilder(0, $r('app.media.home'), '首页'))

        TabContent() {
          Text('增加内容')
        }.tabBar(this.centerBuilder())

        TabContent() {
          Text('我的内容')
        }
        .tabBar(this.myBuilder(2, $r('app.media.gwc'), '购物车'))
      }
      .barPosition(BarPosition.End)
      .onChange((index:number) => {
        this.selectIndex = index
      })
    }
  }
}