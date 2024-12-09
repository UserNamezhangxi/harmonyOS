import * as Utils from './utils'
import {name1, price, sayHi} from './utils'
console.log('import ','name1 ' + name1 + ', price ' + price)
sayHi()

console.log('import ','Utils ' + Utils.name1)
console.log('import ','Utils ' + Utils.price)
Utils.sayHi()

class Food {
  name: string = '西红柿'
  price?: number
  // 静态对象
  static version: string = 'v2.3.0'

  constructor(name: string, price: number) {
    this.name = name
    this.price = price
  }

  // 类方法
  sayHi(yourName: string): void {
    console.log('tag', `你好${yourName},我是 ${this.name}`)
  }

  // 静态方法
  static getRandom(): number {
    return Math.floor(Math.random() * 10)
  }
}

let food: Food = new Food('南瓜', 2.5)
// food.name = '黄瓜'
// food.price = 2.3
console.log('food', food.name + ',price ' + food?.price)
food.sayHi('芹菜')
let random: number = Food.getRandom()
console.log('tag', 'random ' + random + ', version ' + Food.version)


class Person {
  name: string = ''
  age: number = 0
  readonly sex = 1 // 只读的 修饰符 readonly(final)、 private public protected  和java 一致

  constructor(name: string, age: number) {
    this.name = name
    this.age = age
  }

  sayHi(yName: string) {
    console.log('tag', `你好${yName},我是 ${this.name}`)
  }
}


class Student extends Person {
  grade: number = 1 // 1年级

  constructor(name: string, age: number, grade: number) {
    super(name, age) // super 父类构造
    this.grade = grade // 增加自己的构造参数
  }

  study() {
    super.sayHi('小红')
    console.log('tag', '学生学习')
  }
}

class Teacher extends Person {
  work() {
    console.log('tag', '老师工作教书育人')
  }
}

let student: Student = new Student('小明', 10, 3)
let teacher: Teacher = new Teacher('费老师', 29)
student.study()
teacher.work()

student.sex

console.log('student', `姓名：${student.name},年龄：${student.age},年级：${student.grade}`)
console.log('student', `姓名：${student.name},年龄：${student.age}`)


let tem: string[] = []

console.log('tag', typeof 111)
console.log('tag', typeof true)
console.log('tag', typeof '111')

console.log('tag', student instanceof Person)
console.log('tag', tem instanceof Array)


// 不定参数
function add(a: number, b: number, ...args: number[]): number {
  let sum = a + b
  for (let n of args) {
    sum += n
  }
  return sum;
}

console.log('tag', add(1, 2, 3))
console.log('tag', add(1, 2, 3, 4, 5))

// 展开运算符 ,在ArkTs中，展开运算符只能用在数组合并
const arr2: number[] = [1, 2, 3, 4]
const arr3: number[] = [5, 6, 7, 8]

const totalArr = [...arr2, ...arr3]
console.log('tag', totalArr)


// 接口的继承
interface IAnimal {
  name: string
  age: number
}

interface IDog extends IAnimal {
  color: string
  walk: () => void // 相当于定义抽象方法
}

let dog: IDog = {
  name: 'xx',
  age: 10,
  color: 'white',

  // 接口实现
  walk() {

  }
}

// 泛型 广泛类型
function funName<T> (val:T): T {
  return val
}

funName<number>(12)
funName<boolean>(true)
funName<string>('1')
funName<[]>([])

function getLen<T>(arr:T[]):number {
  return arr.length
}

function getLast<T>(arr:T[]):T {
  return arr[arr.length - 1]
}

function getLast1<T,A>(arr:T[],data:A):T {
  return arr[arr.length - 1]
}


@Entry
@Component
struct Index {
  @State titles: string[] = ['首页', '同城', '关注', '大学', '娱乐', '国产', '动画', '飞机', '交通', '政治', '科技']
  @State selectIndex: number = 0

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
      .onChange((index: number) => {
        this.selectIndex = index
      })
    }
  }
}