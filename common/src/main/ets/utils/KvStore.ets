import { distributedKVStore } from '@kit.ArkData';
import { BusinessError } from '@kit.BasicServicesKit';

class KvStore {
  private kvManager: distributedKVStore.KVManager | undefined = undefined;
  private kvStore: distributedKVStore.SingleKVStore | undefined = undefined;

  init(context: Context) {
    const kvManagerConfig: distributedKVStore.KVManagerConfig = {
      context: context,
      bundleName: 'com.example.myapplication'
    };
    try {
      // 创建KVManager实例
      this.kvManager = distributedKVStore.createKVManager(kvManagerConfig);
      console.info('Succeeded in creating KVManager.');
      // 继续创建获取数据库
    } catch (e) {
      let error = e as BusinessError;
      console.error(`Failed to create KVManager. Code:${error.code},message:${error.message}`);
    }

    if (this.kvManager === undefined) {
      console.error('kvManager init err!')
      return
    }

    //进行后续操作
    this.kvManager = this.kvManager as distributedKVStore.KVManager;

    try {
      const options: distributedKVStore.Options = {
        createIfMissing: true,
        encrypt: false,
        backup: false,
        autoSync: false,
        // kvStoreType不填时，默认创建多设备协同数据库
        kvStoreType: distributedKVStore.KVStoreType.SINGLE_VERSION,
        // 多设备协同数据库：kvStoreType: distributedKVStore.KVStoreType.DEVICE_COLLABORATION,
        securityLevel: distributedKVStore.SecurityLevel.S1
      };

      this.kvManager.getKVStore<distributedKVStore.SingleKVStore>('storeId', options,
        (err, store: distributedKVStore.SingleKVStore) => {
          if (err) {
            console.error(`Failed to get KVStore: Code:${err.code},message:${err.message}`);
            return;
          }
          console.info('Succeeded in getting KVStore.');
          this.kvStore = store;
          // 请确保获取到键值数据库实例后，再进行相关数据操作
        });
    } catch (e) {
      let error = e as BusinessError;
      console.error(`An unexpected error occurred. Code:${error.code},message:${error.message}`);
    }
  }

  putKV(key: string, value: string | number | boolean | Uint8Array) {
    if (this.kvStore === undefined) {
      console.error('putKV kvStore init err!')
      return
    }
    try {
      this.kvStore.put(key, value, (err) => {
        if (err !== undefined) {
          console.error(`Failed to put data. Code:${err.code},message:${err.message}`);
          return;
        }
        console.info('Succeeded in putting data.');
      });
    } catch (e) {
      let error = e as BusinessError;
      console.error(`An unexpected error occurred. Code:${error.code},message:${error.message}`);
    }
  }

  getKv(key: string) {
    return new Promise((resolve: (value?: string | number | boolean | Uint8Array) => void,
      reject: (value?: string) => void) => {
      if (this.kvStore === undefined) {
        console.error('getKv kvStore init err!')
        reject('getKv kvStore init err!')
        return
      }
      try {
        this.kvStore.get(key, (err, data) => {
          if (err != undefined) {
            console.error(`Failed to get data. Code:${err.code},message:${err.message}`);
            reject(`Failed to get data. Code:${err.code},message:${err.message}`)
            return;
          }
          console.info(`Succeeded in getting data. Data:${data}`);
          resolve(data)
        });
      } catch (e) {
        let error = e as BusinessError;
        console.error(`Failed to get data. Code:${error.code},message:${error.message}`);
        reject(`Failed to get data. Code:${error.code},message:${error.message}`)
      }
    })
  }
}

const kvStore:KvStore = new KvStore()
export {kvStore}

