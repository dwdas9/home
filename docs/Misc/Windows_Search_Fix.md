# Fix Windows Search When Apps Do Not Appear

![alt text](StartMenuSearchDoesntWork.png)
If Windows Search opens but cannot find installed apps, the search service may be stuck.

Open **PowerShell as Administrator** and run:

```powershell
Restart-Service WSearch -Force
```

Wait a few seconds, then search for the app again. In many cases, results start appearing immediately.
