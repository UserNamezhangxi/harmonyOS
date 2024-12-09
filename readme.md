鸿蒙组件

# Badge: 角标用法

```js
@Entry
@Component
struct Index {
  build() {
    Badge({
      count:1, // 角标数值
      position:BadgePosition.RightTop, // 角标位置
      style:{
        fontSize:12, // 文字大小
        badgeSize:16, // 圆形大小
        badgeColor:Color.Blue // 背景色
      }
    }) {
      Image($r('app.media.jd_logo')).width(50)
    }
  }
}
```

# Grid 布局

```json
@Entry
@Component
struct Index {
  build() {
    Column() {
      Grid() {
        ForEach([1,2,3,4,5,6,7,8], (item:number, index:number) => {
          GridItem() {
            Text('a' + item)
          }.backgroundColor(Color.Pink)
        })
      }
      .width('100%')
      .columnsTemplate('1fr 1fr 1fr 1fr')
      .rowsTemplate('1fr 1fr')
      .height(300)
      .rowsGap(3)
      .columnsGap(3)
      Button('立即抽卡')
    }
  }
}
```

# 抽生肖卡 综合案例

```js
// 定义接口
interface ImageCount {
  url: string
  count: number
}


@Entry
@Component
struct Index {
  @State images: ImageCount[] = [
    { url: 'app.media.bg_00', count: 0 },
    { url: 'app.media.bg_01', count: 0 },
    { url: 'app.media.bg_02', count: 0 },
    { url: 'app.media.bg_03', count: 0 },
    { url: 'app.media.bg_04', count: 0 },
    { url: 'app.media.bg_05', count: 0 }
  ]
  @State phoneArr: string[] = ['app.media.phone0', 'app.media.phone1', 'app.media.phone2']
  @State randomIndex: number = 0 // 点击立即抽卡随机出一个卡片
  @State maskOpacity: number = 0 // 控制抽到卡片的透明度
  @State maskZIndex: number = -1 // 控制卡片层级
  @State imageScaleX: number = 0 // 遮罩层图片缩放X，Y
  @State imageScaleY: number = 0
  @State phone: string = ''
  @State isGet: boolean = false // 是否抽中6个卡片（大奖）

  build() {
    Stack() {
      Column() {
        Grid() {
          ForEach(this.images, (item: ImageCount, index: number) => {
            GridItem() {
              Badge({
                position: BadgePosition.RightTop,
                count: item.count,
                style: {
                  fontSize: 12, // 文字大小
                  badgeSize: 16, // 圆形大小
                  badgeColor: Color.Red // 背景色
                }
              }) {
                Image(item.count > 0 ? $r(item.url) : $r('app.media.bg'))
                  .padding(5)
                  .borderRadius(5)
                  .backgroundColor('#EEEEEE')
              }
            }.padding(4)
          })
        }
        .width('100%')
        .columnsTemplate('1fr 1fr 1fr')
        .rowsTemplate('1fr 1fr')
        .height(300)
        .rowsGap(3)
        .columnsGap(3)

        Button('立即抽卡')
          .margin(10)
          .width('50%')
          .backgroundColor(Color.Brown)
          .onClick(() => {
            this.randomIndex = Math.floor(Math.random() * 6)
            this.maskOpacity = 1
            this.maskZIndex = 1

            this.imageScaleX = 1
            this.imageScaleY = 1

            this.images[this.randomIndex] = {
              url: 'app.media.bg_0' + this.randomIndex, count: this.images[this.randomIndex].count + 1
            }
          })
      }.width('100%')

      Column({ space: 20 }) {
        Text('获得生肖卡').fontSize(20).fontColor(Color.White).margin(20)
        Image($r(this.images[this.randomIndex].url))
          .width(200)
          .height(320)
          .borderRadius(10)
          .scale({
            x: this.imageScaleX,
            y: this.imageScaleY
          })
          .animation({
            duration: 500
          })
        Button('开心收下')
          .backgroundColor(Color.Transparent)
          .border({
            width: 1,
            color: '#ffffff'
          })
          .width('50%')
          .margin(30)
          .onClick(() => {
            this.maskZIndex = -1
            this.maskOpacity = 0

            this.imageScaleX = 0
            this.imageScaleY = 0

            // 收下卡片后判断是否集齐6张卡
            let num = this.images.findIndex((item: ImageCount, index: number) => {
              return item.count == 0
            })
            this.isGet = num == -1
            console.log('isget ', this.isGet)
            if (this.isGet) {
              let randomPhoneIndex: number = Math.floor(Math.random() * 3)
              this.phone = this.phoneArr[randomPhoneIndex]
            }
          })
      }
      .backgroundColor('#F8000000')
      .width('100%')
      .height('100%')
      .zIndex(this.maskZIndex)
      .justifyContent(FlexAlign.Center)
      .opacity(this.maskOpacity)
      .animation({
        duration: 200 // 增加动画
      })

      // 抽到手机
      if (this.isGet) {
        Column({ space: 20 }) {
          Text('恭喜抽中手机了').fontSize(20).fontColor(Color.White).margin(20)
          Image($r(this.phone))
            .width(200)
            .height(320)
            .borderRadius(10)
          Button('在来一次')
            .backgroundColor(Color.Transparent)
            .border({
              width: 1,
              color: '#ffffff'
            })
            .width('50%')
            .margin(30)
            .onClick(() => {
              this.maskZIndex = -1
              this.maskOpacity = 0

              this.imageScaleX = 0
              this.imageScaleY = 0

              this.isGet = false

              this.images = [
                { url: 'app.media.bg_00', count: 0 },
                { url: 'app.media.bg_01', count: 0 },
                { url: 'app.media.bg_02', count: 0 },
                { url: 'app.media.bg_03', count: 0 },
                { url: 'app.media.bg_04', count: 0 },
                { url: 'app.media.bg_05', count: 0 }
              ]
            })
        }
        .backgroundColor('#F8000000')
        .width('100%')
        .height('100%')
        .zIndex(22)
        .justifyContent(FlexAlign.Center)
      }
    }
  }
}
```

# Swiper 组件

```js

@Entry
@Component
struct Index {
  @State reviewVotes: number = 1;
  @State myColor:string = '#ffffff'
  @State isCheck:boolean = false
  build() {
    Column() {
      Swiper() {
        Image($r('app.media.phone2'))
        Image($r('app.media.phone1'))
        Image($r('app.media.phone0'))
      }
      .width('100%')
      .height(300)
      .loop(true)
      .autoPlay(true)
      .interval(3000)
      .vertical(false)
      .aspectRatio(1) // 不同手机适配相同的宽高比例
      // .indicator(true)
      .indicator(Indicator.dot().selectedItemWidth(30).itemWidth(15).color(Color.Gray))
    }
  }
}
```

# 样式 事件 公共代码抽取

```js
@Extend(Text)
function textFn() {
  .fontSize(20)
  .fontColor(Color.Black)
  .fontWeight(700)
}

@Extend(Text)
function bannerItem(msg: string, color: ResourceColor) {
  .fontSize(20)
  .fontColor(Color.Black)
  .fontWeight(700)
  .backgroundColor(color)
  .onClick(() => {
    AlertDialog.show({
      message: msg
    })
  })
}


// 不支持传递参数
@Styles
function commonStyle() {
  .width(100)
  .height(100)
}

@Builder
function navItem(imgAddr:ResourceStr, name:string) {
  Column() {
    Image(imgAddr).width(50)
    Text(name)
  }
}


@Entry
@Component
struct Index {
  @State myColor: ResourceColor = Color.Pink

  // 如果组件内引用了this 的参数，那么需要定义在组件内部
  @Styles
  setBg() {
    .backgroundColor(this.myColor)
    .onClick(() => {
      this.myColor = Color.Orange
    })
  }

  @State reviewVotes: number = 1
  @State isCheck: boolean = false

  build() {
    Column() {
      Text('@Extend 扩展组件（事件、样式）')
        .textFn() // 相当于抽取公共样式

      Swiper() {
        Text('1').bannerItem('轮播图1号', Color.Brown)
        Text('2').bannerItem('轮播图2号', Color.Gray)
        Text('3').bannerItem('轮播图3号', Color.Green)
      }
      .width('100%')
      .height(100)
      .loop(true)
      .autoPlay(true)
      .interval(3000)
      .vertical(false)
      .aspectRatio(2) // 不同手机适配相同的宽高比例
      // .indicator(true)
      .indicator(Indicator.dot().selectedItemWidth(30).itemWidth(15).color(Color.Grey))

      Column({ space: 10 }) {
        Text('@Style')
          .commonStyle() // 样式抽取
          .setBg()       // 组件内样式抽取
        Column()
          .commonStyle()
          .setBg()
        Button()
          .commonStyle()
          .setBg()
      }

      Row({space:10}) {
        navItem($r('app.media.startIcon'),'菜鸟') // 抽取相同的 组件
        navItem($r('app.media.startIcon'),'青菜')
        navItem($r('app.media.startIcon'),'鸟叔')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceAround)
    }
  }
}
```

# Scroll 组件

```js
@Entry
@Component
struct Index {
  myScroller: Scroller = new Scroller()
  @State currentOffset: number = 0

  build() {
    Column() {
      Scroll(this.myScroller) {
        Column({ space: 10 }) {
          ForEach([1, 2, 3, 4, 5, 6], (item: number, index: number) => {
            Text(item + '').backgroundColor(Color.Pink).margin(20).width('100%').height(60)
          })
        }
      }
      .width('100%')
      .height(300)
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Off)
      .scrollBarColor('#ff0000')
      .scrollBarWidth(10)
      .edgeEffect(EdgeEffect.Spring)

      Button('返回顶部').margin(20).onClick((event: ClickEvent) => {
        this.myScroller.scrollEdge(Edge.Top)
      })
      Button('获取已经滚动的距离').margin(20).onClick((event: ClickEvent) => {
        this.currentOffset = this.myScroller.currentOffset().yOffset
        AlertDialog.show({
          title:"滚动距离",
          message:"当前滚动距离 " + this.currentOffset
        })
      })
      Button('返回指定位置').margin(20).onClick((event: ClickEvent) => {
        this.myScroller.scrollTo({
          yOffset:120,
          xOffset:0
        })
      })
    }
  }
}
```

# Tabbar 组件

```js
@Entry
@Component
struct Index {

  @State titles:string[] = ['首页','同城','关注','大学','娱乐','国产','动画','飞机','交通','政治','科技']
  build() {
    Column() {
      Tabs() {
        ForEach(this.titles, (item:string, index:number) => {
          TabContent() {
            Text(`${item}内容`).fontSize(16)
          }
          .tabBar(item)
        })
      }
      .barMode(BarMode.Scrollable)

    }
    .width('100%')
    .height('100%')
    .padding(10)
    .backgroundImage($r('app.media.jd_bg'))
    .backgroundImageSize(ImageSize.Cover)
  }
}
```

```js
import image from '@ohos.multimedia.image'

@Entry
@Component
struct Index {

  @State selectIndex:number = 0

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
      .onChange((index:number) => {
        this.selectIndex = index
      })
    }
  }
}
```

# 类的初始化

```js
class Food {
  name:string = '西红柿'
  price?:number

  // 静态对象
  static version:string = 'v2.3.0'

  constructor(name:string, price:number) {
    this.name = name
    this.price = price
  }

  // 类方法
  sayHi(yourName:string):void {
    console.log('tag',`你好${yourName},我是 ${this.name}`)
  }

  // 静态方法
  static getRandom():number {
    return Math.floor(Math.random() * 10)
  }

}

let food:Food = new Food('南瓜',2.5)
// food.name = '黄瓜'
// food.price = 2.3
console.log('food',food.name + ',price ' + food?.price)
food.sayHi('芹菜')
let random:number = Food.getRandom()
console.log('tag','random ' + random + ', version ' + Food.version)
```

# 类的继承 构造

```js

class Person {
  name:string = ''
  age:number = 0
  readonly sex = 1 // 只读的 修饰符 readonly(final)、 private public protected  和java 一致  

  constructor(name:string, age:number) {
    this.name = name
    this.age = age
  }
  
  sayHi(yName:string) {
    console.log('tag',`你好${yName},我是 ${this.name}`)
  }
}


class Student extends Person {
  grade:number = 1 // 1年级

  constructor(name:string, age:number,grade:number) {
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

let student:Student  = new Student('小明',10, 3)
let teacher:Teacher  = new Teacher('费老师',29)
student.study()
teacher.work()
console.log('student',`姓名：${student.name},年龄：${student.age},年级：${student.grade}`)
console.log('student',`姓名：${student.name},年龄：${student.age}`)
```

# instanceof 使用

```js
let tem:string[] = []

console.log('tag', typeof 111)
console.log('tag', typeof true)
console.log('tag', typeof '111')

console.log('tag', student instanceof Person)
console.log('tag', tem instanceof Array)

```

# 不定参数，展开运算符

```js
// 不定参数
function add (a:number,b:number, ...args:number[]):number {
  let sum = a + b
  for (let n of args) {
    sum += n
  }
  return sum;
}

console.log('tag',add(1,2,3))
console.log('tag',add(1,2,3,4,5))

// 展开运算符 ,在ArkTs中，展开运算符只能用在数组合并
const arr2:number[] = [1,2,3,4]
const arr3:number[] = [5,6,7,8]

const totalArr = [...arr2,...arr3]
console.log('tag',totalArr)
```

# 接口继承和实现

```js
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
```

# 泛型

```js
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
```

# 导出

```js
utils.ets 文件中

export let name1: string = '刘备'
export let price: number = 9.9
export let sayHi = () => {
  console.log('tag','你好 hello')
}

或者 
let name1: string = '刘备'
let price: number = 9.9
let sayHi = () => {
  console.log('tag', '你好 hello')
}

export {
  name1,
  price,
  sayHi
}

在其他类进行引用

import {name1, price, sayHi} from './utils'
console.log('import ','name1 ' + name1 + ', price ' + price)
sayHi()


备注：也可以默认导出一个值
export default name1

导出全部
import * as Utils from './utils'
console.log('import ','Utils ' + Utils.name1)
console.log('import ','Utils ' + Utils.price)
Utils.sayHi()


```

#  自定义组件

```js
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
```

# 组件属性-通用组件属性方法

```js
import {HelloComp} from './utils'
@Entry
@Component
struct Index {
  build() {
    Column() {
      HelloComp().width(300).height(200).onClick(()=>{
        AlertDialog.show({
          message:'msggggggg'
        })
      }).backgroundColor(Color.Pink)
    }
  }
}


对应的utils中

@Preview    // 可预览
@Component
struct HelloComp {
  build() {
    Row() {
      Text('自定义组件')
      Button('按钮')
    }
    .width(200)
    .height(100)
    .padding(20)
    .backgroundColor(Color.Brown)
  }
}

export {
  HelloComp
}
```

# 自定义变量和成员函数

```js
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

```

# @BuilderParam 构建函数

```js
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

```

# @BuilderParam 传递UI 组件参数

```js
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

  @BuilderParam MyBuilder: ()=> void = this.defaultBuilder
  @Builder
  defaultBuilder() {
    Text('默认内容')
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
      Row() {
        this.MyBuilder()
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
      }) {
        Text('订单相关内容') // 尾随闭包中传入
      }
      MyPannel({
        title:'小米有品众筹',
        extra:'7款产品众筹中 >',
        getMore:()=>{
          AlertDialog.show({
            message:'7款产品众筹中'
          })
        }
      }) {
        Button('按钮') // 尾随闭包中传入
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#ccc')
  }
}

```

# 多个@BuilderParam 传递UI

```js
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

```

# 变量修饰符

![](image\9.png)

# @Prop 子组件改父组件内容

```js
@Component
struct SonCom {
  @Prop carName: string  // 子组件的数组

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

```

# @Link 关键字使用

```js
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

```

# @provider @Consume 使用 双向绑定

```js
@Component
struct GrandSonCom {
  @Consume themeColor:string
  build() {
    Column() {
      Text('我是孙子 ' + this.themeColor)
    }.backgroundColor(Color.Green)
    .width('40%')
    .height(100)
    .margin({top:30})
    .onClick(() => {
      this.themeColor = 'red'
    })

  }
}

@Component
struct ChildCom {
  build() {
    Column() {
      Text('我是儿子')
      GrandSonCom()
    }
    .backgroundColor(Color.Pink)
      .width('80%')
      .height(200)
  }
}


@Entry
@Component
struct Index {
  @Provide themeColor:string = 'yellow'
  build() {
    Column({ space: 10 }) {
      Text('父组件' + this.themeColor )
      ChildCom()
      ChildCom()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.Gray)
  }
}
```

# @Observed - @ObjectLink

```js
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
```

# 评论列表功能

```js
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




function timeAgo(timestamp: number): string {
  const now = new Date().getTime() / 1000
  const timeDiff = (now - timestamp);

  if (timeDiff < 3) {
    return '刚刚';
  } else if (timeDiff < 60) {
    return `${Math.floor(timeDiff)}秒前`;
  } else if (timeDiff < 3600) {
    return `${Math.floor(timeDiff / 60)}分钟前`;
  } else if (timeDiff < 24 * 3600) {
    return `${Math.floor(timeDiff / 3600)}小时前`;
  } else if (timeDiff < 7 * 24 * 3600) {
    return `${Math.floor(timeDiff / (24 * 3600))}天前`;
  } else if (timeDiff < 30 * 24 * 3600) {
    return `${Math.floor(timeDiff / (7 * 24 * 3600))}周前`;
  } else if (timeDiff < 365 * 24 * 3600) {
    return `${Math.floor(timeDiff / (30 * 24 * 3600))}月前`;
  } else {
    return `${Math.floor(timeDiff / (365 * 24 * 3600))}年前`;
  }
}

function convertLevelIcon(level:number):Resource {
  let result = new Array<Resource>()
  result = [
    $r('app.media.lv0'),
    $r('app.media.lv1'),
    $r('app.media.lv2'),
    $r('app.media.lv3'),
    $r('app.media.lv4'),
    $r('app.media.lv5'),
    $r('app.media.lv6')
  ]
  return result[level]

}

const createCommonData = ():CommonData[] => {
  let result = new Array<CommonData>()
  result = [
    new CommonData('https://i0.hdslb.com/bfs/face/3480f17dc92441ae6b5b75a79ea3f004c631a475.jpg','丶可惜没如果丶',1,"本次课程是纯NEXT星河版，不包含4.0哈，也是很对于零基础同学设计，持续更新中，小伙伴们赶紧学起来哈~~~~",1732972719, 20, false),
    new CommonData('https://i2.hdslb.com/bfs/face/bdda531a646c67a3174d6391c23d2e96af09c759.jpg','黑马pink讲前端',2, "上次4.的学习0就是因为nodejs版本问题从安装到卸载[doge]，原来可以同时安装两个版本的nodejs[妙啊]",1728975055, 1, true),
    new CommonData('https://i2.hdslb.com/bfs/face/44747c98a414ae8c770316af98c909f3388eee76.jpg','阿宇鸭丶',3,"学完了，直接java转鸿蒙[doge]",1732256371, 55, false),
    new CommonData('https://i1.hdslb.com/bfs/face/4a40d7d08203d3505477384d4d03cd26f3a50765.jpg','昵称掉沟里了',4,"代码仓库地址？",1729494414, 21, true),
    new CommonData('https://i0.hdslb.com/bfs/face/ee7a0b228522899dcbbf891d14aa0031a3d6dd37.jpg','灰灰是只猫猫咪',5,"完全一样的源码，为什么抖音只能采集第一页，屏幕完全不滚动的",1731910529, 20, false),
    new CommonData('https://i0.hdslb.com/bfs/face/2e31fadddf824fff4ab2b4f2bf174a0a34bffe76.jpg','Python大本营',5,"我也遇到同样的问题了，在浏览器下滑一下才能采集下一页",1733473790, 59, true),
    new CommonData('https://i0.hdslb.com/bfs/face/2e31fadddf824fff4ab2b4f2bf174a0a34bffe76.jpg','高总高总',6,"为什么我的csv是乱码啊，在pc里打开时正常的，找到文件直接打开就是乱码",1732437425, 29, false),
    new CommonData('https://i0.hdslb.com/bfs/face/2e31fadddf824fff4ab2b4f2bf174a0a34bffe76.jpg','霸波尔奔笨',5,"已三连，求源代码",1729855488, 2, false),
    new CommonData('https://i0.hdslb.com/bfs/face/d8e715e079ded37f6ff8e7f8f7660e401361b5ba.jpg','王朝窥密者',4,"下滑分翻页不生效怎么解决啊[笑哭]",1732759975, 10, true),
    new CommonData('https://i0.hdslb.com/bfs/face/ff1a90c3310df0e112a6f09a70a1bd5bd8f19e0e.jpg','泰同学',5, "三联求源码",1729439164, 10, false),
    new CommonData('https://i0.hdslb.com/bfs/face/ce1ab3cfc33c07ac64eac8f5aa55827e14a1ad76.jpg','Vecchio_zhu',4,"需要源码的小可爱可以关注并下方留言【已点赞】 [给心心][给心心][给心心]我会依次发送噢~[打call][打call][打call]",1725455853, 12, true),
    new CommonData('https://i0.hdslb.com/bfs/face/a0180f60bde54343a85633f9346d41ece99ed1d0.jpg','剑武书生在梅边',5,"亲测有效，大神，开心收下有没有解决？",1730949921, 2, true),
    new CommonData('https://i0.hdslb.com/bfs/face/d79ae1cc7939b089eb680da4bab2bcca1e8bb212.jpg','动须相应-',6,"还没学，已经拿到《HarmonyOS 应用开发者高级认证》证书了[吃瓜]",1732537633, 9, false),
    new CommonData('https://i0.hdslb.com/bfs/face/a71b4dd6647ddf0c813bcf74e062edab9224cb0e.jpg','大姐大街打劫大捷',1,"是不是DevEco Studio需要的nodejs版本，支持NEXT的版本需要18.x，而现在的这些版本16.x？是不是有这个说法？",1733300413, 20, true),
    new CommonData('https://i0.hdslb.com/bfs/face/d8e715e079ded37f6ff8e7f8f7660e401361b5ba.jpg','孤独下雨天',1,"冲！[奋斗]", 1732335271, 120, false),
  ]
  return result;
}


export {
  timeAgo,
  convertLevelIcon,
  createCommonData
}


import { timeAgo , convertLevelIcon} from './utils'

@Observed  // 使用 @Observed + @ObjectLink
export class CommonData {
  avatar:string = ''
  name:string  = ''
  lv:number = 0
  common:string = ''
  commonTimeStamp:number
  commonTime:string
  likeNumber:number
  isLike:boolean
  levelIcon:Resource

  constructor(avatar:string, name:string, lv:number, common:string, commonTimeStamp:number, likeNumber:number, isLike:boolean ) {
    this.avatar = avatar
    this.name = name
    this.lv = lv
    this.levelIcon = convertLevelIcon(lv)
    this.common = common
    this.commonTimeStamp = commonTimeStamp
    this.commonTime = timeAgo(commonTimeStamp)
    this.likeNumber = likeNumber
    this.isLike = isLike
  }

}


```

# 路由 +页面/組件生命周期

```js
import { router } from '@kit.ArkUI'

@Entry
@Component
struct Index {
  build() {
    Column({ space: 10 }) {
      Text('首页')
      Button('跳转购物车').onClick(() =>{
        router.pushUrl({
          url:'pages/Page1',
          // 传递参数
          params:{
            name:'zx',
            age:12,
            hobby:'AAA'
          }
        })
      })
      Button('跳转个人中心').onClick(() =>{
        // replaceUrl 跳转销毁当前页面
        router.pushUrl({
          url:'pages/Page2'
        })
      })
      Button('获取路由栈数量').onClick(()=>{
        AlertDialog.show({
          message:router.getLength()
        })
      })
    }
    .width('100%')
    .height('100%')
  }
}

=============================Page1.ets============================================

import { router } from '@kit.ArkUI';
import { IPerson } from './utils';

@Component
struct MyComm {
  // 组件声明周期
  aboutToAppear(): void {
    console.log('MyComm','aboutToAppear');
  }

  // 组件声明周期
  aboutToDisappear(): void {
    console.log('MyComm','aboutToDisappear');
  }

  build() {
    Text('子组件')
  }
}


@Entry
@Component
struct Page1 {
  @State message: string = '购物车';
  @State user:IPerson = {
    age:12,
    name:'abc',
    hobby:'ccc'
  }

  aboutToAppear(): void {
    console.log('Page1','aboutToAppear');
    console.log(JSON.stringify(router.getParams()));
    this.user = router.getParams() as IPerson
    console.log(this.user.name);
  }

  // 页面特有
  onPageHide(): void {
    console.log('Page1','onPageHide');
  }

  // 页面特有
  onBackPress(): boolean | void {
    console.log('Page1','onBackPress');
  }
  
  // 页面特有
  onPageShow(): void {
    console.log('Page1','onPageShow');
  }
  
  aboutToDisappear(): void {
    console.log('Page1','aboutToDisappear');
  }

  build() {
    Column() {
      Text(this.message + 'user:'+ JSON.stringify(this.user))
        .fontSize(30)
      Button('返回').onClick(()=>{
        router.back()
      })
      Button('获取路由栈数量').onClick(()=>{
        AlertDialog.show({
          message:router.getLength()
        })
      })
      MyComm()
    }
    .height('100%')
    .width('100%')
  }
}

```

![](image\11.png)

![](image\10.png)



# Stage 模型 - app.json5 配置应用

![](image\1.png)

![](image\2.png)

Stage模型UiAbility

1、modules 目录新建 ability(类似窗口概念), pages新建页面， 在新建的ability中修改onWindowStateCreate 中修改默认启动页面

2、配置原本abality 中的这个代码到另一个默认启动的Ability中，类似android里的启动默认首页设置

```
"exported": true,
"skills": [
  {
    "entities": [
      "entity.system.home"
    ],
    "actions": [
      "action.system.home"
    ]
  }
]
```

# Abaility 生命周期

![](image\3.png)



# Ability模块之间的关系

![](image\6.png)



# 启动另一个Ability

![](image\4.png)

context 获取

![](image\5.png)



# 拉起另一个模块的 ability

![](image\7.png)

![](image\8.png)
