interface IPerson {
  name:string
  age:number
  hobby:string
}

@Observed // 必须是class 才能使用
class Person implements IPerson {
  name: string
  age: number
  hobby: string

  constructor(config:IPerson) {
    this.name = config.name
    this.age = config.age
    this.hobby = config.hobby
  }
}

const getPersons = ():Person[] => {
  return [
    new Person({name:'aaa',age:1,hobby:'AAA'}),
    new Person({ name:'bbb',age:2,hobby:'BBB'}),
    new Person({ name:'ccc',age:3,hobby:'CCC'})
  ]
}

@Component
struct InfoItem {
  @ObjectLink info: Person
  // addAge = (): void => {}

  build() {
    ListItem() {
      Row() {
        Text('name:' + this.info.name)
        Text(' age:' + this.info.age)
        Blank()
        Button('点击修改数据').onClick(()=>{
          //this.addAge()
          // 可以在儿子直接更新 毕竟是link
          this.info.age++
        })
      } .width('80%')
    }
    .backgroundColor(Color.Pink)
    .width('100%')
    .padding(20)
  }
}

@Component
struct MyCom {
  @ObjectLink info:Person
  build() {
    Text(this.info.age.toString())
  }
}


@Entry
@Component
struct Index {

  @State perList:Person[] = getPersons()

  build() {
    Column({ space: 10 }) {
      // 属性更新的逻辑：当我们在@Observed 装饰的数据属性改变时候就会见听到，
      // 遍历依赖它的@ObjectLink 包装类 通知数据更新
      // 注意：@Entry 组件无法直接使用 @ObjectLink 需要包装一层
      // Text(this.perList[0].age.toString())
      // 需要包装一层
      MyCom({
        info:this.perList[0]
      })

      List({space:10}) {
        ForEach(this.perList, (item: Person, index) => {
          InfoItem({
            info: item,
            // addAge:()=>{
            //
            // }
          })
        })
      }

    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.Gray)
  }
}
