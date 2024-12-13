import { dBUtils } from 'common/src/main/ets/utils/DbUtils';
import { EmployeeModel } from 'common/src/main/ets/viewmodel/EmployeeModel';

@Entry()
@Component
struct Index {
  @State name: string = ''
  @State age: string = ''
  @State salary: string = '100.00'
  @State identity: string = '610402199911111111'

  build() {
    Column({ space: 10 }) {
      Text('数据库增删改查 案例')
      Row({ space: 10 }) {
        Text('NAME:')
        TextInput({ placeholder: '名字', text: $$this.name }).onChange((value) => {
          this.name = value
        })
      }

      Row({ space: 10 }) {
        Text('AGE:')
        TextInput({ placeholder: '年龄', text: $$this.age }).onChange((value) => {
          this.age = value
        })
      }

      Row({ space: 10 }) {
        Text('SALARY:')
        TextInput({ placeholder: '薪水', text: $$this.salary }).onChange((value) => {
          this.salary = value
        })
      }

      Row({ space: 10 }) {
        Text('IDENTITY:')
        TextInput({ placeholder: '身份证' }).onChange((value) => {
          this.identity = value
        })
      }

      Button('插入').onClick(() => {
        dBUtils.insert('employee', {
          'NAME': this.name,
          'AGE': this.age,
          'SALARY': this.salary,
          'IDENTITY': this.identity
        })
      })

      Button('修改').onClick(() => {
        dBUtils.update('employee', 1, {
          'NAME': this.name,
          'AGE': this.age,
          'SALARY': 999,
          'IDENTITY': this.identity
        })
      })

      Button('查询').onClick(async () => {
        let colum: string[] = ['ID', 'NAME', 'AGE', 'SALARY', 'IDENTITY']
        let employeeModel:EmployeeModel[] = await dBUtils.query('employee', colum)
        for (let item of employeeModel) {
          console.info(`pages id=${item.id}, name=${item.name}, age=${item.age}, salary=${item.salary}, identity=${item.identity}`);
        }
      })

      Button('删除').onClick(() => {
        dBUtils.delete('employee', 1)
      })

    }
    .width('100%')
    .height('100%')
  }
}
