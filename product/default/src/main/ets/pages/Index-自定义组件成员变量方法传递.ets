@Component
struct MyPannel {
  // 成员变量
  title:string ='默认大标题'
  extra:string='全部订单'
  // 成员变量 - 函数 - 可以外部传入
  getMore= () => {
    AlertDialog.show({
      message:'getMore'
    })
  }

  // 外部无法传递参数覆盖
  sayHi() {
    AlertDialog.show({
      message:"sayHi"
    })
  }

  build() {
    Column() {
      Row() {
        Text(this.title)
        Text(this.extra)
          .onClick(() => {
            this.getMore()
          })
      }
      .width('100%')
      .padding(10)
      .justifyContent(FlexAlign.SpaceBetween)

      Text('订单内容').width('100%').height(100).onClick(() => {
        this.sayHi()
      })
    }
    .margin(10)
    .backgroundColor(Color.White)
    .padding(10).borderRadius(10)
  }
}


@Entry
@Component
struct Index {
  build() {
    Column({space:10}) {
      MyPannel({
        title:'我的订单',
        extra:'全部订单 >',
        getMore:()=>{
          AlertDialog.show({
            message:'全部订单'
          })
        }
      })
      MyPannel({
        title:'小米有品众筹',
        extra:'7款产品众筹中 >',
        getMore:()=>{
          AlertDialog.show({
            message:'7款产品众筹中'
          })
        }
      })
    }
    .width('100%')
    .height('100%')

    .backgroundColor('#ccc')
  }
}
