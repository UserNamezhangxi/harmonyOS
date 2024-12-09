// 注释消息
console.log('我说 ', 'hello word  ds sd ')

// 变量定义
let title: string = 'this is text message'
let price: number = 21.3
let isCheck: boolean = true

price = 33.3

console.log("tag","pirce " + price)

// 常量定义
const PI: number = 3.1512563

// 数组定义
let names: string[] = ['a', 'b', 'c', 'd', 'e']
console.log('数组',names)
console.log('数组',names[0])

function fn() {
  console.log('tag','abc')

}

fn()
fn()

function add(price:number, num:number) {
  return price * num
}
let apple = add(2, 2.3)
let banana = add(3, 2.3)
console.log('tag', 'apple ' + apple)
console.log('tag', 'banana ' + banana)

// 箭头函数
let addNumber = (num:number, num2:number) => {
  return num + num2
}

let resul = addNumber(1,1)
console.log('tag', '1+1 = ' + resul)

// 接口定义
interface Person {
  name:string
  age:number
  sex:boolean

  dance:() => void
  sing:(name:string) => void
}

let person: Person = {
  name: 'zhangxi',
  age: 33,
  sex: false,
  dance: (): void => {
    console.log('dance','跳舞')
  },
  sing: (songName : string): void => {
    console.log('dance','唱歌 ' + songName)
  }
}

console.log('tag',person.name)
console.log('tag',person.age)
console.log('tag',person.sex)
person.dance()
person.sing('爱的供养')


// 联合体
// 语法 let 变量名:类型1|类型2
let judge:number | string = 100
judge = 'A+'
console.log('tag,', '年终考试 ' + judge)

// 性别 男，女，保密
let gender :'man' | 'woman' | 'secret' = 'secret'

// 枚举
enum Colors {
  Red = '#ff0f29',
  Orange = '#ff7100',
  Green = '#30b30e'
}

let color: Colors = Colors.Red



@Entry
@Component
struct Index {
  @State message: string = 'World 1';

  build() {
    // 设置组件间的间距
    Column({space:10}) {
      Text('小说简介').height(40).width('100%').backgroundColor(Colors.Red).align(Alignment.Start).fontSize(24).fontWeight(FontWeight.Bold)
      Row() {
        Text('都市').width(50).backgroundColor(Color.Grey).align(Alignment.End)
        Text('生活').width(50).backgroundColor(Color.Pink)
        Text('情感').width(50).backgroundColor(Color.Green)
        Text('男频').width(50).backgroundColor(Color.Blue)
      }.width('100%')
      Text('文字溢出显示省略号,文字溢出显示省略号,文字溢出显示省略号,文字溢出显示省略号,')
        .width('100%')
        .lineHeight(50)
        .fontSize(30)
        .textOverflow({
          overflow: TextOverflow.Ellipsis
        })
        .maxLines(2)

      Image('https://www.baidu.com/img/PCfb_5bf082d29588c07f842ccde3f97243ea.png')
        .width(250)
        .height(100)
      Image($r('app.media.foreground'))
        .width(100)
        .height(100)

      TextInput({
        placeholder:"请输入账号"
      })

      TextInput({
        placeholder:"请输入密码"
      }).type(InputType.Password)

      Button('登录')
        .width(100)

      Row() {
        Text("刘备").margin(10) // 4 个方向都设置了 10
        Text("关羽").margin({
          left:10,
          top:10,
          right:10,
          bottom:10,
        }) // 4 个方向分别设置
        Text("张飞")
      }

      Text('边框设置').border({
        width: { left: 1, right: 2, top: 2 },
        color: { left: Color.Red, right: Color.Green },
        style: { left: BorderStyle.Dotted, right: BorderStyle.Solid }
      }).fontSize(26).padding(5)

      Text('单边框设置').border({
        width: 1,
        color: Color.Green,
        style: BorderStyle.Solid
      }).fontSize(26).padding(5)

      Text('圆角设置').fontSize(26).padding(10).backgroundColor(Color.Brown)
        .borderRadius({
          topLeft:5,topRight:5,bottomLeft:10,bottomRight:10
        })


    }

    .padding(10)
    .height('100%')
    .width('100%')
    .backgroundColor(Color.Pink)
  }
}