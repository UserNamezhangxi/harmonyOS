import { router } from '@kit.ArkUI';
import { IPerson } from './utils';

@Component
struct MyComm {
  aboutToAppear(): void {
    console.log('MyComm','aboutToAppear');
  }

  onPageHide(): void {
    console.log('MyComm','onPageHide');
  }

  onBackPress(): boolean | void {
    console.log('MyComm','onBackPress'); // 这个没有执行
  }

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

  onPageShow(): void {
    console.log('Page1','onPageShow');
  }

  onPageHide(): void {
    console.log('Page1','onPageHide');
  }

  onBackPress(): boolean | void {
    console.log('Page1','onBackPress');
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

