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
