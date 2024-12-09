@Component
struct SonCom {
  // 1.自定义构建函数
  @BuilderParam MyBuilder: () => void = this.defaultBuilder

  @Builder
  defaultBuilder() {
    Text('默认内容')
  }


  build() {
    Column() {
      // 2. 使用构建函数 构建结构
      this.MyBuilder()
    }
  }
}

@Entry
@Component
struct Index {
  build() {
    Column({space:10}) {
      SonCom() {
        // 传递的内容作为 MyBuilder 进行展示
        Button('传递进来的结构')
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#ccc')
  }
}
