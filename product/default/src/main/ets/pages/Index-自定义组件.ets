
@Component
struct MyHeader {
  build() {
    Row() {
      Text('我是头部').width('100%').fontSize(26).padding(10)
    }.backgroundColor(Color.Green)
  }
}

@Component
struct MyCom {
  @State count:number = 1
  build() {
    Row() {
      Text(this.count.toString())
      Button('按钮').onClick(()=>{
        this.count = this.count+1
      })
    }
  }
}

@Component
struct MyMain {

  build() {
    Column() {
      ForEach(Array.from({ length:3 }), (item:number, index:number) => {
        MyCom()
      })
    }
    .width('100%')
    .backgroundColor(Color.Pink)
    .layoutWeight(1)
  }
}

@Component
struct MyFooter {
  build() {
    Row() {
      Text('我是尾部').width('100%').fontSize(26).padding(10)
    }.backgroundColor(Color.Green)
  }
}


@Entry
@Component
struct Index {
  build() {
    Column() {
      MyHeader()
      MyMain()
      MyFooter()
    }
  }
}