import { CommonData } from './CommData'
import { createCommonData } from './utils'

@Component
struct header {
  @Prop isNewest: boolean = false
  @Prop itemObjList: CommonData[]
  onSort = (type: number) => {}

  build() {
    Row() {
      Text('全部评论').fontSize(24).fontWeight(FontWeight.Bold).padding(10)
      Row() {
        Button('最新')
          .backgroundColor(this.isNewest ? Color.Transparent : Color.White)
          .fontColor(Color.Black)
          .onClick(() => {
            this.isNewest = false;
            this.onSort(0)
          })
          .stateEffect(false)
        Button('最热')
          .backgroundColor(this.isNewest ? Color.White : Color.Transparent)
          .fontColor(Color.Black)
          .onClick(() => {
            this.isNewest = true;
            this.onSort(1)
          })
          .stateEffect(false)
      }
      .padding(1)
      .margin({ right: 10 })
      .backgroundColor('#ddd')
      .height(40)
      .borderRadius(20)
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .width('100%')
  }
}

@Component
struct ListItemView {
  @ObjectLink itemObj: CommonData

  build() {
    Column() {
      Row({ space: 10 }) {
        Image(this.itemObj.avatar).width(26).borderRadius(13)
        Text(this.itemObj.name).fontSize(14).fontColor('#999999')
        Image(this.itemObj.levelIcon).width(22)

      }
      .padding(10)
      .width('100%')
      .onClick(() => {
        AlertDialog.show({
          message: this.itemObj.lv.toString()
        })
      })

      // 评论内容
      Text(this.itemObj.common).margin({ left: 46 })

      // 时间和点赞
      Row() {
        Text(this.itemObj.commonTime).fontColor(Color.Grey).fontSize(14)
        Row() {
          Image($r('app.media.like')).width(20).fillColor(this.itemObj.isLike ? Color.Brown : Color.Grey)
          Blank()
          Text(this.itemObj.likeNumber.toString())
            .fontSize(14)
            .fontColor(this.itemObj.isLike ? Color.Brown : Color.Grey)
        }
        .onClick(() => {
          this.itemObj.isLike = !this.itemObj.isLike
          this.itemObj.likeNumber = this.itemObj.isLike ? this.itemObj.likeNumber + 1 : this.itemObj.likeNumber - 1
        })
      }
      .width('80%')
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({
        left: 46,
        top: 16,
        right: 10
      })
    }.width('100%').alignItems(HorizontalAlign.Start)
  }
}

@Component
struct bottom {
  @Prop msg:string = ''
  onSubmit= (content:string) => {}

  build() {
    Row({ space: 10 }) {
      Row() {
        Image($r('app.media.edit')).width(14)
        TextInput({
          placeholder: '写评论...',
          text: $$this.msg // 和输入框双向绑定
        }).backgroundColor(Color.Transparent)
          .onSubmit(()=>{
            this.onSubmit(this.msg)
          })
      }
      .padding({
        left: 10
      })
      .height(40)
      .backgroundColor('#eee')
      .layoutWeight(1)
      .borderRadius(20)

      Row({ space: 6 }) {
        Image($r('app.media.like')).width(30).fillColor('#AAA')
        Image($r('app.media.start')).width(24).fillColor('#AAA')
      }
      .margin({
        right: 10
      })
    }
    .padding({ left: 10 })
    .width('100%')
  }
}


@Entry
@Component
struct Index {
  @State commonList: CommonData[] = createCommonData()

  handleSort(type: number) {
    if (type == 0) {
      this.commonList.sort((a, b) => {
        // 按照时间戳排序
        return b.commonTimeStamp - a.commonTimeStamp
      })
    } else {
      this.commonList.sort((a, b) => {
        // 按照时间戳排序
        return b.likeNumber - a.likeNumber
      })
    }
  }

  onSubmitComment(msg:string) {
    const val:CommonData = new CommonData('https://i0.hdslb.com/bfs/face/member/noface.jpg','我',0, msg, new Date().getTime()/1000,0, false)
    this.commonList = [val, ...this.commonList]
  }

  aboutToAppear(): void {
    this.handleSort(0) // 默认按照最新排序
  }

  build() {
    Column({ space: 10 }) {
      header({
        onSort: (type: number) => {
          this.handleSort(type)
        }
      })
      List() {
        ForEach(this.commonList, (item: CommonData, index) => {
          ListItem() {
            ListItemView({
              itemObj: item
            })
          }
        })
      }
      .layoutWeight(1)

      bottom({
        onSubmit:(msg:string) => {
          this.onSubmitComment(msg)
        }
      })
    }
    .width('100%')
    .height('100%')
  }
}
