- [ ] 
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"/>
<meta name="viewport" content="width=device-width,initial-scale=1.0"/>
<title>Studio Bridge v5 — Ultra Edition</title>
<link rel="preconnect" href="https://fonts.googleapis.com"/>
<link href="https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@300;400;500;600;700&family=Syne:wght@400;600;700;800;900&family=Space+Grotesk:wght@300;400;500;600;700&display=swap" rel="stylesheet"/>
<style>
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
:root{
  --bg:#030508;--bg2:#080b12;--bg3:#0d1019;--bg4:#121722;
  --border:rgba(255,255,255,0.04);--border2:rgba(255,255,255,0.08);--border3:rgba(255,255,255,0.12);
  --c1:#00f0ff;--c1d:rgba(0,240,255,0.06);--c1m:rgba(0,240,255,0.15);
  --c2:#8b5cf6;--c2d:rgba(139,92,246,0.08);--c2m:rgba(139,92,246,0.2);
  --c3:#10b981;--c3d:rgba(16,185,129,0.07);--c3m:rgba(16,185,129,0.18);
  --c4:#f59e0b;--c4d:rgba(245,158,11,0.08);
  --c5:#ef4444;--c5d:rgba(239,68,68,0.08);
  --c6:#f472b6;--c6d:rgba(244,114,182,0.08);
  --c7:#fb923c;--c7d:rgba(251,146,60,0.08);
  --text:#e2e8f7;--text2:#7a84a0;--text3:#2d3450;--text4:#4a5270;
  --rbx:#e31e25;
  --fd:'Syne',sans-serif;--fb:'Space Grotesk',sans-serif;--fm:'JetBrains Mono',monospace;
  --r:8px;--sidebar:280px;--topbar:50px;
  --glow1:rgba(0,240,255,0.12);--glow2:rgba(139,92,246,0.1);
}
html,body{background:var(--bg);color:var(--text);font-family:var(--fm);font-size:13px;height:100%;overflow:hidden}
::-webkit-scrollbar{width:3px;height:3px}
::-webkit-scrollbar-track{background:transparent}
::-webkit-scrollbar-thumb{background:rgba(255,255,255,0.06);border-radius:2px}
::-webkit-scrollbar-thumb:hover{background:rgba(255,255,255,0.12)}

body::before{content:'';position:fixed;inset:0;
  background:
    radial-gradient(ellipse 80% 60% at 20% -5%,rgba(0,240,255,0.035),transparent),
    radial-gradient(ellipse 60% 70% at 80% 100%,rgba(139,92,246,0.04),transparent),
    radial-gradient(ellipse 40% 40% at 60% 40%,rgba(16,185,129,0.015),transparent);
  pointer-events:none;z-index:0}

/* ── NOISE TEXTURE ── */
body::after{content:'';position:fixed;inset:0;opacity:.018;
  background-image:url("data:image/svg+xml,%3Csvg viewBox='0 0 256 256' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='n'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23n)'/%3E%3C/svg%3E");
  pointer-events:none;z-index:0}

/* ══════════════════ AUTH ══════════════════ */
#auth{position:fixed;inset:0;display:flex;align-items:center;justify-content:center;z-index:999;background:var(--bg)}
#auth.gone{display:none}
.auth-orbs{position:absolute;inset:0;overflow:hidden;pointer-events:none}
.auth-orb{position:absolute;border-radius:50%;filter:blur(80px);animation:orbFloat 8s ease-in-out infinite}
.auth-orb:nth-child(1){width:500px;height:500px;background:rgba(0,240,255,0.04);top:-10%;left:-10%;animation-delay:0s}
.auth-orb:nth-child(2){width:600px;height:600px;background:rgba(139,92,246,0.05);bottom:-20%;right:-15%;animation-delay:3s}
.auth-orb:nth-child(3){width:300px;height:300px;background:rgba(16,185,129,0.03);top:40%;left:60%;animation-delay:5s}
@keyframes orbFloat{0%,100%{transform:translate(0,0) scale(1)}33%{transform:translate(20px,-15px) scale(1.05)}66%{transform:translate(-10px,20px) scale(0.97)}}
.auth-wrap{width:440px;position:relative;z-index:2}
.auth-brand{display:flex;align-items:center;gap:14px;margin-bottom:2.8rem}
.auth-brand-mark{width:44px;height:44px;background:linear-gradient(135deg,var(--c1),var(--c2));border-radius:12px;display:flex;align-items:center;justify-content:center;font-size:20px;position:relative;overflow:hidden}
.auth-brand-mark::after{content:'';position:absolute;inset:0;background:linear-gradient(135deg,rgba(255,255,255,0.2),transparent);border-radius:inherit}
.auth-brand-mark-glow{position:absolute;inset:-4px;background:linear-gradient(135deg,var(--c1),var(--c2));border-radius:16px;opacity:0.25;filter:blur(12px);z-index:-1;animation:brandGlow 3s ease-in-out infinite}
@keyframes brandGlow{0%,100%{opacity:0.2;transform:scale(1)}50%{opacity:0.4;transform:scale(1.1)}}
.auth-brand-info .name{font-family:var(--fd);font-size:18px;font-weight:900;color:var(--text);letter-spacing:-.02em}
.auth-brand-info .ver{font-size:9px;color:var(--text2);margin-top:1px;letter-spacing:.2em;text-transform:uppercase}
.auth-card{background:linear-gradient(145deg,rgba(13,16,25,0.95),rgba(8,11,18,0.98));border:.5px solid var(--border3);border-radius:20px;padding:2.4rem;box-shadow:0 32px 80px rgba(0,0,0,0.6),inset 0 1px 0 rgba(255,255,255,0.06)}
.auth-card h2{font-family:var(--fd);font-size:22px;font-weight:900;margin-bottom:.5rem;letter-spacing:-.03em;background:linear-gradient(135deg,var(--text) 40%,var(--c1));-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text}
.auth-card p{font-size:11px;color:var(--text2);margin-bottom:2rem;line-height:1.9;font-family:var(--fb)}
.auth-features{display:grid;grid-template-columns:1fr 1fr;gap:6px;margin-bottom:1.8rem}
.auth-feat{display:flex;align-items:center;gap:6px;padding:7px 10px;background:var(--bg3);border:.5px solid var(--border);border-radius:8px;font-size:9px;color:var(--text2);font-family:var(--fb)}
.auth-feat-dot{width:5px;height:5px;border-radius:50%;flex-shrink:0}
.field{margin-bottom:1.1rem}
.field label{display:block;font-size:9px;color:var(--text2);margin-bottom:7px;letter-spacing:.15em;text-transform:uppercase;font-family:var(--fb)}
.field input{width:100%;background:var(--bg3);border:.5px solid var(--border2);border-radius:var(--r);padding:12px 15px;font-family:var(--fm);font-size:12px;color:var(--text);outline:none;transition:border-color .2s,box-shadow .2s}
.field input:focus{border-color:var(--c1);box-shadow:0 0 0 4px rgba(0,240,255,0.06),0 0 20px rgba(0,240,255,0.05)}
.field input::placeholder{color:var(--text3)}
.btn-main{width:100%;background:linear-gradient(135deg,var(--c1),#0090ff);color:#030508;border:none;border-radius:var(--r);padding:13px;font-family:var(--fd);font-weight:900;font-size:12px;letter-spacing:.08em;cursor:pointer;transition:all .2s;text-transform:uppercase;position:relative;overflow:hidden}
.btn-main::after{content:'';position:absolute;inset:0;background:linear-gradient(135deg,rgba(255,255,255,0.15),transparent);pointer-events:none}
.btn-main:hover{box-shadow:0 0 40px rgba(0,240,255,0.4),0 8px 24px rgba(0,0,0,0.4);transform:translateY(-2px)}
.auth-err{color:var(--c5);font-size:10px;margin-top:7px;display:none;font-family:var(--fb)}
.auth-stats{display:flex;gap:1px;margin-top:1.5rem;overflow:hidden;border-radius:10px;border:.5px solid var(--border)}
.auth-stat{flex:1;padding:10px 8px;background:var(--bg3);text-align:center}
.auth-stat-num{font-family:var(--fd);font-size:16px;font-weight:900;color:var(--c1);letter-spacing:-.02em}
.auth-stat-label{font-size:8px;color:var(--text3);margin-top:2px;font-family:var(--fb);text-transform:uppercase;letter-spacing:.1em}

/* ══════════════════ APP ══════════════════ */
#app{display:none;height:100%;flex-direction:column;position:relative;z-index:1}
#app.show{display:flex}

/* TOPBAR */
.topbar{height:var(--topbar);border-bottom:.5px solid var(--border);display:flex;align-items:center;padding:0 1rem;gap:.75rem;background:rgba(3,5,8,0.98);flex-shrink:0;z-index:100;backdrop-filter:blur(20px)}
.topbar-brand{display:flex;align-items:center;gap:9px;flex-shrink:0}
.topbar-brand-mark{width:26px;height:26px;background:linear-gradient(135deg,var(--c1),var(--c2));border-radius:7px;display:flex;align-items:center;justify-content:center;font-size:12px;position:relative}
.topbar-brand-name{font-family:var(--fd);font-size:13px;font-weight:900;color:var(--text);letter-spacing:-.02em}
.topbar-brand-ver{font-size:8px;color:var(--text3);font-family:var(--fb);margin-left:4px;padding:1px 5px;background:var(--bg3);border:.5px solid var(--border);border-radius:4px;letter-spacing:.1em}
.topbar-sep{width:.5px;height:16px;background:var(--border2);margin:0 4px}
.model-badge{display:flex;align-items:center;gap:5px;padding:4px 10px;background:var(--bg3);border:.5px solid var(--border2);border-radius:20px;font-size:9px;font-family:var(--fb);transition:all .3s;cursor:default}
.model-badge.fast{border-color:rgba(16,185,129,0.4);color:var(--c3);background:var(--c3d)}
.model-badge.balanced{border-color:rgba(0,240,255,0.3);color:var(--c1);background:var(--c1d)}
.model-badge.genius{border-color:rgba(139,92,246,0.5);color:#a78bfa;background:var(--c2d);box-shadow:0 0 16px rgba(139,92,246,0.15)}
.model-dot{width:5px;height:5px;border-radius:50%;background:currentColor;flex-shrink:0;animation:modelPulse 2s ease-in-out infinite}
@keyframes modelPulse{0%,100%{opacity:1}50%{opacity:0.4}}
.topbar-center{flex:1;display:flex;align-items:center;justify-content:center;gap:8px}
.topbar-stat{display:flex;align-items:center;gap:5px;font-size:9px;color:var(--text3);font-family:var(--fb);padding:3px 8px;background:var(--bg3);border:.5px solid var(--border);border-radius:10px}
.topbar-stat-val{color:var(--text2)}
.topbar-right{margin-left:auto;display:flex;align-items:center;gap:6px}
.user-chip{display:flex;align-items:center;gap:7px;padding:3px 11px 3px 4px;background:var(--bg3);border:.5px solid var(--border2);border-radius:20px;cursor:pointer;transition:all .15s}
.user-chip:hover{border-color:var(--border3)}
.user-ava{width:24px;height:24px;border-radius:50%;background:linear-gradient(135deg,var(--rbx),#ff6b6b);display:flex;align-items:center;justify-content:center;font-size:10px;font-weight:700;color:white;flex-shrink:0;font-family:var(--fb)}
.user-name{font-size:10px;color:var(--text);font-family:var(--fb)}
.logout-btn{color:var(--text3);cursor:pointer;margin-left:4px;font-size:10px;transition:color .15s;padding:2px}
.logout-btn:hover{color:var(--c5)}
.icon-btn{width:30px;height:30px;border-radius:7px;background:var(--bg3);border:.5px solid var(--border);display:flex;align-items:center;justify-content:center;cursor:pointer;font-size:12px;transition:all .15s;flex-shrink:0}
.icon-btn:hover{border-color:var(--border2);background:var(--bg4)}

/* APP BODY */
.app-body{flex:1;display:flex;overflow:hidden;min-height:0}

/* ══════════════════ SIDEBAR ══════════════════ */
.sidebar{width:var(--sidebar);flex-shrink:0;border-right:.5px solid var(--border);display:flex;flex-direction:column;background:var(--bg2);overflow:hidden;transition:width .25s}
.sidebar.collapsed{width:0}
.sidebar-top{padding:10px 10px 8px;border-bottom:.5px solid var(--border);flex-shrink:0;display:flex;gap:6px}
.new-chat-btn{flex:1;display:flex;align-items:center;gap:8px;padding:9px 11px;background:var(--bg3);border:.5px solid var(--border2);border-radius:8px;font-family:var(--fm);font-size:10px;color:var(--text2);cursor:pointer;transition:all .15s;text-align:left}
.new-chat-btn:hover{border-color:var(--c1);color:var(--c1);background:var(--c1d)}
.sidebar-search{padding:8px 10px;border-bottom:.5px solid var(--border);flex-shrink:0}
.sidebar-search-input{width:100%;background:var(--bg3);border:.5px solid var(--border);border-radius:6px;padding:7px 10px;font-family:var(--fm);font-size:10px;color:var(--text);outline:none;transition:border-color .2s}
.sidebar-search-input:focus{border-color:rgba(0,240,255,0.3)}
.sidebar-search-input::placeholder{color:var(--text3)}
.tmpl-tabs{display:flex;border-bottom:.5px solid var(--border);flex-shrink:0;overflow-x:auto;scrollbar-width:none}
.tmpl-tabs::-webkit-scrollbar{display:none}
.tmpl-tab{flex-shrink:0;padding:7px 9px;font-size:8px;text-align:center;cursor:pointer;color:var(--text3);letter-spacing:.06em;text-transform:uppercase;transition:all .15s;border-bottom:1.5px solid transparent;white-space:nowrap;font-family:var(--fb)}
.tmpl-tab.active{color:var(--c1);border-bottom-color:var(--c1);background:var(--c1d)}
.tmpl-panel{display:none;overflow-y:auto;flex:1;padding:4px 6px}
.tmpl-panel.active{display:flex;flex-direction:column}
.panel-section-label{font-size:8px;color:var(--text3);text-transform:uppercase;letter-spacing:.12em;padding:10px 6px 5px;font-family:var(--fb)}
.chat-item{display:flex;align-items:center;gap:7px;padding:6px 8px;border-radius:7px;cursor:pointer;font-size:10px;color:var(--text2);transition:all .12s;border:.5px solid transparent;margin-bottom:2px;font-family:var(--fb)}
.chat-item:hover{background:var(--bg3);border-color:var(--border)}
.chat-item.active{background:var(--c1d);color:var(--c1);border-color:rgba(0,240,255,0.15)}
.chat-item-icon{font-size:10px;flex-shrink:0;opacity:0.6}
.chat-item-body{flex:1;min-width:0}
.chat-item-title{overflow:hidden;text-overflow:ellipsis;white-space:nowrap;font-size:10px}
.chat-item-meta{font-size:8px;color:var(--text3);margin-top:1px}
.chat-del{font-size:9px;color:transparent;cursor:pointer;flex-shrink:0;padding:2px 4px;transition:color .12s;border-radius:3px}
.chat-item:hover .chat-del{color:var(--text3)}
.chat-del:hover{color:var(--c5)!important;background:var(--c5d)}
.sidebar-tool{display:flex;align-items:flex-start;gap:8px;padding:7px 8px;border-radius:7px;cursor:pointer;font-size:10px;color:var(--text2);transition:all .12s;border:.5px solid transparent;margin-bottom:2px;font-family:var(--fb)}
.sidebar-tool:hover{background:var(--bg3);color:var(--text);border-color:var(--border)}
.sidebar-tool:active{transform:scale(0.98)}
.sidebar-tool-icon{font-size:14px;flex-shrink:0;width:20px;text-align:center;margin-top:1px}
.sidebar-tool-body{flex:1;min-width:0}
.sidebar-tool-title{font-weight:600;font-size:10px;color:var(--text);margin-bottom:1px;letter-spacing:-.01em}
.sidebar-tool-desc{font-size:8px;color:var(--text3);line-height:1.5}
.tmpl-badge{font-size:7px;padding:1px 5px;border-radius:8px;font-weight:700;letter-spacing:.04em;margin-left:auto;flex-shrink:0;align-self:flex-start;margin-top:2px}
.tmpl-badge.new{background:rgba(16,185,129,0.1);color:var(--c3);border:.5px solid rgba(16,185,129,0.25)}
.tmpl-badge.adv{background:rgba(139,92,246,0.1);color:#a78bfa;border:.5px solid rgba(139,92,246,0.25)}
.tmpl-badge.pro{background:rgba(245,158,11,0.1);color:var(--c4);border:.5px solid rgba(245,158,11,0.25)}
.tmpl-badge.ultra{background:rgba(239,68,68,0.1);color:#f87171;border:.5px solid rgba(239,68,68,0.25)}
.tmpl-badge.hot{background:rgba(251,146,60,0.1);color:var(--c7);border:.5px solid rgba(251,146,60,0.25)}

/* ══════════════════ CHAT MAIN ══════════════════ */
.chat-main{flex:1;display:flex;flex-direction:column;overflow:hidden;min-height:0}
.welcome-screen{flex:1;display:flex;flex-direction:column;align-items:center;justify-content:center;padding:2rem;overflow-y:auto;position:relative}
.welcome-screen.hidden{display:none}
.welcome-glow{position:absolute;top:30%;left:50%;transform:translate(-50%,-50%);width:600px;height:400px;background:radial-gradient(ellipse,rgba(0,240,255,0.04),transparent 70%);pointer-events:none}
.welcome-logo{width:64px;height:64px;background:linear-gradient(135deg,var(--c1),var(--c2));border-radius:18px;display:flex;align-items:center;justify-content:center;font-size:28px;margin-bottom:1.5rem;position:relative;box-shadow:0 0 60px rgba(0,240,255,0.2)}
.welcome-logo::after{content:'';position:absolute;inset:-8px;background:linear-gradient(135deg,var(--c1),var(--c2));border-radius:26px;opacity:0.12;filter:blur(16px);z-index:-1}
.welcome-title{font-family:var(--fd);font-size:28px;font-weight:900;text-align:center;margin-bottom:.6rem;letter-spacing:-.04em;background:linear-gradient(135deg,var(--text) 40%,var(--text2));-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text}
.welcome-sub{font-size:11px;color:var(--text2);text-align:center;max-width:500px;line-height:1.9;margin-bottom:2rem;font-family:var(--fb)}
.welcome-badges{display:flex;gap:6px;margin-bottom:2.5rem;flex-wrap:wrap;justify-content:center}
.welcome-badge{padding:4px 12px;border-radius:20px;font-size:9px;font-family:var(--fb);font-weight:600;border:.5px solid;display:flex;align-items:center;gap:5px}
.wb-cyan{background:var(--c1d);color:var(--c1);border-color:rgba(0,240,255,0.2)}
.wb-purple{background:var(--c2d);color:#a78bfa;border-color:rgba(139,92,246,0.2)}
.wb-green{background:var(--c3d);color:var(--c3);border-color:rgba(16,185,129,0.2)}
.wb-orange{background:var(--c7d);color:var(--c7);border-color:rgba(251,146,60,0.2)}
.suggestion-grid{display:grid;grid-template-columns:1fr 1fr 1fr;gap:8px;width:100%;max-width:680px}
.suggestion{background:linear-gradient(145deg,var(--bg2),var(--bg3));border:.5px solid var(--border2);border-radius:12px;padding:14px 16px;cursor:pointer;transition:all .2s;position:relative;overflow:hidden}
.suggestion::before{content:'';position:absolute;inset:0;background:linear-gradient(135deg,rgba(0,240,255,0.02),transparent);opacity:0;transition:opacity .2s}
.suggestion:hover{border-color:rgba(139,92,246,0.35);transform:translateY(-3px);box-shadow:0 12px 32px rgba(0,0,0,0.4)}
.suggestion:hover::before{opacity:1}
.sug-icon{font-size:20px;margin-bottom:7px}
.sug-title{font-size:10px;font-weight:700;color:var(--text);margin-bottom:3px;font-family:var(--fd);letter-spacing:-.01em}
.sug-body{font-size:9px;color:var(--text2);line-height:1.5;font-family:var(--fb)}

/* ══════════════════ MESSAGES ══════════════════ */
.messages-wrap{flex:1;overflow-y:auto;padding:16px 0;display:flex;flex-direction:column}
.messages-wrap.hidden{display:none}
#messages-inner{display:flex;flex-direction:column;gap:4px}
.msg-row{display:flex;gap:13px;padding:8px 24px;align-items:flex-start;border-radius:4px;transition:background .15s}
.msg-row:hover{background:rgba(255,255,255,0.01)}
.msg-row.user{flex-direction:row-reverse}
.msg-avatar{width:30px;height:30px;border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:11px;font-weight:700;flex-shrink:0;margin-top:2px}
.msg-avatar.ai{background:linear-gradient(135deg,rgba(139,92,246,0.35),rgba(0,240,255,0.2));border:.5px solid rgba(139,92,246,0.4);color:var(--c1);font-size:12px}
.msg-avatar.user{background:linear-gradient(135deg,var(--rbx),#ff6b6b);color:white;font-family:var(--fb)}
.msg-content{flex:1;min-width:0;max-width:780px}
.msg-row.user .msg-content{display:flex;flex-direction:column;align-items:flex-end}
.msg-name{font-size:9px;font-weight:700;color:var(--text2);letter-spacing:.07em;text-transform:uppercase;margin-bottom:6px;display:flex;align-items:center;gap:7px;font-family:var(--fb)}
.msg-model-tag{font-size:8px;padding:1px 7px;border-radius:10px;font-weight:600;text-transform:none;letter-spacing:0}
.msg-model-tag.fast{background:var(--c3d);color:var(--c3);border:.5px solid rgba(16,185,129,0.2)}
.msg-model-tag.balanced{background:var(--c1d);color:var(--c1);border:.5px solid rgba(0,240,255,0.15)}
.msg-model-tag.genius{background:var(--c2d);color:#a78bfa;border:.5px solid rgba(139,92,246,0.25)}
.msg-bubble{font-size:12px;line-height:1.85;color:var(--text);word-break:break-word;font-family:var(--fb)}
.msg-row.user .msg-bubble{background:rgba(0,240,255,0.05);border:.5px solid rgba(0,240,255,0.1);border-radius:14px 14px 3px 14px;padding:11px 15px;display:inline-block;text-align:left;font-family:var(--fb)}
.msg-bubble pre{background:var(--bg2);border:.5px solid var(--border2);border-radius:12px;margin:12px 0;overflow:hidden}
.code-header{display:flex;align-items:center;justify-content:space-between;padding:8px 14px;border-bottom:.5px solid var(--border);background:var(--bg3)}
.code-lang{font-size:8px;color:var(--text2);letter-spacing:.12em;text-transform:uppercase;font-weight:700;font-family:var(--fb)}
.copy-code-btn{font-size:8px;color:var(--text3);cursor:pointer;padding:3px 9px;border:.5px solid var(--border);border-radius:4px;font-family:var(--fm);background:transparent;transition:all .15s}
.copy-code-btn:hover{border-color:var(--c1);color:var(--c1);background:var(--c1d)}
.code-body{padding:14px 16px;font-size:10.5px;color:var(--c1);line-height:1.8;overflow-x:auto;white-space:pre;font-family:var(--fm)}
.msg-bubble code{background:var(--bg3);border-radius:4px;padding:2px 7px;color:var(--c1);font-size:10px;font-family:var(--fm);border:.5px solid var(--border)}
.msg-bubble strong{color:var(--text);font-weight:700}
.msg-bubble h3{font-family:var(--fd);font-size:12px;font-weight:800;color:var(--text);margin:8px 0 4px;letter-spacing:-.01em}
.msg-bubble ul{padding-left:16px;margin:6px 0}
.msg-bubble ul li{margin:3px 0;color:var(--text2)}

/* PLACEMENT UI */
.placement-card{background:linear-gradient(145deg,var(--bg3),var(--bg2));border:.5px solid var(--border2);border-radius:12px;overflow:hidden;margin-bottom:10px}
.placement-card-header{padding:9px 14px;border-bottom:.5px solid var(--border);background:var(--bg3);font-size:9px;font-weight:700;color:var(--text);text-transform:uppercase;letter-spacing:.1em;font-family:var(--fb);display:flex;align-items:center;gap:6px}
.placement-card-body{padding:10px 14px;display:flex;flex-direction:column;gap:6px}
.placement-row{display:flex;align-items:flex-start;gap:10px;font-size:10px}
.placement-label{min-width:90px;flex-shrink:0;font-size:9px;color:var(--text3);text-transform:uppercase;letter-spacing:.08em;padding-top:1px;font-family:var(--fb)}
.placement-val{color:var(--text2);flex:1;line-height:1.5;font-family:var(--fb)}
.placement-path{color:var(--c1);font-family:var(--fm);font-size:10px}
.placement-badge{display:inline-flex;align-items:center;gap:5px;padding:3px 10px;border-radius:20px;font-size:9px;font-weight:700;font-family:var(--fb)}
.placement-badge.server{background:rgba(239,68,68,0.1);color:#f87171;border:.5px solid rgba(239,68,68,0.25)}
.placement-badge.local{background:var(--c1d);color:var(--c1);border:.5px solid rgba(0,240,255,0.2)}
.placement-badge.module{background:var(--c2d);color:#a78bfa;border:.5px solid rgba(139,92,246,0.25)}

/* FILES LIST */
.files-list{background:linear-gradient(145deg,var(--bg3),var(--bg2));border:.5px solid var(--border2);border-radius:12px;overflow:hidden;margin-bottom:10px}
.files-list-header{padding:9px 14px;border-bottom:.5px solid var(--border);background:var(--bg3);font-size:9px;font-weight:700;color:var(--text);text-transform:uppercase;letter-spacing:.1em;font-family:var(--fb);display:flex;align-items:center;justify-content:space-between}
.files-count{font-size:8px;padding:1px 6px;background:var(--bg4);border:.5px solid var(--border);border-radius:8px;color:var(--text2);font-weight:400}
.file-row{display:flex;align-items:center;gap:8px;padding:7px 14px;border-bottom:.5px solid var(--border);font-size:10px;font-family:var(--fb);transition:background .12s}
.file-row:last-child{border-bottom:none}
.file-row:hover{background:rgba(255,255,255,0.02)}
.file-type-badge{font-size:8px;padding:2px 8px;border-radius:10px;font-weight:700;flex-shrink:0;min-width:88px;text-align:center}
.file-type-badge.server{background:rgba(239,68,68,0.1);color:#f87171;border:.5px solid rgba(239,68,68,0.2)}
.file-type-badge.local{background:var(--c1d);color:var(--c1);border:.5px solid rgba(0,240,255,0.15)}
.file-type-badge.module{background:var(--c2d);color:#a78bfa;border:.5px solid rgba(139,92,246,0.2)}
.file-name{color:var(--text);font-weight:600;flex-shrink:0;min-width:150px;font-size:10px;letter-spacing:-.01em}
.file-path{color:var(--text3);font-size:9px;font-family:var(--fm);flex:1}
.file-copy-btn{margin-left:auto;font-size:8px;color:var(--text3);cursor:pointer;padding:3px 8px;border:.5px solid var(--border);border-radius:4px;background:transparent;transition:all .15s;flex-shrink:0;font-family:var(--fm)}
.file-copy-btn:hover{border-color:var(--c1);color:var(--c1);background:var(--c1d)}

/* SCRIPT ACTIONS */
.script-actions{display:flex;align-items:center;gap:6px;margin-top:10px;flex-wrap:wrap}
.sact-btn{display:flex;align-items:center;gap:5px;padding:7px 13px;background:var(--bg3);border:.5px solid var(--border2);border-radius:8px;font-size:9px;color:var(--text2);cursor:pointer;transition:all .15s;font-family:var(--fb);white-space:nowrap;font-weight:500}
.sact-btn:hover{border-color:var(--c1);color:var(--c1)}
.sact-btn:active{transform:scale(0.97)}
.sact-btn.prim{background:rgba(0,240,255,0.08);color:var(--c1);border-color:rgba(0,240,255,0.25);font-weight:700}
.sact-btn.prim:hover{background:var(--c1);color:#030508;box-shadow:0 0 24px rgba(0,240,255,0.3)}
.sact-btn.grn{background:var(--c3d);border-color:rgba(16,185,129,0.25);color:var(--c3)}
.sact-btn.grn:hover{background:var(--c3);color:#030508}
.sact-btn.pur{background:var(--c2d);border-color:rgba(139,92,246,0.25);color:#a78bfa}
.sact-btn.pur:hover{background:var(--c2);color:white}

/* REPLACE NOTICE */
.replace-notice{background:rgba(245,158,11,0.05);border:.5px solid rgba(245,158,11,0.18);border-radius:10px;padding:12px 15px;margin-top:10px}
.replace-notice-title{display:flex;align-items:center;gap:6px;font-weight:700;color:var(--c4);margin-bottom:8px;font-size:10px;font-family:var(--fb)}
.replace-item{display:flex;align-items:flex-start;gap:8px;padding:5px 0;font-size:10px;border-bottom:.5px solid rgba(255,255,255,0.03);font-family:var(--fb)}
.replace-item:last-child{border-bottom:none}
.replace-key{color:var(--c4);font-weight:700;min-width:180px;flex-shrink:0;font-family:var(--fm);font-size:9px}
.replace-val{color:var(--text2)}

/* TYPING */
.typing-row{display:flex;gap:13px;padding:8px 24px;align-items:flex-start}
.typing-dots{display:flex;gap:4px;padding:6px 2px}
.typing-dots span{width:5px;height:5px;border-radius:50%;background:var(--c2);animation:td .9s infinite both}
.typing-dots span:nth-child(2){animation-delay:.2s}
.typing-dots span:nth-child(3){animation-delay:.4s}
@keyframes td{0%,80%,100%{opacity:.2;transform:scale(.75)}40%{opacity:1;transform:scale(1)}}
.stream-cursor::after{content:'▋';animation:blink .7s infinite;color:var(--c1);font-size:10px;margin-left:2px}
@keyframes blink{0%,100%{opacity:1}50%{opacity:0}}

/* ══════════════════ INPUT ══════════════════ */
.input-area{padding:12px 20px 18px;flex-shrink:0;border-top:.5px solid var(--border);background:linear-gradient(0deg,var(--bg) 70%,transparent)}
.input-wrap{max-width:800px;margin:0 auto;background:linear-gradient(145deg,var(--bg2),var(--bg3));border:.5px solid var(--border2);border-radius:16px;overflow:hidden;transition:border-color .25s,box-shadow .25s}
.input-wrap:focus-within{border-color:rgba(139,92,246,0.4);box-shadow:0 0 0 4px rgba(139,92,246,0.05),0 8px 32px rgba(0,0,0,0.3)}
.input-top{display:flex;align-items:flex-end;padding:11px 13px 9px}
.main-input{flex:1;background:transparent;border:none;outline:none;font-family:var(--fm);font-size:12px;color:var(--text);resize:none;line-height:1.75;max-height:180px;min-height:22px}
.main-input::placeholder{color:var(--text3)}
.send-btn{width:36px;height:36px;border-radius:9px;background:var(--c2);color:white;border:none;cursor:pointer;display:flex;align-items:center;justify-content:center;font-size:14px;transition:all .15s;flex-shrink:0;margin-left:9px;align-self:flex-end;position:relative;overflow:hidden}
.send-btn::after{content:'';position:absolute;inset:0;background:linear-gradient(135deg,rgba(255,255,255,0.15),transparent);pointer-events:none}
.send-btn:hover{background:#7c3aed;box-shadow:0 0 24px rgba(139,92,246,0.5);transform:scale(1.05)}
.send-btn:active{transform:scale(0.97)}
.send-btn:disabled{opacity:.3;cursor:not-allowed;transform:none}
.input-bottom{padding:6px 13px 10px;display:flex;align-items:center;gap:5px;border-top:.5px solid var(--border);flex-wrap:wrap}
.quick-chip{padding:3px 10px;background:transparent;border:.5px solid var(--border);border-radius:12px;font-size:8px;color:var(--text3);cursor:pointer;font-family:var(--fb);transition:all .12s;white-space:nowrap;font-weight:500}
.quick-chip:hover{border-color:rgba(139,92,246,0.4);color:#a78bfa;background:var(--c2d)}
.quick-chip:active{transform:scale(0.96)}
.input-hint{margin-left:auto;font-size:8px;color:var(--text3);white-space:nowrap;font-family:var(--fb)}
.char-counter{font-size:8px;color:var(--text3);font-family:var(--fb);margin-left:4px}
.char-counter.warn{color:var(--c4)}

/* TOASTS */
#toasts{position:fixed;bottom:1.2rem;right:1.2rem;display:flex;flex-direction:column;gap:6px;z-index:9999}
.toast{background:var(--bg2);border:.5px solid var(--border2);border-radius:10px;padding:10px 15px;font-size:10px;display:flex;align-items:center;gap:9px;min-width:220px;max-width:380px;animation:tin .2s ease;line-height:1.6;font-family:var(--fb);box-shadow:0 8px 24px rgba(0,0,0,0.4)}
.toast.ok{border-left:2px solid var(--c3)}
.toast.bad{border-left:2px solid var(--c5)}
.toast.info{border-left:2px solid var(--c1)}
.toast.gold{border-left:2px solid var(--c4)}
@keyframes tin{from{opacity:0;transform:translateX(18px)}to{opacity:1;transform:translateX(0)}}

/* SHORTCUTS PANEL */
.shortcuts-panel{position:fixed;inset:0;background:rgba(3,5,8,0.85);z-index:500;display:none;align-items:center;justify-content:center;backdrop-filter:blur(10px)}
.shortcuts-panel.show{display:flex}
.shortcuts-card{background:var(--bg2);border:.5px solid var(--border3);border-radius:16px;padding:1.8rem;min-width:420px;max-width:500px;box-shadow:0 32px 80px rgba(0,0,0,0.6)}
.shortcuts-card h3{font-family:var(--fd);font-size:16px;font-weight:900;margin-bottom:1.2rem;color:var(--text)}
.shortcut-row{display:flex;align-items:center;justify-content:space-between;padding:8px 0;border-bottom:.5px solid var(--border)}
.shortcut-row:last-child{border-bottom:none}
.shortcut-desc{font-size:11px;color:var(--text2);font-family:var(--fb)}
.shortcut-key{display:flex;gap:4px}
.key{padding:3px 8px;background:var(--bg3);border:.5px solid var(--border2);border-radius:5px;font-family:var(--fm);font-size:9px;color:var(--text)}

/* STATS BAR */
.stats-bar{display:flex;align-items:center;gap:1px;padding:6px 10px;border-bottom:.5px solid var(--border);background:var(--bg3);flex-shrink:0}
.stat-item{flex:1;display:flex;align-items:center;justify-content:center;gap:5px;padding:5px;border-radius:6px;cursor:default}
.stat-item:hover{background:var(--bg4)}
.stat-icon{font-size:11px}
.stat-label{font-size:8px;color:var(--text3);font-family:var(--fb);text-transform:uppercase;letter-spacing:.08em}
.stat-val{font-size:11px;font-weight:700;font-family:var(--fd);color:var(--text)}
.stat-divider{width:.5px;height:20px;background:var(--border)}

/* THEME TOGGLE */
.theme-toggle{position:relative}

/* EMPTY STATE */
.empty-history{padding:20px 8px;text-align:center}
.empty-history-icon{font-size:28px;margin-bottom:8px}
.empty-history-text{font-size:10px;color:var(--text3);line-height:1.7;font-family:var(--fb)}

/* RESPONSIVE CHIPS */
.chip-group{display:flex;gap:4px;flex-wrap:wrap;padding:0 0 6px}

/* ACTIVE INDICATOR */
.live-dot{width:6px;height:6px;border-radius:50%;background:var(--c3);animation:livePulse 2s infinite;flex-shrink:0}
@keyframes livePulse{0%,100%{box-shadow:0 0 0 0 rgba(16,185,129,0.4)}50%{box-shadow:0 0 0 4px rgba(16,185,129,0)}}
</style>
</head>
<body>

<!-- AUTH -->
<div id="auth">
  <div class="auth-orbs"><div class="auth-orb"></div><div class="auth-orb"></div><div class="auth-orb"></div></div>
  <div class="auth-wrap">
    <div class="auth-brand">
      <div style="position:relative">
        <div class="auth-brand-mark-glow"></div>
        <div class="auth-brand-mark">✦</div>
      </div>
      <div class="auth-brand-info">
        <div class="name">Studio Bridge</div>
        <div class="ver">Version 5 · Ultra Edition · Claude Powered</div>
      </div>
    </div>
    <div class="auth-card">
      <h2>The Ultimate Roblox Dev Studio</h2>
      <p>Claude AI built-in — no API keys, no setup. Auto-detects Fast ⚡, Balanced ✦ &amp; Genius 🧠 modes. 60+ templates, 200+ knowledge topics, full script naming, placement detection, copy-ready code.</p>
      <div class="auth-features">
        <div class="auth-feat"><div class="auth-feat-dot" style="background:var(--c1)"></div>60+ Script Templates</div>
        <div class="auth-feat"><div class="auth-feat-dot" style="background:var(--c3)"></div>200+ Knowledge Topics</div>
        <div class="auth-feat"><div class="auth-feat-dot" style="background:var(--c2)"></div>Auto Script Placement</div>
        <div class="auth-feat"><div class="auth-feat-dot" style="background:var(--c4)"></div>Smart Model Selection</div>
        <div class="auth-feat"><div class="auth-feat-dot" style="background:var(--c6)"></div>3D Model Builders</div>
        <div class="auth-feat"><div class="auth-feat-dot" style="background:var(--c7)"></div>Framework Templates</div>
      </div>
      <div class="field">
        <label>Your Roblox Username</label>
        <input type="text" id="rbx-username" placeholder="Enter your username…" autocomplete="off" autofocus onkeydown="if(event.key==='Enter')startApp()"/>
      </div>
      <div id="auth-err" class="auth-err">⚠ Please enter your username to continue.</div>
      <button class="btn-main" onclick="startApp()">Launch Studio Bridge v5 →</button>
      <div class="auth-stats">
        <div class="auth-stat"><div class="auth-stat-num">60+</div><div class="auth-stat-label">Templates</div></div>
        <div class="auth-stat"><div class="auth-stat-num">200+</div><div class="auth-stat-label">Topics</div></div>
        <div class="auth-stat"><div class="auth-stat-num">3</div><div class="auth-stat-label">AI Modes</div></div>
        <div class="auth-stat"><div class="auth-stat-num">∞</div><div class="auth-stat-label">Chats</div></div>
      </div>
    </div>
  </div>
</div>

<!-- SHORTCUTS PANEL -->
<div class="shortcuts-panel" id="shortcuts-panel" onclick="closeShortcuts(event)">
  <div class="shortcuts-card">
    <h3>⌨ Keyboard Shortcuts</h3>
    <div class="shortcut-row"><span class="shortcut-desc">Send message</span><span class="shortcut-key"><span class="key">Enter</span></span></div>
    <div class="shortcut-row"><span class="shortcut-desc">New line</span><span class="shortcut-key"><span class="key">Shift</span><span class="key">Enter</span></span></div>
    <div class="shortcut-row"><span class="shortcut-desc">New conversation</span><span class="shortcut-key"><span class="key">Ctrl</span><span class="key">K</span></span></div>
    <div class="shortcut-row"><span class="shortcut-desc">Focus input</span><span class="shortcut-key"><span class="key">Ctrl</span><span class="key">/</span></span></div>
    <div class="shortcut-row"><span class="shortcut-desc">Toggle sidebar</span><span class="shortcut-key"><span class="key">Ctrl</span><span class="key">B</span></span></div>
    <div class="shortcut-row"><span class="shortcut-desc">Show shortcuts</span><span class="shortcut-key"><span class="key">Ctrl</span><span class="key">?</span></span></div>
    <div class="shortcut-row"><span class="shortcut-desc">Copy last code</span><span class="shortcut-key"><span class="key">Ctrl</span><span class="key">Shift</span><span class="key">C</span></span></div>
    <div class="shortcut-row"><span class="shortcut-desc">Close / cancel</span><span class="shortcut-key"><span class="key">Esc</span></span></div>
  </div>
</div>

<!-- APP -->
<div id="app">
  <!-- TOPBAR -->
  <div class="topbar">
    <div class="topbar-brand">
      <div class="topbar-brand-mark">✦</div>
      <div class="topbar-brand-name">Studio Bridge</div>
      <span class="topbar-brand-ver">v5 ULTRA</span>
    </div>
    <div class="topbar-sep"></div>
    <div class="model-badge balanced" id="model-badge"><div class="live-dot"></div><span class="model-dot"></span><span id="model-badge-txt">Balanced ✦</span></div>
    <div class="topbar-sep"></div>
    <div class="topbar-center">
      <div class="topbar-stat">💬 <span class="topbar-stat-val" id="stat-msgs">0</span> msgs</div>
      <div class="topbar-stat">📁 <span class="topbar-stat-val" id="stat-chats">0</span> chats</div>
      <div class="topbar-stat">📋 <span class="topbar-stat-val" id="stat-copied">0</span> copied</div>
    </div>
    <div class="topbar-right">
      <div class="icon-btn" onclick="showShortcuts()" title="Keyboard shortcuts">⌨</div>
      <div class="icon-btn" onclick="toggleSidebar()" title="Toggle sidebar" id="sidebar-toggle">◀</div>
      <div class="user-chip">
        <div class="user-ava" id="top-ava">?</div>
        <span class="user-name" id="top-name">—</span>
        <span class="logout-btn" onclick="logout()" title="Logout">⏻</span>
      </div>
    </div>
  </div>

  <div class="app-body">
    <!-- SIDEBAR -->
    <div class="sidebar" id="sidebar">
      <div class="sidebar-top">
        <button class="new-chat-btn" onclick="newChat()"><span>✦</span> New Chat <span style="margin-left:auto;font-size:16px">+</span></button>
      </div>
      <div class="sidebar-search">
        <input class="sidebar-search-input" type="text" placeholder="🔍 Search templates…" id="template-search" oninput="filterTemplates(this.value)"/>
      </div>
      <div class="tmpl-tabs" id="tmpl-tabs">
        <div class="tmpl-tab active" onclick="switchTab('history',this)">History</div>
        <div class="tmpl-tab" onclick="switchTab('starter',this)">Starter</div>
        <div class="tmpl-tab" onclick="switchTab('scripting',this)">Scripts</div>
        <div class="tmpl-tab" onclick="switchTab('gui',this)">GUI</div>
        <div class="tmpl-tab" onclick="switchTab('systems',this)">Systems</div>
        <div class="tmpl-tab" onclick="switchTab('building',this)">Build</div>
        <div class="tmpl-tab" onclick="switchTab('advanced',this)">Advanced</div>
        <div class="tmpl-tab" onclick="switchTab('frameworks',this)">Frameworks</div>
        <div class="tmpl-tab" onclick="switchTab('pro',this)">Pro</div>
      </div>

      <div class="tmpl-panel active" id="panel-history">
        <div id="chat-history"><div class="empty-history"><div class="empty-history-icon">💬</div><div class="empty-history-text">No conversations yet.<br>Ask anything to get started!</div></div></div>
      </div>
      <div class="tmpl-panel" id="panel-starter"><div id="starter-tools"></div></div>
      <div class="tmpl-panel" id="panel-scripting"><div id="scripting-tools"></div></div>
      <div class="tmpl-panel" id="panel-gui"><div id="gui-tools"></div></div>
      <div class="tmpl-panel" id="panel-systems"><div id="systems-tools"></div></div>
      <div class="tmpl-panel" id="panel-building"><div id="building-tools"></div></div>
      <div class="tmpl-panel" id="panel-advanced"><div id="advanced-tools"></div></div>
      <div class="tmpl-panel" id="panel-frameworks"><div id="frameworks-tools"></div></div>
      <div class="tmpl-panel" id="panel-pro"><div id="pro-tools"></div></div>
    </div>

    <!-- CHAT MAIN -->
    <div class="chat-main">
      <div class="welcome-screen" id="welcome-screen">
        <div class="welcome-glow"></div>
        <div class="welcome-logo">✦</div>
        <div class="welcome-title">What can I help you build?</div>
        <div class="welcome-sub">Studio Bridge v5 Ultra — Claude AI with 60+ templates, 200+ Roblox knowledge topics, auto script detection, placement guidance, and streaming responses.</div>
        <div class="welcome-badges">
          <div class="welcome-badge wb-cyan">⚡ Fast Mode</div>
          <div class="welcome-badge wb-purple">✦ Balanced Mode</div>
          <div class="welcome-badge wb-green">🧠 Genius Mode</div>
          <div class="welcome-badge wb-orange">📁 60+ Templates</div>
        </div>
        <div class="suggestion-grid">
          <div class="suggestion" onclick="quickPrompt('Build a complete coin pickup system: spinning coins on the ground with glow effect, particle burst on pickup, leaderboard stat, DataStore save/load with pcall retry and BindToClose.')"><div class="sug-icon">🪙</div><div class="sug-title">Coin System</div><div class="sug-body">Animated coins, leaderboard, DataStore</div></div>
          <div class="suggestion" onclick="quickPrompt('Build an advanced 3-phase boss NPC with pathfinding, AoE slam attack, ranged projectile phase, shield mechanic, billboard health bar, loot drop table, and respawn timer.')"><div class="sug-icon">💀</div><div class="sug-title">Boss NPC</div><div class="sug-body">3-phase boss with attacks and drops</div></div>
          <div class="suggestion" onclick="quickPrompt('Create a complete round-based game loop: lobby with map voting (3 options), player teleport, round timer GUI, winner detection, kill streak announcements, stat saving, intermission countdown, repeat indefinitely.')"><div class="sug-icon">🎮</div><div class="sug-title">Round System</div><div class="sug-body">Lobby → vote → round → winner → repeat</div></div>
          <div class="suggestion" onclick="quickPrompt('Set up a complete Knit framework game template: KnitServer loader, KnitClient loader, CurrencyService with client-exposed GetCoins and AddCoins methods, CurrencyController with HUD GUI updates via signals.')"><div class="sug-icon">⚙️</div><div class="sug-title">Knit Framework</div><div class="sug-body">Service/Controller architecture</div></div>
          <div class="suggestion" onclick="quickPrompt('Build a detailed procedural 3D castle in Lua using only BaseParts and WeldConstraints: 4 corner towers with battlements, surrounding walls, main keep with arched gate, drawbridge, flag poles and moat foundation. All positioned with CFrame math.')"><div class="sug-icon">🏰</div><div class="sug-title">3D Castle Builder</div><div class="sug-body">Procedural castle from pure Lua</div></div>
          <div class="suggestion" onclick="quickPrompt('Create a full ProfileService + Leaderstats template: profile loading with session locking, default data table (Coins, Gems, Level, XP, Wins, PlayTime), leaderstats auto-binding, BindToClose save, data migration support.')"><div class="sug-icon">💾</div><div class="sug-title">ProfileService Setup</div><div class="sug-body">Production-ready data management</div></div>
        </div>
      </div>

      <div class="messages-wrap hidden" id="messages-wrap">
        <div id="messages-inner"></div>
      </div>

      <div class="input-area">
        <div class="input-wrap">
          <div class="input-top">
            <textarea class="main-input" id="main-input" placeholder="Ask about scripts, 3D models, GUI, frameworks, systems… anything Roblox!" rows="1" onkeydown="inputKey(event)" oninput="autoResize(this);updateCharCounter()"></textarea>
            <button class="send-btn" id="send-btn" onclick="sendMessage()" title="Send (Enter)">▶</button>
          </div>
          <div class="input-bottom">
            <span class="quick-chip" onclick="quickPrompt('Show me the complete RemoteEvent flow: client fires, server validates, server responds. Include rate limiting and exploit prevention.')">RemoteEvents</span>
            <span class="quick-chip" onclick="quickPrompt('ProfileService vs DataStore2 vs raw DataStore — which should I use for a large game and why?')">ProfileService</span>
            <span class="quick-chip" onclick="quickPrompt('Build a complete anti-exploit suite: position sanity checks, speed hack detection, RemoteEvent rate limiter, value sanity validator, auto-kick with logging.')">Anti-Cheat</span>
            <span class="quick-chip" onclick="quickPrompt('Create a complete pet system: pet catalog with rarities, egg opening with animation, pet following with smooth lerp, stat boosts, equip/unequip, DataStore saving.')">Pet System</span>
            <span class="quick-chip" onclick="quickPrompt('Build a realistic 3D sword using BaseParts and WeldConstraints: blade with taper, crossguard, leather-wrapped grip with diagonal wraps, pommel sphere. Full Lua script.')">3D Sword</span>
            <span class="quick-chip" onclick="quickPrompt('Create a complete tycoon system: purchase buttons with cost labels, collector droppers with conveyor, upgrade tiers with multipliers, cash display GUI, auto-save every 30 seconds.')">Tycoon</span>
            <span class="quick-chip" onclick="quickPrompt('Explain Parallel Luau with Actors. Show me how to offload pathfinding grid computation to worker scripts.')">Parallel Luau</span>
            <span class="quick-chip" onclick="quickPrompt('Build a complete in-game shop: GUI with categories, item cards with preview, currency check, purchase animation, gamepass items, DataStore inventory saving.')">Shop System</span>
            <span class="input-hint">Enter ↵ send · Shift+Enter line · Ctrl+K new chat</span>
            <span class="char-counter" id="char-counter"></span>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<div id="toasts"></div>

<script>
// ══════════════════════════════════════════════════════════
// CONSTANTS
// ══════════════════════════════════════════════════════════
const ANTHROPIC_API = "https://api.anthropic.com/v1/messages";
const CLAUDE_MODEL  = "claude-sonnet-4-20250514";
const MAX_TOKENS    = { fast:1800, balanced:5000, genius:9000 };

const MODELS = {
  fast:     { label:"Fast ⚡",    cls:"fast"    },
  balanced: { label:"Balanced ✦", cls:"balanced" },
  genius:   { label:"Genius 🧠",  cls:"genius"  }
};

// ══════════════════════════════════════════════════════════
// CODE STORE
// ══════════════════════════════════════════════════════════
const CODE_STORE = new Map(); let csIdx = 0;
function csSet(code){ const id=++csIdx; CODE_STORE.set(id,code); return id; }
function csGet(id){ return CODE_STORE.get(Number(id))||''; }

// ══════════════════════════════════════════════════════════
// TEMPLATES — MASSIVELY EXPANDED
// ══════════════════════════════════════════════════════════
const TEMPLATES = {
  starter:[
    {icon:"🪙",title:"Coin System",desc:"Pickup, leaderboard, DataStore",badge:"",prompt:"Build a complete coin pickup system: spinning coins on the ground with glow effect, leaderboard, DataStore save with pcall retry. Name all scripts."},
    {icon:"❤️",title:"Health System",desc:"Custom health, regen, shield",badge:"",prompt:"Build a custom health system: max health, regen over time, shield that absorbs damage, death/respawn with fade, GUI health bar. Name all scripts."},
    {icon:"🎮",title:"Round System",desc:"Lobby → round → winner → repeat",badge:"",prompt:"Create a complete round-based system: lobby countdown, player teleport to arena, round timer GUI, winner announcement, intermission, repeat. Name all scripts."},
    {icon:"💾",title:"DataStore Basic",desc:"Save/load with retry + BindToClose",badge:"",prompt:"Build a basic DataStore system: save and load player data with pcall retries, BindToClose, and default data. Name all scripts DataManager."},
    {icon:"🖥️",title:"GUI Panel",desc:"Animated dark-theme panel",badge:"",prompt:"Create an animated GUI panel: dark theme, slide-in animation with TweenService, UICorner, UIStroke, close button. Name the LocalScript properly."},
    {icon:"🤖",title:"NPC Basic",desc:"Patrol, aggro, attack, cleanup",badge:"",prompt:"Create a basic pathfinding NPC: patrol waypoints, aggro on player sight, melee attack with damage, health bar GUI, death cleanup. Name the script."},
    {icon:"🔊",title:"Sound Manager",desc:"BGM, SFX, volume, zones",badge:"new",prompt:"Build a SoundManager ModuleScript: background music queue, SFX with pitch variation, master volume control, zone ambient audio. Name it SoundManager in ReplicatedStorage."},
    {icon:"⌨️",title:"Keybind System",desc:"ContextActionService + settings",badge:"",prompt:"Create a keybind system with ContextActionService, settings GUI showing all bindings, rebind support. Name the LocalScript KeybindController."},
    {icon:"🏁",title:"Spawn System",desc:"Teams, spawn points, protection",badge:"",prompt:"Build a team spawn system: assign teams on join, random spawn point selection per team, 5-second spawn protection with ForceField GUI indicator. Name all scripts."},
    {icon:"📊",title:"Leaderboard",desc:"Stats, sorting, DataStore ranks",badge:"",prompt:"Create a full leaderboard: in-game stats (Kills, Deaths, KD, Wins), DataStore persisted values, sorted GUI leaderboard panel, update on stat change. Name all scripts."},
  ],
  scripting:[
    {icon:"📡",title:"RemoteEvent System",desc:"Server/client bridge + rate limit",badge:"",prompt:"Build a complete RemoteEvent manager: centralized remote folder in ReplicatedStorage, server-side validation, rate limiting, client feedback. Name the scripts RemoteHandler and RemoteClient."},
    {icon:"🔄",title:"ModuleScript Library",desc:"Utility functions, OOP class",badge:"",prompt:"Create a utility ModuleScript library: math helpers (clamp, lerp, map), table utils (deepCopy, merge, contains), string utils, OOP base class. Name it Utils in ReplicatedStorage."},
    {icon:"⏱️",title:"Task Manager",desc:"Scheduled tasks, cleanup on leave",badge:"",prompt:"Build a server-side task manager: schedule repeating tasks, one-shot delays, player-bound tasks that auto-cancel on leave, task cancellation API. Name it TaskManager."},
    {icon:"🎯",title:"Hitbox System",desc:"Accurate melee hitbox detection",badge:"",prompt:"Build a melee hitbox system: client swings, server validates via GetPartsInRadius with CFrame, damage with IFrames, multiple hit targets, debug visualization mode. Name all scripts."},
    {icon:"🧩",title:"Event Signal Module",desc:"Custom Signal class like Knit",badge:"",prompt:"Build a custom Signal ModuleScript: :Connect(), :Once(), :Fire(), :DisconnectAll(), :Destroy(). Mirror Roblox RBXScriptSignal API. Name it Signal in ReplicatedStorage."},
    {icon:"⚡",title:"Promise Module",desc:"Async flow with .andThen .catch",badge:"",prompt:"Implement a basic Promise ModuleScript for Roblox: new(), andThen(), catch(), finally(), Promise.all(), Promise.race(), reject() and resolve(). Name it Promise in ReplicatedStorage."},
    {icon:"🗂️",title:"State Machine",desc:"Enum states, transitions, events",badge:"",prompt:"Build a StateMachine ModuleScript: define states as enums, register transitions with guards, enter/exit callbacks, :GetState(), :TransitionTo(). Name it StateMachine."},
    {icon:"🔁",title:"Object Pool",desc:"Pre-create and reuse instances",badge:"",prompt:"Build an object pool ModuleScript for projectiles/effects: pre-create N instances, :Get() pulls from pool, :Return() recycles, auto-grow when empty. Name it ObjectPool in ReplicatedStorage."},
    {icon:"📦",title:"Asset Loader",desc:"Preload assets, loading screen",badge:"",prompt:"Build an asset preloader: ContentProvider:PreloadAsync() on a list of asset IDs, animated loading screen with progress bar, fade out on complete. Name the LocalScript AssetLoader."},
    {icon:"🔐",title:"Admin Commands",desc:"6 rank tiers, 20+ commands",badge:"adv",prompt:"Create a complete admin system: 6 rank tiers (Player, VIP, Mod, Admin, SuperAdmin, Owner), 20+ commands (kick, ban, tp, warn, mute, freeze, give, setspeed, setgrav, fog, time, announce, fly, god, ungod), chat command parser, GUI panel, log to DataStore. Name all scripts."},
  ],
  gui:[
    {icon:"❤️",title:"Health Bar",desc:"Animated HP bar with regen",badge:"",prompt:"Build an animated health bar GUI: smooth tween on damage, color shift (green→yellow→red), shield overlay, regen pulse animation, numeric display. Name the LocalScript HealthBarUI."},
    {icon:"🎒",title:"Inventory GUI",desc:"Grid, tooltips, equip, stack",badge:"",prompt:"Create a complete inventory GUI: scrolling grid layout, item icons with rarity colors, hover tooltips with stats, equip/unequip toggle, item stacking display, sort button. Name the LocalScript InventoryUI."},
    {icon:"🛍️",title:"Shop GUI",desc:"Categories, cart, gamepass items",badge:"",prompt:"Build a full shop GUI: category tabs (Weapons, Armor, Potions, Cosmetics), item cards with preview image and stats, buy button with currency check, gamepass items with lock icon, purchase animation. Name all scripts."},
    {icon:"📣",title:"Notification System",desc:"Stack, slide, auto-dismiss",badge:"",prompt:"Create a notification system: slide-in from top-right, stack multiple notifications, auto-dismiss with timer bar, types (info/success/warning/error) with color coding, max 5 visible. Name the LocalScript NotificationSystem."},
    {icon:"🗺️",title:"Minimap",desc:"Overhead camera, player dots",badge:"",prompt:"Build a minimap: ViewportFrame with top-down camera following player, colored dots for teammates/enemies, rotation matching player direction, zoom toggle, landmark icons. Name the LocalScript MinimapUI."},
    {icon:"💬",title:"Chat Bubbles",desc:"NPC chat, fade, multi-line",badge:"",prompt:"Create a chat bubble system for NPCs: BillboardGui above head, UICorner rounded bubble, typewriter text effect, auto-size to content, fade out after duration, queue multiple messages. Name the ModuleScript ChatBubbleModule."},
    {icon:"🎯",title:"Crosshair",desc:"Dynamic spread, hit marker",badge:"",prompt:"Build a dynamic crosshair GUI: 4-line crosshair that spreads on movement, shrinks when aiming, hit marker flash on damage, kill marker with sound, customizable colors and thickness. Name the LocalScript CrosshairUI."},
    {icon:"🏆",title:"Kill Feed",desc:"Sliding kill notifications",badge:"",prompt:"Build a kill feed: slides in from right, shows killer icon, weapon icon, victim icon, shows headshot crown, fades after 5s, max 5 entries, color-coded for player kills. Name the LocalScript KillFeedUI."},
    {icon:"📋",title:"Quest UI",desc:"Quest tracker, objectives, rewards",badge:"",prompt:"Create a quest tracker GUI: active quest panel with objectives (checkable list), XP/coin reward preview, progress bars for collection quests, complete animation, scrollable quest log. Name all scripts."},
    {icon:"⚙️",title:"Settings Menu",desc:"Graphics, audio, controls tabs",badge:"",prompt:"Build a settings menu GUI: tabs (Graphics, Audio, Controls, Gameplay), sliders with live preview, toggle switches, reset to defaults button, save settings to DataStore. Name the LocalScript SettingsUI."},
    {icon:"📱",title:"Mobile UI",desc:"Mobile-optimized touch controls",badge:"",prompt:"Build mobile-optimized UI: large touch buttons (44px+), D-pad for movement, action buttons with icons, auto-hide when using keyboard, thumbstick support. Name the LocalScript MobileControls."},
    {icon:"🎪",title:"Dialog System",desc:"NPC dialog, choices, branching",badge:"",prompt:"Build an NPC dialog system: typewriter text effect, portrait image, choice buttons branching to different paths, shop trigger, quest accept, emotion support. Name all scripts."},
  ],
  systems:[
    {icon:"⚔️",title:"Combat System",desc:"Combos, hitbox, knockback, anims",badge:"adv",prompt:"Build a full melee combat system: 3-hit combo with timing window, server hitbox validation, knockback with velocity, hit particles, camera shake on hit, stun mechanic, block/parry, animation tracks. Name all scripts."},
    {icon:"🔫",title:"Gun System",desc:"Raycast, damage, ammo, ADS",badge:"adv",prompt:"Build a complete raycast gun system: client raycast, server validation, damage with headshot multiplier (1.5x), ammo/magazine system, reload animation, ADS zoom, bullet hole decal, muzzle flash particle, recoil camera shake, ammo HUD. Name all scripts."},
    {icon:"🐾",title:"Pet System",desc:"Eggs, rarities, stat boosts, save",badge:"adv",prompt:"Build a full pet system: pet catalog with 5 rarities (Common→Legendary) with percentages, egg opening animation with spin + reveal, pets follow player with smooth lerp, stat boosts (speed, jump, coin multiplier), equip/unequip, DataStore saving. Name all scripts."},
    {icon:"💰",title:"Economy System",desc:"Currency, shop, transfers, logs",badge:"adv",prompt:"Build a complete game economy: server-side currency manager (Coins + Gems), player-to-player transfers with confirmation, shop purchase validation, daily reward system, transaction log to DataStore, exploit prevention. Name all scripts."},
    {icon:"🗺️",title:"Map Voting",desc:"3 maps, live votes, load/unload",badge:"adv",prompt:"Create a map voting system: 3 random maps from pool, vote GUI with real-time counters, countdown timer, winner loads from ServerStorage via folder, losing maps fade out, unload after round. Name all scripts."},
    {icon:"🌊",title:"Wave System",desc:"Enemy waves, scaling, rewards",badge:"adv",prompt:"Build a wave defense system: spawn waves of enemies with increasing count and stat scaling, enemy type variety, wave complete rewards (coins + XP), wave counter GUI, boss wave every 5 rounds. Name all scripts."},
    {icon:"🏗️",title:"Building System",desc:"Grid snapping, rotate, delete",badge:"adv",prompt:"Build a player building system: grid-snapped placement on surfaces, rotation (90° increments), delete mode, part preview ghost before place, collision check before confirming, object limit per player, save placed objects to DataStore. Name all scripts."},
    {icon:"🚗",title:"Vehicle System",desc:"Drive, seats, turbo, damage",badge:"adv",prompt:"Build a complete vehicle system: VehicleSeat setup, smooth acceleration/braking, drifting physics, boost/turbo mechanic with cooldown, vehicle health and damage model, flip recovery, passenger seats, horn. Name all scripts."},
    {icon:"🌙",title:"Day/Night Cycle",desc:"Smooth cycle, time sync, events",badge:"",prompt:"Build a day/night cycle: smooth ClockTime progression server-side, sync to all clients, ambient color transitions (dawn/day/dusk/night), fire torch Pointlights auto-toggle at night, weather event hook. Name all scripts."},
    {icon:"🌦️",title:"Weather System",desc:"Rain, snow, fog, lightning",badge:"new",prompt:"Build a weather system: rain (ParticleEmitters + sound + puddle decals), snow (particles + accumulation), fog (Atmosphere tweening), lightning (flash + thunder delay based on distance). Weather transitions smoothly. Name all scripts."},
    {icon:"⚗️",title:"Crafting System",desc:"Recipes, inventory, crafting UI",badge:"adv",prompt:"Build a crafting system: recipe table (ModuleScript), inventory ingredient check, crafting animation progress bar, output item to inventory, craft queue for multiples, recipe book GUI with unlock tracking. Name all scripts."},
    {icon:"🏠",title:"House System",desc:"Buy plot, place furniture, save",badge:"adv",prompt:"Build a house/plot system: purchasable plots with indicators, grid furniture placement inside plot boundaries, furniture catalog GUI, save all placed furniture positions to DataStore per player, load on join. Name all scripts."},
  ],
  building:[
    {icon:"🏰",title:"Castle Builder",desc:"Procedural castle from BaseParts",badge:"adv",prompt:"Build a detailed 3D castle in Lua using only BaseParts and WeldConstraints: 4 corner towers with crenellated battlements, connecting walls with walkways, main keep with arched entrance, portcullis gate, round towers, flag poles with triangle flags, moat channel. All positioned with CFrame math. Name it CastleBuilder."},
    {icon:"⚔️",title:"3D Sword",desc:"Blade, guard, grip, pommel",badge:"",prompt:"Build a realistic 3D sword model in Lua using BaseParts and WeldConstraints: tapered blade with fuller groove using WedgeParts, crossguard with decorative ends, leather-wrapped grip (spiral cylinders), pommel sphere with decorative ring. Name the script SwordBuilder."},
    {icon:"🏹",title:"3D Bow",desc:"Limbs, grip, string, arrow",badge:"",prompt:"Build a 3D bow model in Lua using BaseParts and WeldConstraints: curved limbs using angled cylinders, carved grip section, bowstring from thin cylinders, arrow nocked on string, quiver with arrows at angle. Name it BowBuilder."},
    {icon:"🗡️",title:"3D Axe",desc:"Head, beard, spike, haft",badge:"",prompt:"Build a 3D battle axe in Lua using BaseParts and WeldConstraints: axe head with crescent shape using UnionParts logic via BaseParts, beard (lower extension), top spike, wooden haft with wrapped grip section, pommel cap. Name it AxeBuilder."},
    {icon:"🏠",title:"House Builder",desc:"Walls, roof, doors, windows",badge:"adv",prompt:"Build a detailed house in Lua using BaseParts and WeldConstraints: four exterior walls, peaked roof from WedgeParts, door frame with door panel, window frames with glass panes (transparency), wooden floor, interior walls, chimney with smoke effect. Name it HouseBuilder."},
    {icon:"🚗",title:"Car Body",desc:"Chassis, body panels, wheels",badge:"adv",prompt:"Build a 3D car body in Lua using BaseParts and WeldConstraints: chassis frame, body panels (hood, trunk, roof, doors), windshield glass, 4 wheels with hubcaps using SpecialMesh, headlights using Neon parts, exhaust pipe. Name it CarBuilder."},
    {icon:"🌉",title:"Bridge Builder",desc:"Deck, cables, towers, supports",badge:"",prompt:"Build a suspension bridge in Lua using BaseParts: main deck planks, two towers with crossbeams, main suspension cables (angled thin cylinders), vertical hangers, approach ramps. Position with CFrame math. Name it BridgeBuilder."},
    {icon:"⚙️",title:"Gear/Machine",desc:"Interlocking gears, pistons",badge:"new",prompt:"Build a steampunk machine in Lua using BaseParts: large gear (cylinder with tooth pegs around edge), small gear meshing with it, connecting rod, piston in cylinder housing, steam pipe, pressure gauge. Animate gears rotating with Motor6D joints. Name it MachineBuilder."},
    {icon:"🗼",title:"Tower Builder",desc:"Multi-floor tower, spiral stair",badge:"",prompt:"Build a multi-floor observation tower in Lua using BaseParts and WeldConstraints: octagonal base, tapered walls each floor, spiral staircase inside using angled rectangles, balcony railings, pointed spire roof, lantern room at top. Name it TowerBuilder."},
    {icon:"🌿",title:"Tree Generator",desc:"Trunk, branches, leaf clusters",badge:"new",prompt:"Build a procedural tree generator in Lua: trunk (tapered cylinder), branching using recursion with decreasing radius and random angles via CFrame rotation, leaf clusters (sphere parts with green neon transparency). Configurable height and branch count. Name it TreeGenerator."},
  ],
  advanced:[
    {icon:"🛡️",title:"Anti-Exploit Suite",desc:"Rate limits, sanity, ban log",badge:"pro",prompt:"Build a comprehensive anti-exploit suite: RemoteEvent rate limiter (N calls per second per player), position sanity check (teleport detection), value sanity validator (reject impossible values), WalkSpeed/JumpPower enforcer, auto-kick with violation reason, ban log to DataStore, admin alert. Name the script AntiExploit in ServerScriptService."},
    {icon:"🎲",title:"Simulator Core",desc:"Click, auto, rebirth, prestige",badge:"pro",prompt:"Build a complete simulator core: click counter with multiplier (tool + upgrades), auto-clicker upgrade, rebirth system (reset progress for permanent multiplier), prestige system (special currency + cosmetic unlocks), ProfileService data saving, all GUIs included. Name all scripts."},
    {icon:"🌍",title:"Open World Spawner",desc:"Dynamic spawn, LOD, streaming",badge:"pro",prompt:"Create a dynamic world object spawner: spawn trees/rocks/bushes/items in radius around each player using workspace:GetPartBoundsInBox() to avoid overlap, CollectionService tagging, server LOD unload when all players far, streaming-friendly, configurable density and object types. Name all scripts."},
    {icon:"🔄",title:"Replication System",desc:"Server state → all clients sync",badge:"pro",prompt:"Build a custom replication system: server maintains authoritative state table, replicate diffs to clients on change using RemoteEvents, client applies changes to local shadow state, handle client join with full state snapshot, support nested tables. Name all scripts."},
    {icon:"🎯",title:"AI Behavior Tree",desc:"Selector, sequence, leaf nodes",badge:"ultra",prompt:"Implement a Behavior Tree system for NPCs in Lua: BehaviorTree module with Selector, Sequence, Inverter and Leaf node types, tick system at 10hz, blackboard for shared state, example NPC using Chase/Attack/Patrol/Idle leaves. Name it BehaviorTreeModule."},
    {icon:"📈",title:"Analytics System",desc:"Session tracking, funnel events",badge:"pro",prompt:"Build a game analytics system: session start/end tracking, custom event logging (level up, purchase, death, achievement), hourly data aggregation in DataStore, server dashboard GUI for admins showing DAU, top events, revenue. Name all scripts."},
    {icon:"🗄️",title:"MemoryStore Cache",desc:"Fast shared server cache",badge:"pro",prompt:"Build a MemoryStore caching layer: read-through cache for DataStore (check MemoryStore first, fall back to DataStore), write-through on save, sorted set for global leaderboard with GetRangeAsync, cross-server event via messaging. Name it CacheManager."},
    {icon:"🎬",title:"Cutscene System",desc:"Camera paths, letterbox, skip",badge:"adv",prompt:"Build a cutscene system: define camera waypoints with CFrame positions, smooth TweenService camera movement along path, letterbox bars (top/bottom black frames), subtitle text with typewriter effect, skip button, disable player controls during cutscene, screen fade in/out. Name all scripts."},
    {icon:"🌐",title:"Cross-Server Events",desc:"MessagingService broadcasts",badge:"pro",prompt:"Build a cross-server event system using MessagingService: subscribe to topics on server start, publish typed events (PlayerBanned, GlobalAnnouncement, ServerShutdown), queue failed publishes with retry, notification GUI on receive. Name it CrossServerManager."},
    {icon:"⚡",title:"Parallel Luau",desc:"Actor workers for computation",badge:"ultra",prompt:"Show how to use Parallel Luau with Actors for pathfinding grid computation: setup Script with Actor, worker ModuleScript that uses task.desynchronize(), main script distributes grid chunks via SendMessage(), collects results, visualizes path. Full working example with named files."},
  ],
  frameworks:[
    {icon:"🧠",title:"Knit Full Setup",desc:"Server, client, service, controller",badge:"pro",prompt:"Set up a complete Knit framework game: KnitServer loader (ServerScriptService), KnitClient loader (StarterPlayerScripts), CurrencyService with client-exposed GetCoins/AddCoins/SpendCoins, CurrencyController with :OnStart() GUI setup and signal listener, shared Config module. Name all files exactly as Knit conventions."},
    {icon:"💾",title:"ProfileService Full",desc:"Profile, leaderstats, migration",badge:"pro",prompt:"Set up complete ProfileService: ProfileStore definition with default data table (Coins, Gems, Level, XP, Wins, PlayTime, Inventory, Settings), profile loading with session-lock wait, leaderstats binding, reconcile for new data keys, data migration version system, BindToClose, profile release on leave. Name it ProfileManager."},
    {icon:"⚡",title:"Nevermore Setup",desc:"Loaders, services, modules",badge:"pro",prompt:"Explain Nevermore framework and show a complete setup: loader script in ReplicatedFirst, ServiceBag pattern, creating a custom Service with Init and Start methods, using Maid for cleanup, shared modules. Name all files following Nevermore conventions."},
    {icon:"🔧",title:"AeroGameFramework",desc:"Services, controllers, modules",badge:"pro",prompt:"Show a complete AeroGameFramework setup: server Services (with :Init() :Start()), client Controllers, shared Modules, calling server methods from client via services. Example: PlayerDataService and PlayerDataController. Name files following AGF conventions."},
    {icon:"🎯",title:"Cmdr Setup",desc:"Commands, registry, permissions",badge:"adv",prompt:"Set up Cmdr admin framework: install script, command registry, 10 custom commands (kick, ban with duration, unban, tp, tphere, announce, servermsg, give, setgrav, shutdown), permission groups with DataStore persistence, GUI-friendly output. Name all files."},
    {icon:"📦",title:"Flamework Setup",desc:"Components, services, lifecycle",badge:"pro",prompt:"Explain Flamework and show a complete setup: server components with lifecycle hooks (@Component decorator pattern in vanilla Lua), services with dependency injection pattern, client-server bridge, example health component attached to parts. Name all files."},
    {icon:"🌊",title:"Matter ECS",desc:"World, components, systems",badge:"ultra",prompt:"Show a complete Matter ECS setup: World creation, defining Components as tables, Systems with :query(), example game using Health, Position, Velocity and Damage components, Hotswap for live editing, loop integration with RunService. Name all files."},
    {icon:"🔄",title:"DataStore2 Setup",desc:"Wrapped saves, combine, backup",badge:"adv",prompt:"Set up DataStore2: install module, player data saving (Coins, Inventory, Settings), :Set(), :Get(), :Increment(), :OnUpdate() for real-time GUI updates, combine() to reduce API calls, BeforeInitialGet for migration. Name all scripts."},
  ],
  pro:[
    {icon:"🏪",title:"Full Game Template",desc:"Complete playable game foundation",badge:"ultra",prompt:"Build a complete playable game template: round system with map voting, 3 weapon types (sword/gun/grenade), kill feed, leaderboard, shop with 5 items, DataStore persistence via ProfileService, anti-cheat, admin commands, mobile support, loading screen. Name ALL scripts with proper placement."},
    {icon:"⚡",title:"Performance Audit",desc:"Lag diagnosis + optimization guide",badge:"pro",prompt:"Give me a comprehensive Roblox game performance audit checklist and explain how to fix each issue: Part count reduction (unions, LOD), Script profiling with MicroProfiler, network traffic reduction, StreamingEnabled setup, particle optimization, shadow settings, renderFidelity, server tick rate, memory leak detection."},
    {icon:"🔒",title:"Security Hardening",desc:"Full exploit-proof architecture",badge:"ultra",prompt:"Build an exploit-proof game architecture: never trust client (full list), server authority patterns, RemoteEvent whitelist system, rate limiting per remote, position/value validation functions, FE-safe GUI architecture, DataStore integrity checks, exploit attempt logging, ban system. Include full code examples."},
    {icon:"💎",title:"Monetization Setup",desc:"GamePass, DevProducts, Premium",badge:"pro",prompt:"Build a complete monetization system: GamePass ownership check on join with perks (2x speed, vip chat tag, exclusive area access), Developer Products for Coins bundles (100/500/2000) with ProcessReceipt and DataStore receipt log, Premium player detection with bonus rewards, gamepass shop GUI. Name all scripts."},
    {icon:"🏆",title:"Global Leaderboard",desc:"OrderedDataStore, cross-server top10",badge:"pro",prompt:"Build a global leaderboard using OrderedDataStore: update player score on stat change, GetSortedAsync top 100, display in GUI with rank, avatar thumbnail, username and score, auto-refresh every 60 seconds, weekly reset with MessagingService announcement. Name all scripts."},
    {icon:"🎯",title:"Achievement System",desc:"50 achievements, rewards, badges",badge:"pro",prompt:"Build a complete achievement system: 50 achievement definitions in ModuleScript (Beginner, Intermediate, Expert, Legend tiers), unlock conditions checked server-side, unlock animation GUI with confetti particles, Roblox Badge award via BadgeService, DataStore persistence, achievement viewer GUI. Name all scripts."},
    {icon:"🌍",title:"Procedural World",desc:"Perlin terrain, biomes, structures",badge:"ultra",prompt:"Build a procedural world generator: Perlin noise heightmap for terrain using FillBlock/FillBall, biome system (Desert, Forest, Tundra, Swamp) based on noise layers, structure spawning (trees, rocks, ruins, dungeons) with avoidance, player chunk loading/unloading. Name all scripts."},
    {icon:"🎬",title:"Cinematic Engine",desc:"Director camera, DOF, sequences",badge:"pro",prompt:"Build a cinematic engine: keyframe-based camera path editor (in-game), bezier curve interpolation between camera positions, DOF (DepthOfField) target focusing, ColorCorrection mood presets per scene, timeline with events at timestamps, export/import sequence as JSON via DataStore. Name all scripts."},
  ]
};

// ══════════════════════════════════════════════════════════
// SYSTEM PROMPT — ULTRA EDITION
// ══════════════════════════════════════════════════════════
const GENIUS_SYSTEM = `You are STUDIO BRIDGE AI v5 ULTRA — the world's most capable Roblox Luau engineer and 3D building expert.

═══════════════════════════════════════════
SCRIPT HEADER (MANDATORY — every script):
═══════════════════════════════════════════
-- ══════════════════════════════════════════════════════
-- Script Name: [DescriptivePascalCaseName]
-- Type: [Script | LocalScript | ModuleScript]
-- Location: [exact Roblox Explorer path]
-- Purpose: [one concise line]
-- Dependencies: [list required modules/remotes or None]
-- ══════════════════════════════════════════════════════

NAMING RULES (CRITICAL):
✅ PascalCase, domain-specific, 1-3 words
✅ Good: CoinManager, RoundController, ShopServer, PetClient, DataManager, GuiController, BossController, NPCHandler, EconomyService, CastleBuilder, AntiExploit, ProfileManager, WeaponSystem, EffectsClient, SoundManager, AdminSystem, CombatServer, VehicleController
✅ ModuleScripts: always end in their role — Config, Module, Service, Utils, Data, Handler
❌ Never: Script, LocalScript, Module, Script1, MyScript, Test, New

PLACEMENT RULES:
- Server Scripts → ServerScriptService (never Workspace)
- LocalScripts → StarterPlayerScripts (general) or StarterGui (GUI-heavy)
- Character LocalScripts → StarterCharacterScripts
- ModuleScripts → ReplicatedStorage/Modules (shared) or ServerScriptService/Modules (server-only)
- RemoteEvents/Functions → ReplicatedStorage/Remotes/
- BindableEvents → ServerScriptService/Events/ (server) or StarterPlayerScripts (client)

ABSOLUTE CODE RULES:
❌ NEVER truncate, skip, or summarize code — write every single line
❌ NEVER use wait() or spawn() — always task.wait() and task.spawn()
❌ NEVER use game.Players — always game:GetService("Players")
❌ NEVER trust client data without server validation
❌ NEVER store sensitive data in ReplicatedStorage
✅ ALWAYS pcall() around all DataStore, HttpService, BadgeService calls
✅ ALWAYS validate RemoteEvent arguments on server (type check, range check, ownership check)
✅ ALWAYS disconnect connections on player leave or object destroy
✅ ALWAYS cache GetService() at script top
✅ ALWAYS include a CONFIG table at the top of scripts
✅ ALWAYS use section dividers: -- ── SECTION NAME ──

CODE QUALITY STANDARDS:
- Profile-Service aware: if DataStore is used, mention ProfileService alternative
- Rate limit awareness: mention :GetRequestBudgetForRequestType() where relevant
- Memory safety: use Maid/Janitor patterns or manual :Disconnect() in cleanup
- Networking: minimize remote calls, batch where possible, debounce client input
- 3D building: use precise CFrame math, WeldConstraints (not Weld joints), proper part sizing

3D BUILDING RULES (when making models):
- Use ONLY BaseParts, WedgeParts, CornerWedgeParts, MeshParts, SpecialMesh
- Connect all parts with WeldConstraint (not Motor6D unless animated)
- Use CFrame.new() + CFrame.Angles() for precise positioning
- Anchor the root/base part, weld everything to it
- Include material and color assignments for visual quality
- Build in a function that returns the model, so it's reusable

RESPONSE FORMAT:
1. Brief intro (1-2 sentences max)
2. File list with types upfront if multiple scripts
3. All code — COMPLETE, no skipping
4. Concise usage/setup instructions at end

STYLE: Direct, senior engineer energy. No excessive fluff. Pride in craft.`;

// ══════════════════════════════════════════════════════════
// MODEL DETECTION
// ══════════════════════════════════════════════════════════
function detectBestModel(text){
  const t = text.toLowerCase().trim();
  const geniusPatterns = [
    'full system','complete system','entire system','build me a','create a full','build a full',
    'build a complete','framework','knit','profileservice','cmdr','round system','admin system',
    'anti-cheat','anti exploit','antiexploit','tycoon','simulator','pet system','full game',
    'whole game','advanced','production','architecture','cross server','memorystore',
    'parallel luau','multiple scripts','server and client','full npc','boss','placement system',
    'inventory system','economy system','combat system','rebirth','leaderboard system',
    'full gui','complete gui','everything','all features','3d model','3d sword','3d castle',
    '3d house','build a model','baseparts','procedural','open world','global leaderboard',
    'anti-exploit','gamepass','gun system','behavior tree','ecs','matter','nevermore',
    'flamework','aerogameframework','cinematic','achievement system','wave system',
    'building system','weather system','crafting system','house system','vehicle system',
    'analytics','memorystore','replication','profiling','cutscene','castle','bridge','tower',
    'tree generator','full template','complete template','60+','200+','all scripts',
    'car body','3d bow','3d axe','machine','gear','steampunk','fort','dungeon','spaceship',
    'modular','library','suite','engine','manager','controller set','all features'
  ];
  if(geniusPatterns.some(p=>t.includes(p))) return 'genius';
  if(t.length > 220) return 'genius';
  
  const fastPatterns = [
    'what is ','what are ','what does ','how does ','explain ','define ','tell me about',
    'difference between',' vs ','versus ','which is better',"what's the",'whats the',
    'can you explain','why does','why is','when should i','should i use','is it possible',
    'briefly','quick','short','simple question'
  ];
  if(fastPatterns.some(p=>t.startsWith(p)||t.includes(p)) && t.length < 90 && !/(script|code|build|create|make|generate|write|give me|3d|model|system|full|complete)/.test(t)) return 'fast';
  
  return 'balanced';
}
function updateModelBadge(key){
  const m = MODELS[key];
  const b = document.getElementById('model-badge');
  b.className = 'model-badge ' + m.cls;
  document.getElementById('model-badge-txt').textContent = m.label;
}

// ══════════════════════════════════════════════════════════
// PLACEMENT DETECTION — ENHANCED
// ══════════════════════════════════════════════════════════
function detectPlacement(code){
  const c = code.toLowerCase();
  let loc=0, mod=0, srv=0;
  
  [['localplayer',3],['playergui',3],['playerscripts',2],['replicatedfirst',2],
   ['onclientevent',3],['userinputservice',2],['contextactionservice',2],
   ['renderstepped',3],['fireserver',2],['camera',1],['inputbegan',2],
   ['inputended',2],['tweenservice',1],['screengui',2],['frame',1],['textlabel',1],
   ['textbutton',2],['imagebutton',2],['startergui',3],['starterplayerscripts',3],
   ['uis.',2],['cas.',2],['runservice.renderstepped',3],['onfired',1]
  ].forEach(([s,w])=>{if(c.includes(s))loc+=w;});
  
  [['onserverevent',4],['playeradded',3],['playerremoving',3],['datastoreservice',3],
   ['bindtoclose',3],['fireclient',2],['fireallclients',2],['serverstorage',3],
   ['serverscriptservice',3],['messagingservice',3],['memorystore',3],['httpservice',3],
   ['badgeservice',2],['marketplaceservice',2],['physicservice',2],['groupservice',2]
  ].forEach(([s,w])=>{if(c.includes(s))srv+=w;});
  
  [['return ',2],['setmetatable',3],['__index',2],['local module = {}',4],
   ['module.__index',4],['function module.',3],['function module:',3],
   ['local m = {}',2],['return m',3],['local lib = {}',2]
  ].forEach(([s,w])=>{if(c.includes(s))mod+=w;});
  
  if(/return\s+\w+\s*$/m.test(code.trim())) mod+=6;
  if(/local\s+\w+\s*=\s*\{\}/.test(c) && /return\s+\w+/.test(c)) mod+=4;
  if(/setmetatable/.test(c)) mod+=3;
  
  let type = (mod>=8 && mod>=loc && mod>=srv) ? 'module' : (loc > srv) ? 'local' : 'server';
  
  const P = {
    server:{type:'Script',      badge:'server',label:'🔴 Script (Server)',
            path:'ServerScriptService',
            note:'Runs on server only. Has DataStores, all players, game authority.',
            howTo:'Explorer → ServerScriptService → right-click → Insert Object → Script'},
    local: {type:'LocalScript', badge:'local', label:'🔵 LocalScript (Client)',
            path:'StarterPlayer → StarterPlayerScripts',
            note:'Runs on each player\'s device. Access to LocalPlayer, GUI, input, camera.',
            howTo:'Explorer → StarterPlayer → StarterPlayerScripts → right-click → LocalScript'},
    module:{type:'ModuleScript',badge:'module',label:'🟣 ModuleScript (Shared)',
            path:'ReplicatedStorage → Modules',
            note:'Required via require(). ReplicatedStorage = accessible by both server and client.',
            howTo:'Explorer → ReplicatedStorage → right-click → Insert Object → ModuleScript'}
  };
  
  const p = {...P[type]};
  if(type==='module' && srv>loc && srv>2){
    p.path='ServerScriptService → Modules';
    p.note='Server-only ModuleScript. Uses DataStores or server-exclusive services.';
    p.howTo='Explorer → ServerScriptService → Modules folder → Insert ModuleScript';
  }
  if(type==='local' && (c.includes('screengui')||c.includes('playergui')||c.includes('textlabel')||c.includes('frame'))){
    p.path='StarterGui';
    p.howTo='Explorer → StarterGui → right-click → LocalScript';
  }
  if(type==='local' && (c.includes('characteradded')||c.includes('humanoid.')&&!c.includes('getservice'))){
    p.path='StarterPlayer → StarterCharacterScripts';
    p.note='Runs every time the player\'s character spawns. Restarts on death.';
    p.howTo='Explorer → StarterPlayer → StarterCharacterScripts → right-click → LocalScript';
  }
  return p;
}

// ══════════════════════════════════════════════════════════
// HEURISTIC NAMING — ENHANCED
// ══════════════════════════════════════════════════════════
function heuristicName(code, ctx, idx, pl){
  const hdr = code.match(/--\s*Script Name[:\s]+([A-Za-z][A-Za-z0-9_]+)/i);
  if(hdr) return hdr[1].trim();
  
  if(ctx){
    const p = ctx.toLowerCase();
    const map = [
      [['coin','pickup'],['CoinManager','CoinClient','CoinConfig']],
      [['health','hp','damage'],['HealthManager','HealthClient','CombatConfig']],
      [['admin','command'],['AdminSystem','AdminClient','AdminConfig']],
      [['datastore','save','load','data'],['DataManager','DataClient','DataConfig']],
      [['round','game loop','intermission'],['RoundManager','RoundClient','RoundConfig']],
      [['npc','pathfinding','waypoint'],['NPCController','NPCClient','NPCConfig']],
      [['boss','phase','raid'],['BossController','BossClient','BossConfig']],
      [['gui','interface','hud','menu'],['GuiController','GuiManager','GuiConfig']],
      [['shop','purchase','buy','sell'],['ShopServer','ShopClient','ShopConfig']],
      [['pet','egg','hatch'],['PetSystem','PetClient','PetConfig']],
      [['remote','event','function'],['RemoteHandler','RemoteClient','RemoteConfig']],
      [['leaderboard','rank','stats'],['LeaderboardManager','LeaderboardClient','LeaderboardConfig']],
      [['castle','fort','fortress'],['CastleBuilder','CastleViewer','CastleConfig']],
      [['sword','weapon','blade'],['SwordBuilder','WeaponClient','WeaponConfig']],
      [['3d model','baseparts','procedural','builder'],['ModelBuilder','ModelViewer','ModelConfig']],
      [['bow','arrow','ranged'],['BowBuilder','WeaponClient','WeaponConfig']],
      [['axe','hatchet'],['AxeBuilder','WeaponClient','WeaponConfig']],
      [['house','home','plot'],['HouseSystem','HouseClient','HouseConfig']],
      [['combat','melee','hit','fight'],['CombatSystem','CombatClient','CombatConfig']],
      [['gun','raycast','shoot','bullet'],['GunSystem','GunClient','GunConfig']],
      [['economy','currency','coins','gems'],['EconomyManager','EconomyClient','EconomyConfig']],
      [['tycoon','dropper','collector'],['TycoonServer','TycoonClient','TycoonConfig']],
      [['simulator','clicker','auto'],['SimulatorServer','SimulatorClient','SimulatorConfig']],
      [['rebirth','prestige','reset'],['RebirthManager','RebirthClient','RebirthConfig']],
      [['anti','exploit','cheat','detect'],['AntiExploit','ExploitDetector','SecurityConfig']],
      [['sound','music','audio','sfx'],['SoundManager','SoundClient','SoundConfig']],
      [['knit','service','controller'],['KnitServer','KnitClient','KnitConfig']],
      [['profile','profileservice'],['ProfileManager','ProfileClient','ProfileConfig']],
      [['vote','voting','map select'],['VoteManager','VoteClient','VoteConfig']],
      [['keybind','hotkey','input'],['KeybindController','InputHandler','KeybindConfig']],
      [['vehicle','car','drive'],['VehicleSystem','VehicleClient','VehicleConfig']],
      [['weather','rain','snow','fog'],['WeatherManager','WeatherClient','WeatherConfig']],
      [['day','night','cycle','time'],['TimeManager','TimeClient','TimeConfig']],
      [['achievement','badge','trophy'],['AchievementManager','AchievementClient','AchievementConfig']],
      [['wave','enemy','spawn','horde'],['WaveManager','WaveClient','WaveConfig']],
      [['crafting','recipe','craft'],['CraftingSystem','CraftingClient','CraftingConfig']],
      [['build','place','furniture','grid'],['BuildingSystem','BuildingClient','BuildingConfig']],
      [['notification','toast','alert'],['NotificationSystem','NotificationClient','NotificationConfig']],
      [['cinematic','cutscene','camera path'],['CinematicEngine','CinematicClient','CinematicConfig']],
      [['analytics','tracking','funnel'],['AnalyticsManager','AnalyticsClient','AnalyticsConfig']],
      [['tree','forest','procedural nature'],['TreeGenerator','NatureClient','NatureConfig']],
      [['bridge','structure','architecture'],['BridgeBuilder','StructureClient','StructureConfig']],
      [['tower','lighthouse','obelisk'],['TowerBuilder','StructureClient','StructureConfig']],
      [['car body','chassis','automobile'],['CarBuilder','VehicleClient','VehicleConfig']],
      [['machine','gear','piston','steampunk'],['MachineBuilder','MachineClient','MachineConfig']],
      [['global leaderboard','worldwide','cross server rank'],['GlobalLeaderboard','LeaderboardClient','LeaderboardConfig']],
      [['monetization','gamepass','devproduct','robux'],['MonetizationManager','MonetizationClient','MonetizationConfig']],
      [['cmdr','admin framework'],['CmdrSetup','AdminClient','AdminConfig']],
    ];
    for(const [kws, names] of map){
      if(kws.some(kw=>p.includes(kw))) return names[idx % names.length];
    }
  }
  
  const fallbacks = {
    Script:       ['GameServer','ServerMain','ServerCore','GameManager'],
    LocalScript:  ['ClientMain','GuiClient','PlayerClient','LocalController'],
    ModuleScript: ['SharedModule','GameConfig','UtilModule','SharedLibrary']
  };
  return (fallbacks[pl.type]||['BridgeScript'])[idx % 4];
}

// ══════════════════════════════════════════════════════════
// STATE
// ══════════════════════════════════════════════════════════
let user=null, conversations=[], activeChatId=null, lastUserPrompt='';
let totalMsgs=0, totalCopied=0, sidebarOpen=true;
const $ = id => document.getElementById(id);
const tsShort = () => { const d=new Date(); return d.getHours()+':'+String(d.getMinutes()).padStart(2,'0'); };

function toast(msg, type='info', dur=3500){
  const c=$('toasts'), t=document.createElement('div');
  t.className='toast '+type; t.textContent=msg; c.appendChild(t);
  setTimeout(()=>{t.style.opacity='0';t.style.transition='opacity .3s';setTimeout(()=>t.remove(),300);},dur);
}
function updateStats(){
  $('stat-msgs').textContent = totalMsgs;
  $('stat-chats').textContent = conversations.length;
  $('stat-copied').textContent = totalCopied;
}
function sv(){ try{ localStorage.setItem('sb5_u',JSON.stringify(user)); localStorage.setItem('sb5_c',JSON.stringify(conversations)); localStorage.setItem('sb5_s',JSON.stringify({totalMsgs,totalCopied})); }catch{} }
function lv(){ try{ user=JSON.parse(localStorage.getItem('sb5_u')); const c=localStorage.getItem('sb5_c'); conversations=c?JSON.parse(c):[]; const s=JSON.parse(localStorage.getItem('sb5_s')||'{}'); totalMsgs=s.totalMsgs||0; totalCopied=s.totalCopied||0; }catch{conversations=[];} }

// ══════════════════════════════════════════════════════════
// AUTH
// ══════════════════════════════════════════════════════════
function startApp(){
  const inp=$('rbx-username'), u=(inp.value||'').trim();
  if(!u){ $('auth-err').style.display='block'; inp.focus(); return; }
  $('auth-err').style.display='none';
  user={username:u, avatar:u[0].toUpperCase()};
  enterApp();
}
function enterApp(){
  sv(); $('auth').classList.add('gone'); $('app').classList.add('show');
  $('top-ava').textContent=user.avatar; $('top-name').textContent=user.username;
  buildTemplates(); renderHistory(); updateStats();
}
function logout(){
  user=null; conversations=[]; totalMsgs=0; totalCopied=0;
  localStorage.removeItem('sb5_u'); localStorage.removeItem('sb5_c'); localStorage.removeItem('sb5_s');
  $('app').classList.remove('show'); $('auth').classList.remove('gone');
  $('rbx-username').value='';
}
lv(); if(user) enterApp();

// ══════════════════════════════════════════════════════════
// SIDEBAR
// ══════════════════════════════════════════════════════════
function toggleSidebar(){
  sidebarOpen = !sidebarOpen;
  const sb = $('sidebar');
  sb.classList.toggle('collapsed', !sidebarOpen);
  $('sidebar-toggle').textContent = sidebarOpen ? '◀' : '▶';
}

// ══════════════════════════════════════════════════════════
// TEMPLATES BUILD
// ══════════════════════════════════════════════════════════
function buildTemplates(){
  const cats = ['starter','scripting','gui','systems','building','advanced','frameworks','pro'];
  cats.forEach(cat => {
    const el = $(cat+'-tools');
    if(!el) return;
    el.innerHTML = (TEMPLATES[cat]||[]).map(t => `
      <div class="sidebar-tool" onclick="quickPrompt(${JSON.stringify(t.prompt)})">
        <span class="sidebar-tool-icon">${t.icon}</span>
        <div class="sidebar-tool-body">
          <div class="sidebar-tool-title">${escHtml(t.title)}</div>
          <div class="sidebar-tool-desc">${escHtml(t.desc)}</div>
        </div>
        ${t.badge ? `<span class="tmpl-badge ${t.badge}">${t.badge.toUpperCase()}</span>` : ''}
      </div>`).join('');
  });
}

function filterTemplates(query){
  if(!query.trim()){
    buildTemplates(); return;
  }
  const q = query.toLowerCase();
  const cats = ['starter','scripting','gui','systems','building','advanced','frameworks','pro'];
  cats.forEach(cat => {
    const el = $(cat+'-tools');
    if(!el) return;
    const filtered = (TEMPLATES[cat]||[]).filter(t =>
      t.title.toLowerCase().includes(q) ||
      t.desc.toLowerCase().includes(q) ||
      t.prompt.toLowerCase().includes(q)
    );
    el.innerHTML = filtered.map(t => `
      <div class="sidebar-tool" onclick="quickPrompt(${JSON.stringify(t.prompt)})">
        <span class="sidebar-tool-icon">${t.icon}</span>
        <div class="sidebar-tool-body">
          <div class="sidebar-tool-title">${escHtml(t.title)}</div>
          <div class="sidebar-tool-desc">${escHtml(t.desc)}</div>
        </div>
        ${t.badge ? `<span class="tmpl-badge ${t.badge}">${t.badge.toUpperCase()}</span>` : ''}
      </div>`).join('') || '<div style="font-size:9px;color:var(--text3);padding:10px 8px">No results.</div>';
  });
}

function switchTab(name, el){
  document.querySelectorAll('.tmpl-tab').forEach(t=>t.classList.remove('active'));
  document.querySelectorAll('.tmpl-panel').forEach(p=>p.classList.remove('active'));
  el.classList.add('active');
  $('panel-'+name).classList.add('active');
}

// ══════════════════════════════════════════════════════════
// CHAT MANAGEMENT
// ══════════════════════════════════════════════════════════
function newChat(){
  activeChatId=null;
  $('messages-inner').innerHTML='';
  $('messages-wrap').classList.add('hidden');
  $('welcome-screen').classList.remove('hidden');
  updateModelBadge('balanced');
  renderHistory();
}
function getActiveChat(){ return conversations.find(c=>c.id===activeChatId); }
function createChat(first){
  const id='c'+Date.now(), title=first.slice(0,45)+(first.length>45?'…':'');
  const chat={id,title,messages:[],createdAt:tsShort()};
  conversations.unshift(chat); activeChatId=id; sv(); renderHistory(); return chat;
}
function deleteChat(id, e){
  e.stopPropagation();
  conversations=conversations.filter(c=>c.id!==id);
  if(activeChatId===id){ activeChatId=null; $('messages-inner').innerHTML=''; $('messages-wrap').classList.add('hidden'); $('welcome-screen').classList.remove('hidden'); }
  sv(); renderHistory(); updateStats();
}
function renderHistory(){
  const el=$('chat-history');
  if(!conversations.length){
    el.innerHTML='<div class="empty-history"><div class="empty-history-icon">💬</div><div class="empty-history-text">No conversations yet.<br>Ask anything to get started!</div></div>';
    return;
  }
  el.innerHTML=conversations.map(c=>`
    <div class="chat-item${c.id===activeChatId?' active':''}" onclick="openChat('${c.id}')">
      <span class="chat-item-icon">💬</span>
      <div class="chat-item-body">
        <div class="chat-item-title">${escHtml(c.title)}</div>
        <div class="chat-item-meta">${c.createdAt||''} · ${c.messages?.length||0} msgs</div>
      </div>
      <span class="chat-del" onclick="deleteChat('${c.id}',event)">✕</span>
    </div>`).join('');
}
function openChat(id){
  activeChatId=id;
  const chat=getActiveChat(); if(!chat) return;
  $('welcome-screen').classList.add('hidden');
  $('messages-wrap').classList.remove('hidden');
  $('messages-inner').innerHTML='';
  chat.messages.forEach(m=>renderMessage(m,false));
  scrollToBottom(); renderHistory();
}

// ══════════════════════════════════════════════════════════
// INPUT
// ══════════════════════════════════════════════════════════
function inputKey(e){ if(e.key==='Enter'&&!e.shiftKey){ e.preventDefault(); sendMessage(); } }
function autoResize(el){ el.style.height='auto'; el.style.height=Math.min(el.scrollHeight,180)+'px'; }
function updateCharCounter(){
  const len=$('main-input').value.length;
  const cc=$('char-counter');
  cc.textContent=len>50?len:'';
  cc.className='char-counter'+(len>800?' warn':'');
}
function quickPrompt(text){ $('main-input').value=text; autoResize($('main-input')); updateCharCounter(); $('main-input').focus(); }
function scrollToBottom(){ const w=$('messages-wrap'); if(w) w.scrollTop=w.scrollHeight; }
function escHtml(s){ return(s||'').replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;'); }

// ══════════════════════════════════════════════════════════
// SHORTCUTS
// ══════════════════════════════════════════════════════════
function showShortcuts(){ $('shortcuts-panel').classList.add('show'); }
function closeShortcuts(e){ if(e.target.id==='shortcuts-panel') $('shortcuts-panel').classList.remove('show'); }
document.addEventListener('keydown',e=>{
  if(e.ctrlKey && e.key==='k'){ e.preventDefault(); newChat(); }
  if(e.ctrlKey && e.key==='/'){ e.preventDefault(); $('main-input').focus(); }
  if(e.ctrlKey && e.key==='b'){ e.preventDefault(); toggleSidebar(); }
  if(e.ctrlKey && e.key==='?'){ e.preventDefault(); showShortcuts(); }
  if(e.key==='Escape'){ $('shortcuts-panel').classList.remove('show'); }
  if(e.ctrlKey && e.shiftKey && e.key==='C'){ e.preventDefault(); copyLastCode(); }
});
function copyLastCode(){
  const last=Array.from(document.querySelectorAll('.code-body')).pop();
  if(!last){toast('No code to copy','bad');return;}
  const code=decodeURIComponent(last.dataset.code||'');
  navigator.clipboard.writeText(code).then(()=>toast('Last code block copied!','ok'));
}

// ══════════════════════════════════════════════════════════
// SEND — WITH STREAMING
// ══════════════════════════════════════════════════════════
async function sendMessage(){
  const inp=$('main-input'), text=inp.value.trim();
  if(!text) return;
  lastUserPrompt=text;
  inp.value=''; inp.style.height='auto'; $('char-counter').textContent='';
  $('send-btn').disabled=true;
  $('welcome-screen').classList.add('hidden');
  $('messages-wrap').classList.remove('hidden');
  
  let chat=getActiveChat(); if(!chat) chat=createChat(text);
  const modelKey=detectBestModel(text); updateModelBadge(modelKey);
  
  chat.messages.push({role:'user',content:text});
  totalMsgs++; updateStats();
  renderMessage({role:'user',content:text},true);
  scrollToBottom();
  
  const historyMsgs=chat.messages.slice(-14).map(m=>({role:m.role,content:m.content}));
  
  const aiRow=createStreamingRow(modelKey);
  $('messages-inner').appendChild(aiRow);
  scrollToBottom();
  
  try{
    const fullText=await streamAI(historyMsgs, modelKey, aiRow);
    const bubble=aiRow.querySelector('.msg-bubble');
    bubble.classList.remove('stream-cursor');
    bubble.innerHTML=formatMessage(fullText, false);
    const actionsHtml=buildActions(fullText, text);
    if(actionsHtml){
      const actDiv=document.createElement('div');
      actDiv.innerHTML=actionsHtml;
      aiRow.querySelector('.msg-content').appendChild(actDiv);
    }
    const aiMsg={role:'assistant',content:fullText,modelKey,prompt:text};
    chat.messages.push(aiMsg);
    totalMsgs++; sv(); renderHistory(); updateStats();
  }catch(err){
    const bubble=aiRow.querySelector('.msg-bubble');
    bubble.classList.remove('stream-cursor');
    bubble.innerHTML=`<span style="color:var(--c5)">⚠ Error: ${escHtml(err.message)}</span><br><span style="color:var(--text3);font-size:10px">Check your connection and try again.</span>`;
  }
  $('send-btn').disabled=false;
  scrollToBottom();
}

function createStreamingRow(modelKey){
  const mk=modelKey||'balanced';
  const ml=MODELS[mk]?MODELS[mk].label:'';
  const row=document.createElement('div');
  row.className='msg-row';
  row.style.cssText='opacity:0;transform:translateY(8px);transition:all .3s ease';
  row.innerHTML=`
    <div class="msg-avatar ai">✦</div>
    <div class="msg-content">
      <div class="msg-name">Studio Bridge AI <span class="msg-model-tag ${mk}">${ml}</span></div>
      <div class="msg-bubble stream-cursor"></div>
    </div>`;
  requestAnimationFrame(()=>{ row.style.opacity='1'; row.style.transform='translateY(0)'; });
  return row;
}

// ══════════════════════════════════════════════════════════
// STREAMING
// ══════════════════════════════════════════════════════════
async function streamAI(messages, modelKey, row){
  const bubble=row.querySelector('.msg-bubble');
  const maxTok=MAX_TOKENS[modelKey]||5000;
  let accText='', lastRender=0;
  
  const res=await fetch(ANTHROPIC_API,{
    method:'POST',
    headers:{
      'Content-Type':'application/json',
      'anthropic-version':'2023-06-01',
      'anthropic-dangerous-direct-browser-access':'true',
      'x-api-key':''
    },
    body:JSON.stringify({
      model:CLAUDE_MODEL,
      max_tokens:maxTok,
      stream:true,
      system:GENIUS_SYSTEM,
      messages
    })
  });
  
  if(!res.ok){
    const err=await res.json().catch(()=>({}));
    throw new Error(err.error?.message||'HTTP '+res.status);
  }
  
  const reader=res.body.getReader();
  const decoder=new TextDecoder();
  let buf='';
  
  while(true){
    const{done,value}=await reader.read();
    if(done) break;
    buf+=decoder.decode(value,{stream:true});
    const lines=buf.split('\n');
    buf=lines.pop();
    for(const line of lines){
      if(!line.startsWith('data:')) continue;
      const data=line.slice(5).trim();
      if(data==='[DONE]') continue;
      try{
        const ev=JSON.parse(data);
        if(ev.type==='content_block_delta'&&ev.delta?.type==='text_delta'){
          accText+=ev.delta.text;
          const now=Date.now();
          if(now-lastRender>35){
            lastRender=now;
            bubble.textContent=accText;
            scrollToBottom();
          }
        }
      }catch{}
    }
  }
  return accText;
}

// ══════════════════════════════════════════════════════════
// RENDER MESSAGE (history replay)
// ══════════════════════════════════════════════════════════
function renderMessage(msg, animate){
  const inner=$('messages-inner'), isUser=msg.role==='user';
  const row=document.createElement('div');
  row.className='msg-row'+(isUser?' user':'');
  if(animate) row.style.cssText='opacity:0;transform:translateY(8px);transition:all .3s ease';
  
  const avatarHtml=isUser
    ?`<div class="msg-avatar user">${user?user.avatar:'U'}</div>`
    :`<div class="msg-avatar ai">✦</div>`;
  const mk=msg.modelKey||'balanced';
  const ml=MODELS[mk]?MODELS[mk].label:'';
  const nameHtml=isUser
    ?`<div class="msg-name">${escHtml(user?user.username:'You')}</div>`
    :`<div class="msg-name">Studio Bridge AI <span class="msg-model-tag ${mk}">${ml}</span></div>`;
  const contentHtml=formatMessage(msg.content, isUser);
  
  row.innerHTML=`${avatarHtml}<div class="msg-content">${nameHtml}<div class="msg-bubble">${contentHtml}</div>${!isUser?buildActions(msg.content,msg.prompt||lastUserPrompt):''}</div>`;
  inner.appendChild(row);
  if(animate) requestAnimationFrame(()=>{ row.style.opacity='1'; row.style.transform='translateY(0)'; });
}

// ══════════════════════════════════════════════════════════
// FORMAT MESSAGE — ENHANCED
// ══════════════════════════════════════════════════════════
function formatMessage(text, isUser){
  if(!text) return '';
  if(isUser) return escHtml(text).replace(/\n/g,'<br>');
  
  let out='';
  text.split(/(```[\w]*\n?[\s\S]*?```)/g).forEach(part=>{
    const cm=part.match(/^```([\w]*)\n?([\s\S]*?)```$/);
    if(cm){
      const lang=cm[1]||'lua', code=cm[2];
      const cbId='cb_'+Math.random().toString(36).slice(2,9);
      const storeId=csSet(code);
      out+=`<pre><div class="code-header"><span class="code-lang">${escHtml(lang||'Lua')}</span><button class="copy-code-btn" onclick="copyBlockText(this)">Copy</button></div><div class="code-body" id="${cbId}" data-code="${encodeURIComponent(code)}" data-store="${storeId}">${escHtml(code)}</div></pre>`;
    }else{
      let p2=part;
      p2=p2.replace(/`([^`\n]+)`/g,(_,c)=>`<code>${escHtml(c)}</code>`);
      p2=p2.replace(/\*\*\*(.*?)\*\*\*/g,'<strong><em>$1</em></strong>');
      p2=p2.replace(/\*\*(.*?)\*\*/g,'<strong>$1</strong>');
      p2=p2.replace(/\*(.*?)\*/g,'<em>$1</em>');
      p2=p2.replace(/^### (.+)$/gm,'<h3>$1</h3>');
      p2=p2.replace(/^## (.+)$/gm,'<h3 style="font-size:13px">$1</h3>');
      p2=p2.replace(/^- (.+)$/gm,'<li>$1</li>');
      p2=p2.replace(/(<li>[\s\S]*?<\/li>)+/g,'<ul>$&</ul>');
      p2=p2.replace(/\n\n/g,'<br><br>');
      p2=p2.replace(/\n/g,'<br>');
      out+=p2;
    }
  });
  return out;
}

// ══════════════════════════════════════════════════════════
// BUILD ACTIONS — ENHANCED
// ══════════════════════════════════════════════════════════
function buildActions(text, promptCtx){
  if(!text) return '';
  const hasCode=/```(lua|luau)?/.test(text) || ((/local [A-Za-z]/.test(text)) && (/game:GetService/.test(text)));
  if(!hasCode) return '';
  
  const blocks=[];
  const rx=/```(?:lua|luau)?\n?([\s\S]*?)```/g;
  let m;
  while((m=rx.exec(text))!==null){
    const c=m[1].trim();
    if(c.length>15) blocks.push(c);
  }
  if(!blocks.length) return '';
  
  const cids=blocks.map(c=>csSet(c));
  const pls=blocks.map(c=>detectPlacement(c));
  const names=blocks.map((c,i)=>heuristicName(c,promptCtx,i,pls[i]));
  
  let html='';
  
  // FILES LIST
  if(blocks.length >= 1){
    html+=`<div class="files-list">
      <div class="files-list-header">📁 Scripts in this response <span class="files-count">${blocks.length} file${blocks.length>1?'s':''}</span></div>`;
    blocks.forEach((_,i)=>{
      html+=`<div class="file-row">
        <span class="file-type-badge ${pls[i].badge}">${pls[i].type}</span>
        <span class="file-name">${escHtml(names[i])}</span>
        <span class="file-path">→ ${escHtml(pls[i].path)}</span>
        <button class="file-copy-btn" onclick="copyByCid(${cids[i]})">copy</button>
      </div>`;
    });
    html+='</div>';
  }
  
  // PLACEMENT CARD (single script)
  if(blocks.length === 1){
    const pl=pls[0];
    html+=`<div class="placement-card">
      <div class="placement-card-header">📍 Where to place this script</div>
      <div class="placement-card-body">
        <div class="placement-row"><span class="placement-label">Name</span><span class="placement-val" style="color:var(--text);font-weight:700;font-family:var(--fm)">${escHtml(names[0])}</span></div>
        <div class="placement-row"><span class="placement-label">Type</span><span class="placement-val"><span class="placement-badge ${pl.badge}">${pl.label}</span></span></div>
        <div class="placement-row"><span class="placement-label">Location</span><span class="placement-val"><span class="placement-path">${escHtml(pl.path)}</span></span></div>
        <div class="placement-row"><span class="placement-label">Why</span><span class="placement-val">${escHtml(pl.note)}</span></div>
        <div class="placement-row"><span class="placement-label">How to add</span><span class="placement-val">${escHtml(pl.howTo)}</span></div>
      </div>
    </div>`;
  }
  
  // ACTION BUTTONS
  const pCid=cids[0];
  html+=`<div class="script-actions">
    <button class="sact-btn prim" onclick="copyByCid(${pCid})">📋 Copy Script</button>
    ${blocks.length>1?`<button class="sact-btn grn" onclick="copyAllByCids('${cids.join(',')}','${names.map(n=>encodeURIComponent(n)).join(',')}')">📦 Copy All (${blocks.length})</button>`:''}
    ${blocks.length>1?`<button class="sact-btn pur" onclick="copyAsBundle('${cids.join(',')}','${names.map(n=>encodeURIComponent(n)).join(',')}','${pls.map(p=>p.type).join(',')}')">📄 Bundle Export</button>`:''}
  </div>`;
  
  // REPLACE NOTICE
  const rPatterns=[
    {rx:/YOUR_USER_?ID|1234567890/gi,key:'YOUR_USERID',desc:'Replace with your Roblox UserId (use game.Players:GetPlayerByUserId())'},
    {rx:/rbxassetid:\/\/YOUR_ANIMATION/gi,key:'ANIMATION_ID',desc:'Replace with your animation asset ID from Roblox Studio'},
    {rx:/YOUR_GAME_NAME|"My Game"/gi,key:'YOUR_GAME_NAME',desc:"Replace with your game's display name"},
    {rx:/GROUP_ID|YOUR_GROUP_ID/gi,key:'GROUP_ID',desc:'Replace with your Roblox Group ID'},
    {rx:/GAMEPASS_ID|YOUR_GAMEPASS_ID/gi,key:'GAMEPASS_ID',desc:'Replace with your Gamepass ID from Creator Dashboard'},
    {rx:/PLACE_ID|YOUR_PLACE_ID/gi,key:'PLACE_ID',desc:'Replace with your Place ID from Creator Dashboard'},
    {rx:/BADGE_ID|YOUR_BADGE_ID/gi,key:'BADGE_ID',desc:'Replace with your Badge ID from Creator Dashboard'},
    {rx:/PRODUCT_ID|YOUR_PRODUCT_ID/gi,key:'PRODUCT_ID',desc:'Replace with your Developer Product ID'},
    {rx:/DS_KEY|"PlayerData"/gi,key:'DATASTORE_KEY',desc:"Replace with a unique DataStore key name for your game"},
  ];
  const rRows=rPatterns.filter(p=>p.rx.test(text)).map(p=>`
    <div class="replace-item">
      <span class="replace-key">${escHtml(p.key)}</span>
      <span class="replace-val">${escHtml(p.desc)}</span>
    </div>`).join('');
  if(rRows) html+=`<div class="replace-notice"><div class="replace-notice-title">⚠ Replace before using</div>${rRows}</div>`;
  
  return html;
}

// ══════════════════════════════════════════════════════════
// COPY HELPERS
// ══════════════════════════════════════════════════════════
function copyBlockText(btn){
  const block=btn.closest('pre').querySelector('.code-body');
  const code=block?decodeURIComponent(block.dataset.code||''):'';
  doClipboard(code, '✓ Code copied! Paste in Studio.', 'ok', 4500);
  totalCopied++; sv(); updateStats();
}
function copyByCid(cid){
  const code=csGet(cid);
  if(!code){ toast('No code found.','bad'); return; }
  doClipboard(code, '✓ Script copied! Paste into Studio with Ctrl+A → Ctrl+V.', 'ok', 5000);
  totalCopied++; sv(); updateStats();
}
function copyAllByCids(cidsStr, namesEncoded){
  const cids=cidsStr.split(','), names=namesEncoded.split(',').map(n=>decodeURIComponent(n));
  const parts=cids.map((cid,i)=>{
    const code=csGet(cid), name=names[i]||('Script_'+(i+1));
    return `-- ══════════════════════════════════════\n-- ${name}\n-- ══════════════════════════════════════\n${code}`;
  });
  doClipboard(parts.join('\n\n\n'), `✓ ${cids.length} scripts copied!`, 'ok', 4000);
  totalCopied+=cids.length; sv(); updateStats();
}
function copyAsBundle(cidsStr, namesEncoded, typesStr){
  const cids=cidsStr.split(','), names=namesEncoded.split(',').map(n=>decodeURIComponent(n)), types=typesStr.split(',');
  const header=`-- ╔══════════════════════════════════════════════╗\n-- ║   Studio Bridge v5 — Script Bundle Export   ║\n-- ║   Generated: ${new Date().toLocaleDateString()}                        ║\n-- ╚══════════════════════════════════════════════╝\n\n`;
  const toc=cids.map((c,i)=>`-- [${i+1}] ${names[i]} (${types[i]})`).join('\n');
  const body=cids.map((cid,i)=>{
    const code=csGet(cid), name=names[i]||('Script_'+(i+1)), type=types[i]||'Script';
    return `\n\n-- ─────────────────────────────────────────────\n-- FILE ${i+1}: ${name} [${type}]\n-- ─────────────────────────────────────────────\n${code}`;
  }).join('');
  doClipboard(header+toc+body, `✓ Bundle of ${cids.length} scripts copied!`, 'ok', 4000);
  totalCopied+=cids.length; sv(); updateStats();
}
function doClipboard(text, successMsg, type, dur){
  navigator.clipboard.writeText(text).then(()=>toast(successMsg,type,dur)).catch(()=>{
    const t=document.createElement('textarea'); t.value=text; document.body.appendChild(t); t.select(); document.execCommand('copy'); t.remove(); toast(successMsg,type,dur);
  });
}

// ══════════════════════════════════════════════════════════
// GLOBAL EXPOSE
// ══════════════════════════════════════════════════════════
window.startApp=startApp; window.logout=logout; window.newChat=newChat;
window.openChat=openChat; window.deleteChat=deleteChat; window.switchTab=switchTab;
window.sendMessage=sendMessage; window.quickPrompt=quickPrompt;
window.copyBlockText=copyBlockText; window.copyByCid=copyByCid;
window.copyAllByCids=copyAllByCids; window.copyAsBundle=copyAsBundle;
window.inputKey=inputKey; window.autoResize=autoResize; window.updateCharCounter=updateCharCounter;
window.filterTemplates=filterTemplates; window.toggleSidebar=toggleSidebar;
window.showShortcuts=showShortcuts; window.closeShortcuts=closeShortcuts;
</script>
</body>
</html>