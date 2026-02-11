# 部署系统
```bash
sudo sbctl create-keys
# 重启到BIOS，打开安全启动并"Reset to Setup Mode"
sudo sbctl enroll-keys --microsoft --firmware-builtin
```
将`keys.txt`复制到/var/lib/sops-nix/ 和 ~/.config/sops/age/

# 恢复数据
## 检查备份
```bash
restic-home-data snapshots
```
## 恢复最新
```bash
restic-home-data restore latest
```
