# 部署系统
删除所有报错的文件和代码，直到能正常build为止
重启到BIOS，打开安全启动并"Reset to Setup Mode"
将`keys.txt`复制到/var/lib/sops-nix/ 和 ~/.config/sops/age/

- TODO: disko

# 恢复数据
## 检查备份
```bash
restic-home-data snapshots
```
## 恢复最新
```bash
restic-home-data restore latest
```
