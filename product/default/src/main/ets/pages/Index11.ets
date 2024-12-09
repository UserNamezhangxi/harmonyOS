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
