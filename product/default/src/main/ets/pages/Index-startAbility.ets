import { mediaquery } from '@kit.ArkUI';
import { common, UIAbility, Want } from '@kit.AbilityKit';

@Entry()
@Component
struct Index {

  @State datas:number[] = []
  @State index:number = 0

  build() {
    Column({ space: 10 }) {
      Text('备忘录页面')
      Button('添加备忘录').onClick(()=>{
        this.datas.push(this.index)

        let context = getContext(this) as common.UIAbilityContext
        let want:Want = {
          deviceId:"", // deviceId为空表示本设备
          bundleName: "com.example.myapplication",
          abilityName:'WpsAbility',
          moduleName:'default',  // moduleName非必选
          parameters: {
            instanceKey:`idx_${this.index++}`
          }
        }
        context.startAbility(want,(err) => {
          console.log('tag',"err " + err)
        })
      })
      ForEach(this.datas, (item:number, index:number) => {
        ListItem() {
          Row() {
            Image($r('app.media.startIcon')).width(30)
            Text(`item=${index}`)
          }.onClick(()=>{
            let context = getContext(this) as common.UIAbilityContext
            let want:Want = {
              deviceId:"", // deviceId为空表示本设备
              bundleName: "com.example.myapplication",
              abilityName:'WpsAbility',
              moduleName:'default',  // moduleName非必选
              parameters: {
                instanceKey:`idx_${index}`
              }
            }
            context.startAbility(want,(err) => {
              console.log('tag',"err " + err)
            })
          })
        }
      }, (item:number)=> `${item}`)
    }
    .width('100%')
    .height('100%')
  }
}
