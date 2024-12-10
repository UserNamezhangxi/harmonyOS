
@Entry
@Component
struct BackupPageDetail {
  build() {
    Column() {
      TextInput({
        placeholder:"输入内容..."
      })
      Text('备忘录页面').fontSize(30)
    }
  }
}