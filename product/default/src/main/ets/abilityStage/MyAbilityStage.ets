import { AbilityStage, Want } from '@kit.AbilityKit';

export default class MyAbilityStage extends AbilityStage {
  onCreate(): void {
    // 应用HAP首次加载时触发，可以在此执行该Module的初始化操作（例如资源预加载、线程创建等）。
  }

  // 仅specified模式下触发
  onAcceptWant(want: Want): string {
    if (want.abilityName === 'WpsAbility') {
      return `${want?.parameters?.instanceKey}`
    }

    return 'MyAbilityStage';
  }
}