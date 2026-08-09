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


# How to Find Processes Blocking Your External Drive from Ejecting

When macOS says "The disk was not ejected because one or more programs may be using it," here's how to find and kill the culprit.

## Step 1: Find What's Holding the Drive

Open Terminal and run:

```bash
lsof | grep "/Volumes/YOUR_DRIVE_NAME"
```

Replace `YOUR_DRIVE_NAME` with your drive's name (e.g., `Extreme SSD`). If the name has spaces, wrap it in quotes:

```bash
lsof | grep "/Volumes/Extreme SSD"
```

This lists every process that has an open file on your drive. The output looks like:

```
QuickLook  722  das  3r  REG  1,22  9751606  /Volumes/Extreme SSD/Music/song.mp3
```

- **First column** = the program name (QuickLook, Finder, Spotlight, etc.)
- **Second column** = the PID (process ID) — the number you need to kill it

## Step 2: Kill the Process

```bash
kill <PID>
```

If it doesn't die (some processes respawn immediately):

```bash
kill -9 <PID>
```

## Step 3: Eject Immediately After

Chain the kill and eject together so nothing re-grabs the drive:

```bash
kill -9 <PID>; diskutil eject "/Volumes/YOUR_DRIVE_NAME"
```

## Common Offenders

| Program | Why | Fix |
|---------|-----|-----|
| QuickLook | You previewed a file on the drive | Kill it — it respawns on its own |
| mds / mds_worker | Spotlight is indexing the drive | Kill, or add drive to Spotlight's Privacy list in System Settings |
| Finder | Has a window open to the drive | Close the Finder window first |
| Photos / Music | Imported or playing media from the drive | Quit the app |
| fsevents | File system event watcher | Usually clears once other processes release |

## One-Liner: Find, Kill, Eject

```bash
lsof | grep "/Volumes/Extreme SSD" | awk '{print $2}' | sort -u | xargs kill -9; diskutil eject "/Volumes/Extreme SSD"
```

This kills every process touching the drive and ejects it in one shot.

## Prevent Spotlight Indexing (Optional)

If Spotlight (`mds_worker`) is the repeat offender, stop it from indexing external drives:

```bash
sudo mdutil -i off "/Volumes/YOUR_DRIVE_NAME"
```

Or go to **System Settings > Spotlight > Privacy** and add the drive there.
