# SanDisk Not Mounting Fix

## Why it happens

ExFAT sets a "dirty bit" in the volume header when mounted. On clean eject, it clears the bit. If you unplug without ejecting, the bit stays set. macOS sees the dirty bit on next plug-in and refuses to auto-mount to protect against potential corruption.

## Steps when it happens

Plug in the drive, then run the following commands in Terminal:

```bash
# 1. Find the drive
diskutil list

# 2. Try mounting
diskutil mount disk4s2

# 3. If that fails, mount read-only
diskutil mount readOnly disk4s2

# 4. If read-only works but you need write access, repair first
sudo fsck_exfat -d disk4s2
diskutil mount disk4s2
```

Replace `disk4s2` with whatever identifier shows up in step 1.

## Prevention

Always eject before unplugging: right-click → Eject in Finder, or `diskutil eject disk4`.