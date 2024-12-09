import { router } from '@kit.ArkUI';
const storage = LocalStorage.getShared()

@Entry(storage)
@Component
struct Page3 {
  @State message: string = 'Hello World';
  @LocalStorageLink('param') propA :number = 1

  @StorageLink('PropA') appStorageLinkLink: number = 99;

  build() {
    Column() {
      Text(this.message + this.propA)
        .id('Page3HelloWorld')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })

      Text(this.message + this.appStorageLinkLink)
        .id('Page3HelloWorld1')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })

      Button('local storage add').onClick(()=>{
        this.propA ++
      })

      Button('app storage add').onClick(()=>{
        this.appStorageLinkLink ++
      })

      Button('back').onClick(() => {
        router.back()
      })
    }
    .height('100%')
    .width('100%')
  }
}