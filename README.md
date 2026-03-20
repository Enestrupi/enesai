# Studio Bridge

Connect your website to Roblox Studio. Send commands from your dashboard and they execute live in Studio.

---

## Files

| File | What it is |
|------|-----------|
| `dashboard.html` | The website — open in browser or host on GitHub Pages |
| `server.js` | Node.js backend — bridges website ↔ Studio plugin |
| `studio-plugin.lua` | Paste into Roblox Studio as a plugin |

---

## How it works

```
dashboard.html
     │
     │  POST /api/command
     ▼
  server.js  ◄──── GET /api/poll/:token ────  studio-plugin.lua
     │                                               │
     │  GET /api/result/:token  ◄── POST /api/result │
     ▼                                               ▼
 shows output                              executes in Studio
```

---

## Setup

### 1. Deploy the server

```bash
npm install express cors
node server.js
```

Deploy to [Railway](https://railway.app) or [Render](https://render.com) — both free.  
Copy the URL it gives you (e.g. `https://studio-bridge.railway.app`).

### 2. Configure the dashboard

Open `dashboard.html` and replace:

```js
const BACKEND = "https://your-server.com";
```

with your Railway/Render URL.

Then enable **GitHub Pages** on this repo:  
Settings → Pages → Deploy from branch → `main` / `root`

Your dashboard will be live at:  
`https://YOUR-USERNAME.github.io/studio-bridge/dashboard.html`

### 3. Install the Studio plugin

1. Open Roblox Studio
2. Go to **Plugins** tab → **Plugins Folder**
3. Save `studio-plugin.lua` inside that folder (rename to `StudioBridge.lua`)
4. Open `studio-plugin.lua` and replace:

```lua
local BACKEND_URL = "YOUR_BACKEND_URL"
```

with your server URL.

5. Restart Studio — a **Studio Bridge** button appears in your toolbar

### 4. Connect

1. Open the dashboard → sign in with your Roblox username
2. Copy the **session token** shown in the dashboard
3. In Studio, click **Studio Bridge** in the toolbar
4. Paste the token → click **Connect**
5. The dot turns green — you're live

---

## API endpoints

| Method | Path | Used by |
|--------|------|---------|
| `POST` | `/api/command` | Dashboard sends command |
| `GET` | `/api/poll/:token` | Plugin polls for commands |
| `POST` | `/api/result` | Plugin posts result |
| `GET` | `/api/result/:token` | Dashboard reads result |
| `POST` | `/api/verify` | Verify Roblox username |
| `GET` | `/api/ping/:token` | Check plugin connection |

---

## Roblox auth

Login uses a **profile description verification** flow:

1. User enters their Roblox username
2. Dashboard generates a one-time code (e.g. `BRIDGE-A1B2C3`)
3. User pastes the code into their Roblox profile description
4. Server calls the Roblox Users API to confirm the code is there
5. User is verified — code can be removed

No passwords. No OAuth app approval needed.

---

## Requirements

- Node.js 18+
- Roblox Studio with **HTTP Requests** enabled  
  *(Studio → Game Settings → Security → Allow HTTP Requests)*

---

## License

MIT
