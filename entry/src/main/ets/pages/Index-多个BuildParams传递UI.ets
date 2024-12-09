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

  // 多个自定义视图参数传递，使用 BuilderParam 创建参数让外部传递
  @BuilderParam tBuilder: ()=> void = this.tDefaultBuilder
  @BuilderParam cBuilder: ()=> void = this.cDefaultBuilder

  // 外部无法传递参数覆盖
  sayHi() {
    AlertDialog.show({
      message:"sayHi"
    })
  }

  @Builder
  tDefaultBuilder() {
    Text('默认内容 tttt')
  }

  @Builder
  cDefaultBuilder() {
    Text('默认内容 ccccc')
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
      Row({space:15}) {
        this.tBuilder()
        this.cBuilder()
      }.height(100)
    }
    .margin(10)
    .backgroundColor(Color.White)
    .padding(10).borderRadius(10)
  }
}


@Entry
@Component
struct Index {
  @Builder
  fTBuilder() {
    Text('我是titleBuilder')
  }

  @Builder
  fCBuilder() {
    Text('我是contentBuilder')
  }

  build() {
    Column({space:10}) {
      MyPannel({
        title:'我的订单',
        extra:'全部订单 >',
        tBuilder:this.fTBuilder,
        cBuilder:this.fCBuilder,
        getMore:()=>{
          AlertDialog.show({
            message:'全部订单'
          })
        },

      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#ccc')
  }
}
