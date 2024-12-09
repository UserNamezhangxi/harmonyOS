import { CommonData } from "./CommData"

let name1: string = '刘备'
let price: number = 9.9
let sayHi = () => {
  console.log('tag', '你好 hello')
}

@Preview
@Component
struct HelloComp {
  build() {
    Row() {
      Text('自定义组件')
      Button('按钮')
    }
    .width(200)
    .height(100)
    .padding(20)
    .backgroundColor(Color.Brown)
  }
}



function timeAgo(timestamp: number): string {
  const now = new Date().getTime() / 1000
  const timeDiff = (now - timestamp);

  if (timeDiff < 3) {
    return '刚刚';
  } else if (timeDiff < 60) {
    return `${Math.floor(timeDiff)}秒前`;
  } else if (timeDiff < 3600) {
    return `${Math.floor(timeDiff / 60)}分钟前`;
  } else if (timeDiff < 24 * 3600) {
    return `${Math.floor(timeDiff / 3600)}小时前`;
  } else if (timeDiff < 7 * 24 * 3600) {
    return `${Math.floor(timeDiff / (24 * 3600))}天前`;
  } else if (timeDiff < 30 * 24 * 3600) {
    return `${Math.floor(timeDiff / (7 * 24 * 3600))}周前`;
  } else if (timeDiff < 365 * 24 * 3600) {
    return `${Math.floor(timeDiff / (30 * 24 * 3600))}月前`;
  } else {
    return `${Math.floor(timeDiff / (365 * 24 * 3600))}年前`;
  }
}

function convertLevelIcon(level:number):Resource {
  let result = new Array<Resource>()
  result = [
    $r('app.media.lv0'),
    $r('app.media.lv1'),
    $r('app.media.lv2'),
    $r('app.media.lv3'),
    $r('app.media.lv4'),
    $r('app.media.lv5'),
    $r('app.media.lv6')
  ]
  return result[level]

}

const createCommonData = ():CommonData[] => {
  let result = new Array<CommonData>()
  result = [
    new CommonData('https://i0.hdslb.com/bfs/face/3480f17dc92441ae6b5b75a79ea3f004c631a475.jpg','丶可惜没如果丶',1,"本次课程是纯NEXT星河版，不包含4.0哈，也是很对于零基础同学设计，持续更新中，小伙伴们赶紧学起来哈~~~~",1732972719, 20, false),
    new CommonData('https://i2.hdslb.com/bfs/face/bdda531a646c67a3174d6391c23d2e96af09c759.jpg','黑马pink讲前端',2, "上次4.的学习0就是因为nodejs版本问题从安装到卸载[doge]，原来可以同时安装两个版本的nodejs[妙啊]",1728975055, 1, true),
    new CommonData('https://i2.hdslb.com/bfs/face/44747c98a414ae8c770316af98c909f3388eee76.jpg','阿宇鸭丶',3,"学完了，直接java转鸿蒙[doge]",1732256371, 55, false),
    new CommonData('https://i1.hdslb.com/bfs/face/4a40d7d08203d3505477384d4d03cd26f3a50765.jpg','昵称掉沟里了',4,"代码仓库地址？",1729494414, 21, true),
    new CommonData('https://i0.hdslb.com/bfs/face/ee7a0b228522899dcbbf891d14aa0031a3d6dd37.jpg','灰灰是只猫猫咪',5,"完全一样的源码，为什么抖音只能采集第一页，屏幕完全不滚动的",1731910529, 20, false),
    new CommonData('https://i0.hdslb.com/bfs/face/2e31fadddf824fff4ab2b4f2bf174a0a34bffe76.jpg','Python大本营',5,"我也遇到同样的问题了，在浏览器下滑一下才能采集下一页",1733473790, 59, true),
    new CommonData('https://i0.hdslb.com/bfs/face/2e31fadddf824fff4ab2b4f2bf174a0a34bffe76.jpg','高总高总',6,"为什么我的csv是乱码啊，在pc里打开时正常的，找到文件直接打开就是乱码",1732437425, 29, false),
    new CommonData('https://i0.hdslb.com/bfs/face/2e31fadddf824fff4ab2b4f2bf174a0a34bffe76.jpg','霸波尔奔笨',5,"已三连，求源代码",1729855488, 2, false),
    new CommonData('https://i0.hdslb.com/bfs/face/d8e715e079ded37f6ff8e7f8f7660e401361b5ba.jpg','王朝窥密者',4,"下滑分翻页不生效怎么解决啊[笑哭]",1732759975, 10, true),
    new CommonData('https://i0.hdslb.com/bfs/face/ff1a90c3310df0e112a6f09a70a1bd5bd8f19e0e.jpg','泰同学',5, "三联求源码",1729439164, 10, false),
    new CommonData('https://i0.hdslb.com/bfs/face/ce1ab3cfc33c07ac64eac8f5aa55827e14a1ad76.jpg','Vecchio_zhu',4,"需要源码的小可爱可以关注并下方留言【已点赞】 [给心心][给心心][给心心]我会依次发送噢~[打call][打call][打call]",1725455853, 12, true),
    new CommonData('https://i0.hdslb.com/bfs/face/a0180f60bde54343a85633f9346d41ece99ed1d0.jpg','剑武书生在梅边',5,"亲测有效，大神，开心收下有没有解决？",1730949921, 2, true),
    new CommonData('https://i0.hdslb.com/bfs/face/d79ae1cc7939b089eb680da4bab2bcca1e8bb212.jpg','动须相应-',6,"还没学，已经拿到《HarmonyOS 应用开发者高级认证》证书了[吃瓜]",1732537633, 9, false),
    new CommonData('https://i0.hdslb.com/bfs/face/a71b4dd6647ddf0c813bcf74e062edab9224cb0e.jpg','大姐大街打劫大捷',1,"是不是DevEco Studio需要的nodejs版本，支持NEXT的版本需要18.x，而现在的这些版本16.x？是不是有这个说法？",1733300413, 20, true),
    new CommonData('https://i0.hdslb.com/bfs/face/d8e715e079ded37f6ff8e7f8f7660e401361b5ba.jpg','孤独下雨天',1,"冲！[奋斗]", 1732335271, 120, false),
  ]
  return result;
}

interface IPerson {
  name:string
  age:number
  hobby:string
}


export {
  name1,
  price,
  sayHi,
  HelloComp,
  timeAgo,
  convertLevelIcon,
  createCommonData,
  IPerson
}

