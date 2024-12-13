import { relationalStore } from '@kit.ArkData'; // 导入模块
import { BusinessError } from '@kit.BasicServicesKit';
import { EmployeeModel } from '../viewmodel/EmployeeModel';

export class DBUtils {
  store: relationalStore.RdbStore | undefined = undefined;

  init(context: Context, tableName: string) {
    const STORE_CONFIG: relationalStore.StoreConfig = {
      name: 'RdbTest.db', // 数据库文件名
      securityLevel: relationalStore.SecurityLevel.S3, // 数据库安全级别
      encrypt: false, // 可选参数，指定数据库是否加密，默认不加密
      customDir: 'customDir/subCustomDir', // 可选参数，数据库自定义路径。数据库将在如下的目录结构中被创建：context.databaseDir + '/rdb/' + customDir，其中context.databaseDir是应用沙箱对应的路径，'/rdb/'表示创建的是关系型数据库，customDir表示自定义的路径。当此参数不填时，默认在本应用沙箱目录下创建RdbStore实例。
      isReadOnly: false // 可选参数，指定数据库是否以只读方式打开。该参数默认为false，表示数据库可读可写。该参数为true时，只允许从数据库读取数据，不允许对数据库进行写操作，否则会返回错误码801。
    };

    // 判断数据库版本，如果不匹配则需进行升降级操作
    // 假设当前数据库版本为3，表结构：EMPLOYEE (NAME, AGE, SALARY, CODES, IDENTITY)
    const SQL_CREATE_TABLE =
      `CREATE TABLE IF NOT EXISTS ${tableName} (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT NOT NULL, AGE INTEGER, SALARY REAL, IDENTITY TEXT)`; // 建表Sql语句, IDENTITY为bigint类型，sql中指定类型为UNLIMITED INT

    relationalStore.getRdbStore(context, STORE_CONFIG, (err, store) => {
      if (err) {
        console.error(`Failed to get RdbStore. Code:${err.code}, message:${err.message}`);
        return;
      }
      console.info('zhangxi', 'Succeeded in getting RdbStore.');

      this.store = store
      // 当数据库创建时，数据库默认版本为0
      console.info('zhangxi', 'store.version ' + store.version);
      if (store.version === 0) {
        store.executeSql(SQL_CREATE_TABLE); // 创建数据表
        // 设置数据库的版本，入参为大于0的整数
      }
      // // 如果数据库版本不为0且和当前数据库版本不匹配，需要进行升降级操作
      // // 当数据库存在并假定版本为1时，例应用从某一版本升级到当前版本，数据库需要从1版本升级到2版本
      // if (store.version === 1) {
      //   // version = 1：表结构：EMPLOYEE (NAME, SALARY, CODES, ADDRESS) => version = 2：表结构：EMPLOYEE (NAME, AGE, SALARY, CODES, ADDRESS)
      //   (store as relationalStore.RdbStore).executeSql('ALTER TABLE EMPLOYEE ADD COLUMN AGE INTEGER');
      //   store.version = 2;
      // }
      //
      // // 当数据库存在并假定版本为2时，例应用从某一版本升级到当前版本，数据库需要从2版本升级到3版本
      // if (store.version === 2) {
      //   // version = 2：表结构：EMPLOYEE (NAME, AGE, SALARY, CODES, ADDRESS) => version = 3：表结构：EMPLOYEE (NAME, AGE, SALARY, CODES)
      //   (store as relationalStore.RdbStore).executeSql('ALTER TABLE EMPLOYEE DROP COLUMN ADDRESS TEXT');
      //   store.version = 3;
      // }
    });
  }

  insert(tableName: string, valueBucket: relationalStore.ValuesBucket) {
    if (this.store !== undefined) {
      (this.store as relationalStore.RdbStore).insert(tableName, valueBucket, (err: BusinessError, rowId: number) => {
        if (err) {
          console.error('zhangxi', `Failed to insert data. Code:${err.code}, message:${err.message}`);
          return;
        }
        console.info('zhangxi', `Succeeded in inserting data. rowId:${rowId}`);
      })
    }
  }

  update(tableName: string, id: number, valueBucket: relationalStore.ValuesBucket) {
    // 修改数据
    let predicates1 = new relationalStore.RdbPredicates(tableName); // 创建表'EMPLOYEE'的predicates
    predicates1.equalTo('ID', id); // 匹配表'EMPLOYEE'中'NAME'为'Lisa'的字段
    if (this.store !== undefined) {
      (this.store as relationalStore.RdbStore).update(valueBucket, predicates1, (err: BusinessError, rows: number) => {
        if (err) {
          console.error('zhangxi', `Failed to update data. Code:${err.code}, message:${err.message}`);
          return;
        }
        console.info('zhangxi', `Succeeded in updating data. row count: ${rows}`);
      })
    }
  }

  // 删除数据
  delete(tableName: string, id: number) {
    let predicates1 = new relationalStore.RdbPredicates(tableName);
    predicates1.equalTo('ID', id);
    if (this.store !== undefined) {
      (this.store as relationalStore.RdbStore).delete(predicates1, (err: BusinessError, rows: number) => {
        if (err) {
          console.error('zhangxi', `Failed to delete data. Code:${err.code}, message:${err.message}`);
          return;
        }
        console.info('zhangxi', `Delete rows: ${rows}`);
      })
    }
  }

  async query(tableName: string, colum: Array<string>, id?: number) {
    let predicates2 = new relationalStore.RdbPredicates(tableName);
    if (id) {
      predicates2.equalTo('ID', id)
    }
    let result: EmployeeModel[] = []
    if (this.store !== undefined) {
      const resultSet = await (this.store as relationalStore.RdbStore).query(predicates2, colum)
      // resultSet是一个数据集合的游标，默认指向第-1个记录，有效的数据从0开始。
      while (resultSet.goToNextRow()) {
        const id = resultSet.getLong(resultSet.getColumnIndex('ID'));
        const name = resultSet.getString(resultSet.getColumnIndex('NAME'));
        const age = resultSet.getLong(resultSet.getColumnIndex('AGE'));
        const salary = resultSet.getDouble(resultSet.getColumnIndex('SALARY'));
        const identity = resultSet.getString(resultSet.getColumnIndex('IDENTITY'));
        let model = new EmployeeModel()
        model.id = id
        model.name = name
        model.age = age
        model.salary = salary
        model.identity = identity
        result.push(model)
        console.info('zhangxi', `id=${id}, name=${name}, age=${age}, salary=${salary}, identity=${identity}`);
      }
      resultSet.close();
    } else {
      console.error('query db store init err')
    }
    return result
  }
}

let dBUtils = new DBUtils();

export { dBUtils
}