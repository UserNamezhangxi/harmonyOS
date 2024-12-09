import { mediaquery } from '@kit.ArkUI';

@Entry()
@Component
struct Index {

   // 检测屏幕是否是横竖屏
  listener: mediaquery.MediaQueryListener = mediaquery.matchMediaSync('(orientation: landscape)');

  onPortrait(mediaQueryResult: mediaquery.MediaQueryResult) {
    if (mediaQueryResult.matches as boolean) {
      console.log("橫屏")
    } else {
      console.log("竪屏")
    }
  }

  aboutToAppear(): void {
    this.listener.on('change', this.onPortrait);
  }

  build() {
    Column({ space: 10 }) {
      Text('媒体查询 ').fontSize(30)
    }
    .width('100%')
    .height('100%')
  }
}
