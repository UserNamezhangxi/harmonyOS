@Component
struct SonCom {
  @Prop carName: string  // 字组件的数组

  // 子组件更新父组件中的内容需要调用父组件中的方法进行修改，@Prop 子组件无权修改父组件内容
  changeCar = (car: string) => {
  }

  build() {
    Column() {
      Text(this.carName)
      Button('点击换车').onClick(() => {
        this.changeCar('OS')
      })
    }
  }
}

@Entry
@Component
struct Index {
  @State car: string = 'BMW'

  build() {
    Column({ space: 10 }) {
      Text(this.car)
      Button('点击换车 ').onClick(() => {
        this.car = 'os'
      })
      SonCom({
        carName: this.car,
        changeCar: (carName: string) => {
          this.car = carName
        }
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#ccc')
  }
}
