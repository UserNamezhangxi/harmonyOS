import { router } from '@kit.ArkUI';
import {add,EmptyView} from 'common'
// 创建新实例并使用给定对象初始化
// let para: Record<string, number> = { 'PropA': 47 };
// let storage: LocalStorage = new LocalStorage(para);

// let storage = new LocalStorage();
// storage.setOrCreate('PropA', 48);

AppStorage.setOrCreate('PropA', 57);

let storage = LocalStorage.getShared();

@Component
struct MyComm {
  // @LocalStorageLink变量装饰器与LocalStorage中的'PropA'属性建立双向绑定
  @LocalStorageLink('param') storageLink: number = 1;
  @StorageLink('PropA') appStorageLinkLink: number = 99;

  build() {
    Column() {
      Text("子组件  localstorageLink ：" + this.storageLink.toString()).onClick(() => {
        this.storageLink = 100
      })

      Text("子组件 AppStorage ：" + this.appStorageLinkLink.toString()).onClick(() => {
        this.appStorageLinkLink = 10
      })
    }
  }
}


@Entry(storage)
@Component
struct Index {
  // @StorageLink变量装饰器与AppStorage配合使用
  // @LocalStorageLink与LocalStorage配合使用
  @LocalStorageLink('param') localStorageLink: number = 1;
  @StorageLink('PropA') appStorageLinkLink: number = 99;

  aboutToAppear(): void {
    console.log('zhangxi ',"value " + add(10,22))
  }

  build() {
    Column({ space: 10 }) {
      Text('LocalStorageLink ' + this.localStorageLink.toString()).fontSize(30)
      Text('StorageLink ' + this.appStorageLinkLink.toString()).fontSize(30)
      MyComm()
      Button('跳转').onClick(()=>{
        router.pushUrl({
          url : 'pages/Page3'
        })
      })
    }
    .width('100%')
    .height('100%')
  }
}
