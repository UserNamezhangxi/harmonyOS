interface Person {
  name:string
  age:number
}

@Component
struct SonCom {
  @Link count:number
  @Link person:Person
  build() {
    Column() {
      Text('我是子组件' + JSON.stringify(this.person))
      Text(this.count.toString())
      Button('修改数据').onClick((event: ClickEvent) => {
        this.count += 1
        this.person.age += 1
      })

    }.backgroundColor(Color.Pink)
  }
}


@Entry
@Component
struct Index {
  @State count:number = 0
  @State person:Person = {
    name:"zx",
    age:20
  }
  build() {
    Column({ space: 10 }) {
      Text('父组件' + JSON.stringify(this.person))
      Text(this.count.toString())
      Button('修改数据').onClick((event: ClickEvent) => {
        this.count += 1
      })
      SonCom({
        count:this.count,
        person:this.person
      })
    }
    .width('100%')
    .height('100%')
  }
}
