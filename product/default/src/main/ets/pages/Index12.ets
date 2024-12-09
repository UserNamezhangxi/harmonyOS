interface Car {
  name:string
}

interface Person {
  name:string
  car:Car
}


@Entry
@Component
struct Index {
  @State msg:string = 'helo wold'
  @State person:Person = {
    name:  'jack',
    car : {
      name:'bmw'
    }

  }
  build() {
    Column({space:10}) {
      Text(this.msg)
      Button('改msg').onClick(()=>{
        this.msg = "workldldld"
      })
      Text(JSON.stringify(this.person))
      Button('改person').onClick(() => {
        this.person.name = 'toy'
        this.person.car.name = 'train'
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#ccc')
  }
}
