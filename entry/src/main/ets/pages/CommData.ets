import { timeAgo , convertLevelIcon} from './utils'

@Observed
export class CommonData {
  avatar:string = ''
  name:string  = ''
  lv:number = 0
  common:string = ''
  commonTimeStamp:number
  commonTime:string
  likeNumber:number
  isLike:boolean
  levelIcon:Resource

  constructor(avatar:string, name:string, lv:number, common:string, commonTimeStamp:number, likeNumber:number, isLike:boolean ) {
    this.avatar = avatar
    this.name = name
    this.lv = lv
    this.levelIcon = convertLevelIcon(lv)
    this.common = common
    this.commonTimeStamp = commonTimeStamp
    this.commonTime = timeAgo(commonTimeStamp)
    this.likeNumber = likeNumber
    this.isLike = isLike
  }

}