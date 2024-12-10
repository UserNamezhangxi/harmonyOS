import { kvStore } from 'common/src/main/ets/utils/KvStore';

@Entry()
@Component
struct Index {
  build() {
    Column({ space: 10 }) {
      Text('kvStore 案例')
      Button('存储数据').onClick(() => {
        kvStore.putKV('username', 'zhangxi')
        kvStore.putKV('count', 1)
      })
      Button('获取数据').onClick(() => {
        kvStore.getKv('username').then(res => {
          console.log('获取数据 username ' + res)
        })
        kvStore.getKv('count').then(res => {
          console.log('获取数据 count ' + res)
        })
      })
    }
    .width('100%')
    .height('100%')
  }
}
