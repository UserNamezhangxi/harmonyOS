@Observed
class Product {
  isSelect: boolean = false
  name: string = ''

  constructor(isSelect: boolean, name: string) {
    this.isSelect = isSelect;
    this.name = name;
  }
}

@Component
struct Item {
  @ObjectLink item: Product

  build() {
    ListItem() {
      Row() {
        Checkbox().select(this.item.isSelect)
        Text(this.item.name).fontSize(40)
      }
    }
  }
}

@Entry()
@Component
struct Index {
  @State @Watch('isSelectAll') isSelectAllProduct: boolean = false
  @State datas: Product[] = [
    new Product(false, 'AAA'),
    new Product(false, 'BBB'),
    new Product(false, 'CCC'),
  ]
  @State index: number = 0

  isSelectAll() {
    for (let item of this.datas) {
      item.isSelect = !this.isSelectAllProduct
    }
  }

  build() {
    Column({ space: 10 }) {
      Text('商品页面')
      Button('全选').onClick(() => {
        this.isSelectAllProduct = !this.isSelectAllProduct
      })
      List({ space: 20 }) {
        ForEach(this.datas, (item: Product, index: number) => {
          Item({
            item: item
          })
        }, (item: number) => `${item}`)
      }
    }
    .width('100%')
    .height('100%')
  }
}
