let num: string = '1.4'

console.log('TAG','Number ' + Number(num))
console.log('TAG','Number ' + parseInt(num))
console.log('TAG','parseFloat ' + parseFloat(num))

@Entry
@Component
struct Index {
  build() {
    // 设置组件间的间距
    Column() {
      Stack({
        alignContent: Alignment.Bottom
      }) {
        Image($r('app.media.avator')).width(200).height(150)
        Row() {
          Row() {
            Image($r('app.media.startIcon')).width(16)
            Text('Number').fontColor(Color.White)

            Image($r('app.media.startIcon')).width(16).margin({ left: 16 }).fillColor(Color.White)
            Text('你好').fontColor(Color.White)
          }

          Text("1:02").fontColor(Color.White)
        }.width('100%').justifyContent(FlexAlign.SpaceBetween).padding(4)
      }

      Text('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa').textOverflow({
          overflow: TextOverflow.Ellipsis
        })
        .maxLines(2)

      Row() {
        Text('19万点赞').backgroundColor(Color.Yellow).fontSize(10).padding(3).borderRadius(3)
        Image($r('app.media.arr')).width(12)
      }.width('100%').justifyContent(FlexAlign.SpaceBetween)
    }
    .width(200)
    .height(200)
  }
}