<h1 align="center">🕒 TIMEZONE FIX IN DUALBOOT SYSTEM 🕘</h1>

Ubuntu and other Linux distros store time on the hardware clock as UTC by default, while Windows stores it as local time, leading to inconsistent current time when switching between OS.

## ✅ Solution: Make Windows 10 use UTC

Whereas changing Ubuntu to use local time instead of UTC had its disadvantages, making Windows 10 use the UTC time will only bring the advantages of using UTC time. This is why this is the recommended method.

You can manually edit the registry to add a new key:
- Go to `[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\TimeZoneInformation]`
- Create a key with the name `RealTimeUniversal` and the value `1`

Alternatively, you can run the file `universal-timezone.reg` stored along with this README to do the same faster.

---

### 🔗 Related links
* https://technastic.com/fix-time-between-windows-10-and-ubuntu-in-dual-boot/
* https://superuser.com/questions/975717/does-windows-10-support-utc-as-bios-time
