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
}
html,body{background:var(--bg);color:var(--text);font-family:var(--fm);font-size:13px;height:100%;overflow:hidden}
::-webkit-scrollbar{width:3px;height:3px}
::-webkit-scrollbar-track{background:transparent}
::-webkit-scrollbar-thumb{background:rgba(255,255,255,0.06);border-radius:2px}
::-webkit-scrollbar-thumb:hover{background:rgba(255,255,255,0.12)}
body::before{content:'';position:fixed;inset:0;
  background:radial-gradient(ellipse 80% 60% at 20% -5%,rgba(0,240,255,0.035),transparent),
    radial-gradient(ellipse 60% 70% at 80% 100%,rgba(139,92,246,0.04),transparent),
    radial-gradient(ellipse 40% 40% at 60% 40%,rgba(16,185,129,0.015),transparent);
  pointer-events:none;z-index:0}

/* AUTH */
#auth{position:fixed;inset:0;display:flex;align-items:center;justify-content:center;z-index:999;background:var(--bg)}
#auth.gone{display:none}
.auth-orbs{position:absolute;inset:0;overflow:hidden;pointer-events:none}
.auth-orb{position:absolute;border-radius:50%;filter:blur(80px);animation:orbFloat 8s ease-in-out infinite}
.auth-orb:nth-child(1){width:500px;height:500px;background:rgba(0,240,255,0.04);top:-10%;left:-10%}
.auth-orb:nth-child(2){width:600px;height:600px;background:rgba(139,92,246,0.05);bottom:-20%;right:-15%;animation-delay:3s}
.auth-orb:nth-child(3){width:300px;height:300px;background:rgba(16,185,129,0.03);top:40%;left:60%;animation-delay:5s}
@keyframes orbFloat{0%,100%{transform:translate(0,0) scale(1)}33%{transform:translate(20px,-15px) scale(1.05)}66%{transform:translate(-10px,20px) scale(0.97)}}
.auth-wrap{width:440px;position:relative;z-index:2}
.auth-brand{display:flex;align-items:center;gap:14px;margin-bottom:2.8rem}
.auth-brand-mark{width:44px;height:44px;background:linear-gradient(135deg,var(--c1),var(--c2));border-radius:12px;display:flex;align-items:center;justify-content:center;font-size:20px;position:relative;overflow:hidden}
.auth-brand-glow{position:absolute;inset:-4px;background:linear-gradient(135deg,var(--c1),var(--c2));border-radius:16px;opacity:0.25;filter:blur(12px);z-index:-1;animation:brandGlow 3s ease-in-out infinite}
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
.field input:focus{border-color:var(--c1);box-shadow:0 0 0 4px rgba(0,240,255,0.06)}
.field input::placeholder{color:var(--text3)}
.btn-main{width:100%;background:linear-gradient(135deg,var(--c1),#0090ff);color:#030508;border:none;border-radius:var(--r);padding:13px;font-family:var(--fd);font-weight:900;font-size:12px;letter-spacing:.08em;cursor:pointer;transition:all .2s;text-transform:uppercase;position:relative;overflow:hidden}
.btn-main:hover{box-shadow:0 0 40px rgba(0,240,255,0.4);transform:translateY(-2px)}
.auth-err{color:var(--c5);font-size:10px;margin-top:7px;display:none;font-family:var(--fb)}
.auth-stats{display:flex;gap:1px;margin-top:1.5rem;overflow:hidden;border-radius:10px;border:.5px solid var(--border)}
.auth-stat{flex:1;padding:10px 8px;background:var(--bg3);text-align:center}
.auth-stat-num{font-family:var(--fd);font-size:16px;font-weight:900;color:var(--c1)}
.auth-stat-label{font-size:8px;color:var(--text3);margin-top:2px;font-family:var(--fb);text-transform:uppercase;letter-spacing:.1em}

/* APP */
#app{display:none;height:100%;flex-direction:column;position:relative;z-index:1}
#app.show{display:flex}

/* TOPBAR */
.topbar{height:var(--topbar);border-bottom:.5px solid var(--border);display:flex;align-items:center;padding:0 1rem;gap:.75rem;background:rgba(3,5,8,0.98);flex-shrink:0;z-index:100}
.topbar-brand{display:flex;align-items:center;gap:9px;flex-shrink:0}
.topbar-brand-mark{width:26px;height:26px;background:linear-gradient(135deg,var(--c1),var(--c2));border-radius:7px;display:flex;align-items:center;justify-content:center;font-size:12px}
.topbar-brand-name{font-family:var(--fd);font-size:13px;font-weight:900;color:var(--text)}
.topbar-brand-ver{font-size:8px;color:var(--text3);font-family:var(--fb);margin-left:4px;padding:1px 5px;background:var(--bg3);border:.5px solid var(--border);border-radius:4px;letter-spacing:.1em}
.topbar-sep{width:.5px;height:16px;background:var(--border2);margin:0 4px}
.mode-badge{display:flex;align-items:center;gap:5px;padding:4px 10px;background:var(--bg3);border:.5px solid var(--border2);border-radius:20px;font-size:9px;font-family:var(--fb)}
.mode-badge.kb{border-color:rgba(16,185,129,0.4);color:var(--c3);background:var(--c3d)}
.mode-badge.ai{border-color:rgba(139,92,246,0.5);color:#a78bfa;background:var(--c2d)}
.live-dot{width:6px;height:6px;border-radius:50%;background:var(--c3);animation:livePulse 2s infinite;flex-shrink:0}
@keyframes livePulse{0%,100%{box-shadow:0 0 0 0 rgba(16,185,129,0.4)}50%{box-shadow:0 0 0 4px rgba(16,185,129,0)}}
.topbar-center{flex:1;display:flex;align-items:center;justify-content:center;gap:8px}
.topbar-stat{display:flex;align-items:center;gap:5px;font-size:9px;color:var(--text3);font-family:var(--fb);padding:3px 8px;background:var(--bg3);border:.5px solid var(--border);border-radius:10px}
.topbar-stat-val{color:var(--text2)}
.topbar-right{margin-left:auto;display:flex;align-items:center;gap:6px}
.user-chip{display:flex;align-items:center;gap:7px;padding:3px 11px 3px 4px;background:var(--bg3);border:.5px solid var(--border2);border-radius:20px;cursor:pointer}
.user-ava{width:24px;height:24px;border-radius:50%;background:linear-gradient(135deg,var(--rbx),#ff6b6b);display:flex;align-items:center;justify-content:center;font-size:10px;font-weight:700;color:white;flex-shrink:0;font-family:var(--fb)}
.user-name{font-size:10px;color:var(--text);font-family:var(--fb)}
.logout-btn{color:var(--text3);cursor:pointer;margin-left:4px;font-size:10px;transition:color .15s}
.logout-btn:hover{color:var(--c5)}
.icon-btn{width:30px;height:30px;border-radius:7px;background:var(--bg3);border:.5px solid var(--border);display:flex;align-items:center;justify-content:center;cursor:pointer;font-size:12px;transition:all .15s}
.icon-btn:hover{border-color:var(--border2);background:var(--bg4)}

/* APP BODY */
.app-body{flex:1;display:flex;overflow:hidden;min-height:0}

/* SIDEBAR */
.sidebar{width:var(--sidebar);flex-shrink:0;border-right:.5px solid var(--border);display:flex;flex-direction:column;background:var(--bg2);overflow:hidden;transition:width .25s}
.sidebar.collapsed{width:0}
.sidebar-top{padding:10px 10px 8px;border-bottom:.5px solid var(--border);flex-shrink:0}
.new-chat-btn{width:100%;display:flex;align-items:center;gap:8px;padding:9px 11px;background:var(--bg3);border:.5px solid var(--border2);border-radius:8px;font-family:var(--fm);font-size:10px;color:var(--text2);cursor:pointer;transition:all .15s;text-align:left}
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
.sidebar-tool-icon{font-size:14px;flex-shrink:0;width:20px;text-align:center;margin-top:1px}
.sidebar-tool-body{flex:1;min-width:0}
.sidebar-tool-title{font-weight:600;font-size:10px;color:var(--text);margin-bottom:1px}
.sidebar-tool-desc{font-size:8px;color:var(--text3);line-height:1.5}
.tmpl-badge{font-size:7px;padding:1px 5px;border-radius:8px;font-weight:700;letter-spacing:.04em;margin-left:auto;flex-shrink:0;align-self:flex-start;margin-top:2px}
.tmpl-badge.new{background:rgba(16,185,129,0.1);color:var(--c3);border:.5px solid rgba(16,185,129,0.25)}
.tmpl-badge.adv{background:rgba(139,92,246,0.1);color:#a78bfa;border:.5px solid rgba(139,92,246,0.25)}
.tmpl-badge.pro{background:rgba(245,158,11,0.1);color:var(--c4);border:.5px solid rgba(245,158,11,0.25)}
.tmpl-badge.ultra{background:rgba(239,68,68,0.1);color:#f87171;border:.5px solid rgba(239,68,68,0.25)}
.empty-history{padding:20px 8px;text-align:center}
.empty-history-icon{font-size:28px;margin-bottom:8px}
.empty-history-text{font-size:10px;color:var(--text3);line-height:1.7;font-family:var(--fb)}

/* CHAT MAIN */
.chat-main{flex:1;display:flex;flex-direction:column;overflow:hidden;min-height:0}
.welcome-screen{flex:1;display:flex;flex-direction:column;align-items:center;justify-content:center;padding:2rem;overflow-y:auto;position:relative}
.welcome-screen.hidden{display:none}
.welcome-glow{position:absolute;top:30%;left:50%;transform:translate(-50%,-50%);width:600px;height:400px;background:radial-gradient(ellipse,rgba(0,240,255,0.04),transparent 70%);pointer-events:none}
.welcome-logo{width:64px;height:64px;background:linear-gradient(135deg,var(--c1),var(--c2));border-radius:18px;display:flex;align-items:center;justify-content:center;font-size:28px;margin-bottom:1.5rem;box-shadow:0 0 60px rgba(0,240,255,0.2)}
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
.suggestion:hover{border-color:rgba(139,92,246,0.35);transform:translateY(-3px);box-shadow:0 12px 32px rgba(0,0,0,0.4)}
.sug-icon{font-size:20px;margin-bottom:7px}
.sug-title{font-size:10px;font-weight:700;color:var(--text);margin-bottom:3px;font-family:var(--fd)}
.sug-body{font-size:9px;color:var(--text2);line-height:1.5;font-family:var(--fb)}

/* MESSAGES */
.messages-wrap{flex:1;overflow-y:auto;padding:16px 0;display:flex;flex-direction:column}
.messages-wrap.hidden{display:none}
#messages-inner{display:flex;flex-direction:column;gap:4px}
.msg-row{display:flex;gap:13px;padding:8px 24px;align-items:flex-start;transition:background .15s}
.msg-row:hover{background:rgba(255,255,255,0.01)}
.msg-row.user{flex-direction:row-reverse}
.msg-avatar{width:30px;height:30px;border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:11px;font-weight:700;flex-shrink:0;margin-top:2px}
.msg-avatar.ai{background:linear-gradient(135deg,rgba(139,92,246,0.35),rgba(0,240,255,0.2));border:.5px solid rgba(139,92,246,0.4);color:var(--c1);font-size:12px}
.msg-avatar.user{background:linear-gradient(135deg,var(--rbx),#ff6b6b);color:white;font-family:var(--fb)}
.msg-content{flex:1;min-width:0;max-width:780px}
.msg-row.user .msg-content{display:flex;flex-direction:column;align-items:flex-end}
.msg-name{font-size:9px;font-weight:700;color:var(--text2);letter-spacing:.07em;text-transform:uppercase;margin-bottom:6px;font-family:var(--fb);display:flex;align-items:center;gap:7px}
.msg-mode-tag{font-size:8px;padding:1px 7px;border-radius:10px;font-weight:600;text-transform:none;letter-spacing:0}
.msg-mode-tag.kb{background:var(--c3d);color:var(--c3);border:.5px solid rgba(16,185,129,0.2)}
.msg-mode-tag.ai{background:var(--c2d);color:#a78bfa;border:.5px solid rgba(139,92,246,0.25)}
.msg-bubble{font-size:12px;line-height:1.85;color:var(--text);word-break:break-word;font-family:var(--fb)}
.msg-row.user .msg-bubble{background:rgba(0,240,255,0.05);border:.5px solid rgba(0,240,255,0.1);border-radius:14px 14px 3px 14px;padding:11px 15px;display:inline-block;text-align:left}
.msg-bubble pre{background:var(--bg2);border:.5px solid var(--border2);border-radius:12px;margin:12px 0;overflow:hidden}
.code-header{display:flex;align-items:center;justify-content:space-between;padding:8px 14px;border-bottom:.5px solid var(--border);background:var(--bg3)}
.code-lang{font-size:8px;color:var(--text2);letter-spacing:.12em;text-transform:uppercase;font-weight:700;font-family:var(--fb)}
.copy-code-btn{font-size:8px;color:var(--text3);cursor:pointer;padding:3px 9px;border:.5px solid var(--border);border-radius:4px;font-family:var(--fm);background:transparent;transition:all .15s}
.copy-code-btn:hover{border-color:var(--c1);color:var(--c1);background:var(--c1d)}
.code-body{padding:14px 16px;font-size:10.5px;color:var(--c1);line-height:1.8;overflow-x:auto;white-space:pre;font-family:var(--fm)}
.msg-bubble code{background:var(--bg3);border-radius:4px;padding:2px 7px;color:var(--c1);font-size:10px;font-family:var(--fm);border:.5px solid var(--border)}
.msg-bubble strong{color:var(--text);font-weight:700}
.msg-bubble h3{font-family:var(--fd);font-size:12px;font-weight:800;color:var(--text);margin:8px 0 4px}
.msg-bubble ul{padding-left:16px;margin:6px 0}
.msg-bubble ul li{margin:3px 0;color:var(--text2)}
.msg-bubble p{margin:4px 0}

/* PLACEMENT / FILES CARD */
.placement-card{background:linear-gradient(145deg,var(--bg3),var(--bg2));border:.5px solid var(--border2);border-radius:12px;overflow:hidden;margin-bottom:10px}
.placement-card-header{padding:9px 14px;border-bottom:.5px solid var(--border);background:var(--bg3);font-size:9px;font-weight:700;color:var(--text);text-transform:uppercase;letter-spacing:.1em;font-family:var(--fb)}
.placement-card-body{padding:10px 14px;display:flex;flex-direction:column;gap:6px}
.placement-row{display:flex;align-items:flex-start;gap:10px;font-size:10px}
.placement-label{min-width:90px;flex-shrink:0;font-size:9px;color:var(--text3);text-transform:uppercase;letter-spacing:.08em;padding-top:1px;font-family:var(--fb)}
.placement-val{color:var(--text2);flex:1;line-height:1.5;font-family:var(--fb)}
.placement-path{color:var(--c1);font-family:var(--fm);font-size:10px}
.placement-badge{display:inline-flex;align-items:center;gap:5px;padding:3px 10px;border-radius:20px;font-size:9px;font-weight:700;font-family:var(--fb)}
.placement-badge.server{background:rgba(239,68,68,0.1);color:#f87171;border:.5px solid rgba(239,68,68,0.25)}
.placement-badge.local{background:var(--c1d);color:var(--c1);border:.5px solid rgba(0,240,255,0.2)}
.placement-badge.module{background:var(--c2d);color:#a78bfa;border:.5px solid rgba(139,92,246,0.25)}
.script-actions{display:flex;align-items:center;gap:6px;margin-top:10px;flex-wrap:wrap}
.sact-btn{display:flex;align-items:center;gap:5px;padding:7px 13px;background:var(--bg3);border:.5px solid var(--border2);border-radius:8px;font-size:9px;color:var(--text2);cursor:pointer;transition:all .15s;font-family:var(--fb);font-weight:500}
.sact-btn:hover{border-color:var(--c1);color:var(--c1)}
.sact-btn.prim{background:rgba(0,240,255,0.08);color:var(--c1);border-color:rgba(0,240,255,0.25);font-weight:700}
.sact-btn.prim:hover{background:var(--c1);color:#030508;box-shadow:0 0 24px rgba(0,240,255,0.3)}

/* TYPING */
.typing-dots{display:flex;gap:4px;padding:6px 2px}
.typing-dots span{width:5px;height:5px;border-radius:50%;background:var(--c2);animation:td .9s infinite both}
.typing-dots span:nth-child(2){animation-delay:.2s}
.typing-dots span:nth-child(3){animation-delay:.4s}
@keyframes td{0%,80%,100%{opacity:.2;transform:scale(.75)}40%{opacity:1;transform:scale(1)}}
.stream-cursor::after{content:'▋';animation:blink .7s infinite;color:var(--c1);font-size:10px;margin-left:2px}
@keyframes blink{0%,100%{opacity:1}50%{opacity:0}}

/* INPUT */
.input-area{padding:12px 20px 18px;flex-shrink:0;border-top:.5px solid var(--border);background:linear-gradient(0deg,var(--bg) 70%,transparent)}
.input-wrap{max-width:800px;margin:0 auto;background:linear-gradient(145deg,var(--bg2),var(--bg3));border:.5px solid var(--border2);border-radius:16px;overflow:hidden;transition:border-color .25s,box-shadow .25s}
.input-wrap:focus-within{border-color:rgba(139,92,246,0.4);box-shadow:0 0 0 4px rgba(139,92,246,0.05),0 8px 32px rgba(0,0,0,0.3)}
.input-top{display:flex;align-items:flex-end;padding:11px 13px 9px}
.main-input{flex:1;background:transparent;border:none;outline:none;font-family:var(--fm);font-size:12px;color:var(--text);resize:none;line-height:1.75;max-height:180px;min-height:22px}
.main-input::placeholder{color:var(--text3)}
.send-btn{width:36px;height:36px;border-radius:9px;background:var(--c2);color:white;border:none;cursor:pointer;display:flex;align-items:center;justify-content:center;font-size:14px;transition:all .15s;flex-shrink:0;margin-left:9px;align-self:flex-end}
.send-btn:hover{background:#7c3aed;box-shadow:0 0 24px rgba(139,92,246,0.5);transform:scale(1.05)}
.send-btn:disabled{opacity:.3;cursor:not-allowed;transform:none}
.input-bottom{padding:6px 13px 10px;display:flex;align-items:center;gap:5px;border-top:.5px solid var(--border);flex-wrap:wrap}
.quick-chip{padding:3px 10px;background:transparent;border:.5px solid var(--border);border-radius:12px;font-size:8px;color:var(--text3);cursor:pointer;font-family:var(--fb);transition:all .12s;white-space:nowrap;font-weight:500}
.quick-chip:hover{border-color:rgba(139,92,246,0.4);color:#a78bfa;background:var(--c2d)}
.input-hint{margin-left:auto;font-size:8px;color:var(--text3);white-space:nowrap;font-family:var(--fb)}

/* TOASTS */
#toasts{position:fixed;bottom:1.2rem;right:1.2rem;display:flex;flex-direction:column;gap:6px;z-index:9999}
.toast{background:var(--bg2);border:.5px solid var(--border2);border-radius:10px;padding:10px 15px;font-size:10px;display:flex;align-items:center;gap:9px;min-width:220px;max-width:380px;animation:tin .2s ease;line-height:1.6;font-family:var(--fb);box-shadow:0 8px 24px rgba(0,0,0,0.4)}
.toast.ok{border-left:2px solid var(--c3)}
.toast.bad{border-left:2px solid var(--c5)}
.toast.info{border-left:2px solid var(--c1)}
@keyframes tin{from{opacity:0;transform:translateX(18px)}to{opacity:1;transform:translateX(0)}}

/* SHORTCUTS PANEL */
.shortcuts-panel{position:fixed;inset:0;background:rgba(3,5,8,0.85);z-index:500;display:none;align-items:center;justify-content:center;backdrop-filter:blur(10px)}
.shortcuts-panel.show{display:flex}
.shortcuts-card{background:var(--bg2);border:.5px solid var(--border3);border-radius:16px;padding:1.8rem;min-width:420px;max-width:500px}
.shortcuts-card h3{font-family:var(--fd);font-size:16px;font-weight:900;margin-bottom:1.2rem;color:var(--text)}
.shortcut-row{display:flex;align-items:center;justify-content:space-between;padding:8px 0;border-bottom:.5px solid var(--border)}
.shortcut-row:last-child{border-bottom:none}
.shortcut-desc{font-size:11px;color:var(--text2);font-family:var(--fb)}
.shortcut-key{display:flex;gap:4px}
.key{padding:3px 8px;background:var(--bg3);border:.5px solid var(--border2);border-radius:5px;font-family:var(--fm);font-size:9px;color:var(--text)}
</style>
</head>
<body>

<!-- AUTH -->
<div id="auth">
  <div class="auth-orbs"><div class="auth-orb"></div><div class="auth-orb"></div><div class="auth-orb"></div></div>
  <div class="auth-wrap">
    <div class="auth-brand">
      <div style="position:relative">
        <div class="auth-brand-glow"></div>
        <div class="auth-brand-mark">✦</div>
      </div>
      <div class="auth-brand-info">
        <div class="name">Studio Bridge</div>
        <div class="ver">Version 5 · Ultra Edition · No API Key Needed</div>
      </div>
    </div>
    <div class="auth-card">
      <h2>The Ultimate Roblox Dev Studio</h2>
      <p>Fully offline — uses a built-in 200+ topic Roblox knowledge base. For complex scripts, also connects to Claude AI automatically. No API key, no setup, no cost.</p>
      <div class="auth-features">
        <div class="auth-feat"><div class="auth-feat-dot" style="background:var(--c1)"></div>60+ Script Templates</div>
        <div class="auth-feat"><div class="auth-feat-dot" style="background:var(--c3)"></div>200+ Knowledge Topics</div>
        <div class="auth-feat"><div class="auth-feat-dot" style="background:var(--c2)"></div>Auto Script Placement</div>
        <div class="auth-feat"><div class="auth-feat-dot" style="background:var(--c4)"></div>Works Offline Too</div>
        <div class="auth-feat"><div class="auth-feat-dot" style="background:var(--c6)"></div>3D Model Builders</div>
        <div class="auth-feat"><div class="auth-feat-dot" style="background:var(--c7)"></div>No API Key Required</div>
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
        <div class="auth-stat"><div class="auth-stat-num">0</div><div class="auth-stat-label">API Keys</div></div>
        <div class="auth-stat"><div class="auth-stat-num">∞</div><div class="auth-stat-label">Chats</div></div>
      </div>
    </div>
  </div>
</div>

<!-- SHORTCUTS -->
<div class="shortcuts-panel" id="shortcuts-panel" onclick="closeShortcuts(event)">
  <div class="shortcuts-card">
    <h3>⌨ Keyboard Shortcuts</h3>
    <div class="shortcut-row"><span class="shortcut-desc">Send message</span><span class="shortcut-key"><span class="key">Enter</span></span></div>
    <div class="shortcut-row"><span class="shortcut-desc">New line</span><span class="shortcut-key"><span class="key">Shift</span><span class="key">Enter</span></span></div>
    <div class="shortcut-row"><span class="shortcut-desc">New conversation</span><span class="shortcut-key"><span class="key">Ctrl</span><span class="key">K</span></span></div>
    <div class="shortcut-row"><span class="shortcut-desc">Toggle sidebar</span><span class="shortcut-key"><span class="key">Ctrl</span><span class="key">B</span></span></div>
    <div class="shortcut-row"><span class="shortcut-desc">Show shortcuts</span><span class="shortcut-key"><span class="key">Ctrl</span><span class="key">?</span></span></div>
    <div class="shortcut-row"><span class="shortcut-desc">Close</span><span class="shortcut-key"><span class="key">Esc</span></span></div>
  </div>
</div>

<!-- APP -->
<div id="app">
  <div class="topbar">
    <div class="topbar-brand">
      <div class="topbar-brand-mark">✦</div>
      <div class="topbar-brand-name">Studio Bridge</div>
      <span class="topbar-brand-ver">v5 ULTRA</span>
    </div>
    <div class="topbar-sep"></div>
    <div class="mode-badge kb" id="mode-badge"><div class="live-dot"></div><span id="mode-badge-txt">Knowledge Base ⚡</span></div>
    <div class="topbar-center">
      <div class="topbar-stat">💬 <span class="topbar-stat-val" id="stat-msgs">0</span> msgs</div>
      <div class="topbar-stat">📁 <span class="topbar-stat-val" id="stat-chats">0</span> chats</div>
      <div class="topbar-stat">📋 <span class="topbar-stat-val" id="stat-copied">0</span> copied</div>
    </div>
    <div class="topbar-right">
      <div class="icon-btn" onclick="showShortcuts()" title="Shortcuts">⌨</div>
      <div class="icon-btn" onclick="toggleSidebar()" id="sidebar-toggle">◀</div>
      <div class="user-chip">
        <div class="user-ava" id="top-ava">?</div>
        <span class="user-name" id="top-name">—</span>
        <span class="logout-btn" onclick="logout()">⏻</span>
      </div>
    </div>
  </div>

  <div class="app-body">
    <div class="sidebar" id="sidebar">
      <div class="sidebar-top">
        <button class="new-chat-btn" onclick="newChat()"><span>✦</span> New Chat <span style="margin-left:auto;font-size:16px">+</span></button>
      </div>
      <div class="sidebar-search">
        <input class="sidebar-search-input" type="text" placeholder="🔍 Search templates…" oninput="filterTemplates(this.value)"/>
      </div>
      <div class="tmpl-tabs">
        <div class="tmpl-tab active" onclick="switchTab('history',this)">History</div>
        <div class="tmpl-tab" onclick="switchTab('starter',this)">Starter</div>
        <div class="tmpl-tab" onclick="switchTab('scripting',this)">Scripts</div>
        <div class="tmpl-tab" onclick="switchTab('gui',this)">GUI</div>
        <div class="tmpl-tab" onclick="switchTab('systems',this)">Systems</div>
        <div class="tmpl-tab" onclick="switchTab('building',this)">Build</div>
        <div class="tmpl-tab" onclick="switchTab('advanced',this)">Advanced</div>
      </div>
      <div class="tmpl-panel active" id="panel-history"><div id="chat-history"><div class="empty-history"><div class="empty-history-icon">💬</div><div class="empty-history-text">No conversations yet.<br>Ask anything to get started!</div></div></div></div>
      <div class="tmpl-panel" id="panel-starter"><div id="starter-tools"></div></div>
      <div class="tmpl-panel" id="panel-scripting"><div id="scripting-tools"></div></div>
      <div class="tmpl-panel" id="panel-gui"><div id="gui-tools"></div></div>
      <div class="tmpl-panel" id="panel-systems"><div id="systems-tools"></div></div>
      <div class="tmpl-panel" id="panel-building"><div id="building-tools"></div></div>
      <div class="tmpl-panel" id="panel-advanced"><div id="advanced-tools"></div></div>
    </div>

    <div class="chat-main">
      <div class="welcome-screen" id="welcome-screen">
        <div class="welcome-glow"></div>
        <div class="welcome-logo">✦</div>
        <div class="welcome-title">What can I help you build?</div>
        <div class="welcome-sub">Studio Bridge v5 Ultra — 200+ Roblox knowledge topics built-in, plus AI for complex scripts. No API key needed. Ask anything!</div>
        <div class="welcome-badges">
          <div class="welcome-badge wb-green">⚡ Instant KB Answers</div>
          <div class="welcome-badge wb-purple">🧠 AI for Complex Scripts</div>
          <div class="welcome-badge wb-cyan">🔑 Zero API Key</div>
          <div class="welcome-badge wb-orange">📁 60+ Templates</div>
        </div>
        <div class="suggestion-grid">
          <div class="suggestion" onclick="quickPrompt('Build a complete coin pickup system with spinning effect, glow, leaderboard stat, and DataStore save with pcall retry. Name all scripts.')"><div class="sug-icon">🪙</div><div class="sug-title">Coin System</div><div class="sug-body">Animated coins, leaderboard, DataStore</div></div>
          <div class="suggestion" onclick="quickPrompt('Build an advanced boss NPC with pathfinding, AoE slam, ranged projectile phase, shield mechanic, billboard health bar, and loot drop table.')"><div class="sug-icon">💀</div><div class="sug-title">Boss NPC</div><div class="sug-body">3-phase boss with attacks and drops</div></div>
          <div class="suggestion" onclick="quickPrompt('Create a complete round-based game loop: lobby, map voting, player teleport, round timer GUI, winner detection, and intermission countdown.')"><div class="sug-icon">🎮</div><div class="sug-title">Round System</div><div class="sug-body">Lobby → vote → round → winner → repeat</div></div>
          <div class="suggestion" onclick="quickPrompt('What is the difference between Script, LocalScript and ModuleScript? When should I use each one?')"><div class="sug-icon">📜</div><div class="sug-title">Script Types</div><div class="sug-body">Script vs LocalScript vs ModuleScript</div></div>
          <div class="suggestion" onclick="quickPrompt('Build a detailed procedural 3D castle in Lua using only BaseParts and WeldConstraints: 4 corner towers, connecting walls, main keep, portcullis gate.')"><div class="sug-icon">🏰</div><div class="sug-title">3D Castle Builder</div><div class="sug-body">Procedural castle from pure Lua</div></div>
          <div class="suggestion" onclick="quickPrompt('How do RemoteEvents work? Show me the complete server to client and client to server flow with validation and rate limiting.')"><div class="sug-icon">📡</div><div class="sug-title">RemoteEvents</div><div class="sug-body">Client-server communication guide</div></div>
        </div>
      </div>

      <div class="messages-wrap hidden" id="messages-wrap">
        <div id="messages-inner"></div>
      </div>

      <div class="input-area">
        <div class="input-wrap">
          <div class="input-top">
            <textarea class="main-input" id="main-input" placeholder="Ask about scripts, GUI, 3D models, systems… anything Roblox!" rows="1" onkeydown="inputKey(event)" oninput="autoResize(this)"></textarea>
            <button class="send-btn" id="send-btn" onclick="sendMessage()">▶</button>
          </div>
          <div class="input-bottom">
            <span class="quick-chip" onclick="quickPrompt('What is the difference between Script, LocalScript and ModuleScript?')">Script Types</span>
            <span class="quick-chip" onclick="quickPrompt('How do RemoteEvents work? Show server and client examples.')">RemoteEvents</span>
            <span class="quick-chip" onclick="quickPrompt('How do I save player data with DataStore? Show a safe example with pcall.')">DataStore</span>
            <span class="quick-chip" onclick="quickPrompt('Build a complete anti-exploit suite: position checks, speed detection, rate limiter.')">Anti-Cheat</span>
            <span class="quick-chip" onclick="quickPrompt('Build a complete pet system: rarities, egg opening, pet follow, stat boosts, DataStore saving.')">Pet System</span>
            <span class="quick-chip" onclick="quickPrompt('How do I use TweenService to animate GUI elements? Show examples.')">TweenService</span>
            <span class="quick-chip" onclick="quickPrompt('Explain Parallel Luau with Actors and show how to use it for pathfinding.')">Parallel Luau</span>
            <span class="input-hint">Enter ↵ send · Shift+Enter line · Ctrl+K new chat</span>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<div id="toasts"></div>

<script>
// ══════════════════════════════════════════════════════════
// BUILT-IN KNOWLEDGE BASE (from Flask backend, ported to JS)
// ══════════════════════════════════════════════════════════
const KNOWLEDGE = {
  "part": "Parts are the basic building blocks in Roblox. Use BasePart, MeshPart, SpecialMesh or UnionOperation to create 3D shapes! Every 3D object in Roblox is made of parts.",
  "basepart": "BasePart is the foundation of all 3D objects in Roblox. Key properties: Size (Vector3), Position (Vector3), Orientation (Vector3), Color (Color3), Material (Enum), Anchored (bool), CanCollide (bool), Transparency (0-1), Reflectance (0-1).",
  "meshpart": "MeshPart lets you import custom 3D meshes (.fbx or .obj files) into Roblox Studio. Go to Insert > MeshPart to add one! You can scale, texture and animate MeshParts just like regular parts.",
  "union": "Union combines multiple parts into one shape. Select parts, right click, Union. Great for making complex shapes! Unions reduce part count and improve performance.",
  "negate": "Negate carves holes into parts. Select a part, right click, Negate, then Union it with another part to cut shapes! Use it to make windows, tunnels and hollow objects.",
  "wedgepart": "WedgePart is a built-in triangle wedge shape. Great for ramps, roofs and diagonal surfaces! Combine multiple wedges for complex geometry.",
  "specialmesh": "SpecialMesh inserted into a part changes its shape. MeshType options: Sphere, Cylinder, Wedge, Torso, Head, FileMesh (custom). Set Scale to resize the mesh independently of the part.",
  "material": "Roblox materials: SmoothPlastic, Wood, WoodPlanks, Brick, Cobblestone, Metal, DiamondPlate, Foil, Grass, Ice, Marble, Granite, Sandstone, Fabric, Glass, Neon, ForceField, Air, Water, Rock, Glacier, Snow, Mud, Basalt, Ground, CrackedLava, Asphalt, LeafyGrass, Salt, Limestone, Pavement!",
  "texture": "Add a Texture object inside a part to apply a tiling image texture. Set Face (Top/Bottom/Front/Back/Left/Right), StudsPerTileU (horizontal repeat) and StudsPerTileV (vertical repeat).",
  "decal": "Decals apply images to one face of a part without tiling. Insert Decal into a part and set Texture property to rbxassetid://IMAGEID. Useful for signs, posters and logos.",
  "surfaceappearance": "SurfaceAppearance gives parts realistic PBR textures. Properties: ColorMap (albedo), NormalMap (bumps), RoughnessMap (shininess), MetalnessMap (metallic look). Insert inside any part for AAA quality visuals!",
  "color": "Set part color: part.Color = Color3.fromRGB(255,0,0) for red. Or use BrickColor: part.BrickColor = BrickColor.new('Bright red'). Color3.fromHSV() for hue and saturation control.",
  "transparency": "part.Transparency ranges from 0 (fully solid) to 1 (fully invisible). 0.5 gives a glass-like look. Animate transparency with TweenService for fade effects!",
  "weld": "WeldConstraint rigidly connects two parts. Set Part0 and Part1. They move together perfectly. Survives physics simulation unlike the old Weld joint.",
  "weldconstraint": "WeldConstraint is the modern recommended way to attach parts. Insert it anywhere, set Part0 and Part1. No C0/C1 offset math needed!",
  "motor6d": "Motor6D is an animated joint for character rigs. Used by the animation system to rotate body parts. Has C0, C1 offsets and Transform property.",
  "hingeconstraint": "HingeConstraint rotates parts around one axis like a door hinge. Set Attachment0 and Attachment1, then set ActuatorType for motors or servos.",
  "springconstraint": "SpringConstraint creates a bouncy spring between two Attachments. Set Stiffness (force), Damping (resistance) and FreeLength (rest length).",
  "ropeconstraint": "RopeConstraint connects parts with a maximum length rope. Parts can get closer but not farther than Length. Great for swinging and hanging objects!",
  "attachment": "Attachments are invisible points on parts used as connection points for constraints, beams and trails. Position them precisely for correct joint behavior.",
  "anchored": "part.Anchored = true makes part stay fixed and ignore physics and gravity. Always anchor building parts, terrain decorations and static objects!",
  "cancollide": "part.CanCollide = false lets parts pass through each other. Use for visual effects, trigger zones and decorations that should not block movement.",
  "model": "Model groups related parts into one unit. Set PrimaryPart for easy positioning. Use model:SetPrimaryPartCFrame(cf) to move the whole model at once.",
  "folder": "Folder organizes objects in Explorer without affecting gameplay. Use for grouping scripts, sounds, remotes and configs. Has no physical presence.",
  "lighting": "Lighting service controls the whole scene: Ambient (shadow color), Brightness (sun intensity), ClockTime (0-24 hour), GeographicLatitude, FogEnd, FogColor, FogStart, EnvironmentDiffuseScale, EnvironmentSpecularScale.",
  "pointlight": "PointLight emits light equally in all directions from a part. Properties: Brightness, Range, Color, Shadows, Enabled. Insert inside any part.",
  "spotlight": "SpotLight emits a cone of light from a part face. Properties: Brightness, Range, Angle (cone width), Face, Color, Shadows. Great for flashlights and stage lights!",
  "surfacelight": "SurfaceLight emits light from one face of a part. Perfect for TV screens, monitors, neon signs and glowing panels!",
  "bloom": "Bloom post-processing in Lighting creates a beautiful glow around bright objects. Properties: Intensity, Size, Threshold. Adds cinematic quality!",
  "atmosphere": "Atmosphere in Lighting creates realistic sky atmosphere. Properties: Density (fog amount), Offset, Color (sky tint), Decay, Glare, Haze. Makes skies look real!",
  "colorcorrection": "ColorCorrection post-processing adjusts Brightness, Contrast, Saturation and TintColor for the whole scene. Great for moods and time-of-day effects!",
  "depthofffield": "DepthOfField blurs objects outside a focus range like a camera lens. Properties: FocusDistance, InFocusRadius, NearIntensity, FarIntensity.",
  "sky": "Sky object in Lighting sets a custom skybox using 6 face images: SkyboxBk (back), SkyboxDn (down), SkyboxFt (front), SkyboxLf (left), SkyboxRt (right), SkyboxUp (up).",
  "particleemitter": "ParticleEmitter creates particles from a part. Key properties: Texture, Rate (particles per sec), Lifetime (NumberRange), Speed, Size (NumberSequence), Color (ColorSequence), Rotation, LightEmission!",
  "beam": "Beam draws a textured band between two Attachments. Properties: Texture, TextureSpeed, Width0/Width1, Color, Transparency, LightEmission, Segments, CurveSize0/CurveSize1 for curves!",
  "trail": "Trail creates a motion trail behind a part between two Attachments. Properties: Texture, Lifetime, MinDistance, Color, Transparency, WidthScale, LightEmission.",
  "fire": "Fire effect: Color (inner), SecondaryColor (outer), Heat (rise speed), Size (scale). Insert inside any part for instant flames! Combine with PointLight for glow.",
  "smoke": "Smoke effect on a part: Color, Opacity (0-1), RiseVelocity (upward speed), Size (stud radius). Enabled property toggles it. Great for chimneys and fires!",
  "explosion": "Create Explosion instance: exp.BlastRadius (stud radius), exp.BlastPressure (force), exp.Position (center), exp.ExplosionType (NoCraters/Craters). Parent to workspace!",
  "billboardgui": "BillboardGui floats a GUI above a part in 3D space, always facing the camera. Set Adornee, Size (UDim2), StudsOffset. Great for name tags and health bars above NPCs!",
  "screengui": "ScreenGui is the main 2D GUI container displayed on player screen. Parent to PlayerGui. Set ResetOnSpawn = false to keep GUI across respawns.",
  "frame": "Frame is a rectangular container for other GUI elements. Properties: Size (UDim2), Position (UDim2), BackgroundColor3, BackgroundTransparency, BorderSizePixel, ClipsDescendants, ZIndex.",
  "textlabel": "TextLabel displays non-interactive text. Properties: Text, Font, TextSize, TextColor3, TextTransparency, TextStrokeColor3, TextWrapped, RichText, TextScaled.",
  "textbutton": "TextButton is a clickable button with text. Events: MouseButton1Click, MouseButton1Down, MouseEnter, MouseLeave. Style with BackgroundColor3, Font, TextSize.",
  "imagebutton": "ImageButton is a clickable button showing an image. Set Image to rbxassetid://ID. Events same as TextButton. Use HoverImage and PressedImage for different states!",
  "imagelabel": "ImageLabel displays a non-interactive image. Set Image property to asset ID. ScaleType: Stretch, Tile, Fit, Slice, Crop. Use ImageColor3 to tint the image.",
  "textbox": "TextBox lets players type input. Properties: PlaceholderText, Text, ClearTextOnFocus, MultiLine, TextEditable. Events: FocusLost(text, enterPressed), Focused.",
  "scrollingframe": "ScrollingFrame adds scrollable content area. Set CanvasSize (total content size), ScrollBarThickness, ScrollingEnabled, ScrollingDirection (X/Y/XY).",
  "viewportframe": "ViewportFrame renders 3D objects inside a 2D GUI! Insert models and parts into it with a Camera. Perfect for item previews and model displays in menus!",
  "udim2": "UDim2.new(scaleX, offsetX, scaleY, offsetY) positions and sizes GUI elements. Scale is 0-1 relative to parent, offset is pixels. UDim2.fromScale(0.5,0.5) = center!",
  "uilistlayout": "UIListLayout automatically arranges children in a list. Properties: FillDirection (X/Y), HorizontalAlignment, VerticalAlignment, SortOrder, Padding (UDim). Very powerful!",
  "uicorner": "UICorner rounds the corners of a Frame or Button. Set CornerRadius (UDim). UDim.new(1,0) = fully round circle, UDim.new(0,8) = 8px rounded corners!",
  "uistroke": "UIStroke adds an outline and border to GUI elements. Set Color, Thickness (pixels), Transparency, LineJoinMode, ApplyStrokeMode. Works on frames, labels, buttons!",
  "uigradient": "UIGradient applies a color and transparency gradient to a GUI element. Set Color (ColorSequence), Transparency (NumberSequence), Rotation, Offset.",
  "uipadding": "UIPadding adds padding inside a frame. Set PaddingTop, PaddingBottom, PaddingLeft, PaddingRight (all UDim). Prevents content from touching frame edges.",
  "uigridlayout": "UIGridLayout arranges children in a grid. Set CellSize (UDim2), CellPadding (UDim2), FillDirection, HorizontalAlignment, VerticalAlignment, SortOrder.",
  "tweengui": "TweenService works on GUI too! Tween Position, Size, BackgroundColor3, TextColor3, ImageTransparency and more. TweenService:Create(frame, TweenInfo.new(0.3), {Size=UDim2.new(1,0,1,0)}):Play()",
  "humanoid": "Humanoid is the core character controller. Properties: Health, MaxHealth, WalkSpeed (default 16), JumpPower (default 50), JumpHeight, AutoRotate, NameDisplayDistance, HealthDisplayDistance.",
  "humanoidrootpart": "HumanoidRootPart is the invisible root part of the character. Move character by setting its CFrame. It drives the whole character assembly position.",
  "moveto": "Humanoid:MoveTo(position) makes character walk to position. Pair with MoveToFinished event to detect arrival. Use PathfindingService for complex navigation!",
  "takeddamage": "Humanoid:TakeDamage(amount) reduces health accounting for ForceField protection. Always use this over setting Health directly for proper damage handling.",
  "pathfinding": "PathfindingService computes navigation paths avoiding obstacles. Create path: PFS:CreatePath(params), Compute: path:ComputeAsync(start, goal), Get waypoints: path:GetWaypoints().",
  "datastore": "DataStoreService saves player data between sessions. GetDataStore('name') returns a store. SetAsync(key, value) saves, GetAsync(key) loads, UpdateAsync for safe updates. Always wrap in pcall()!",
  "datastoreupdateasync": "UpdateAsync(key, function(old) return new end) safely updates data handling race conditions. Always use for player data that multiple servers might write!",
  "orderedatastore": "OrderedDataStore stores numbers sorted by value. GetSortedAsync() returns pages of keys sorted by value. Perfect for global leaderboards!",
  "script": "A Script (ServerScript) runs on the SERVER only.\n\n**Place in:** ServerScriptService (safest), never in Workspace.\n\n**Use for:** Game logic, DataStore saving, handling RemoteEvents, spawning NPCs, managing rounds.\n\n**Good names:** GameManager, DataHandler, RoundController, EnemySpawner, ShopServer, AntiExploit.\n\n**Never** use Script for GUI or client visuals — Scripts cannot access LocalPlayer!",
  "localscript": "A LocalScript runs on the CLIENT (each player's device) only.\n\n**Place in:**\n- StarterGui — for GUI scripts\n- StarterPlayerScripts — for input and camera\n- StarterCharacterScripts — runs on every character spawn\n- Inside a Tool — for tool input\n\n**Never** place in ServerScriptService!\n\n**Good names:** GUIController, InputHandler, CameraController, EffectsController, HUDManager.\n\n**Remember:** LocalScript can access LocalPlayer but cannot directly change server data. Use RemoteEvents to talk to server!",
  "modulescript": "A ModuleScript is a reusable library required by other scripts.\n\n**Place in:**\n- ReplicatedStorage — accessible by BOTH server and client (most common)\n- ServerScriptService — server-only modules\n\n**Use for:** Shared functions, configuration tables, utility functions, OOP classes, shared constants.\n\n**Good names:** Config, WeaponData, UILibrary, MathUtils, AnimationModule, ItemDatabase.\n\n**How to use:**\n```lua\n-- ModuleScript named 'Config' in ReplicatedStorage:\nlocal Config = {}\nConfig.WalkSpeed = 16\nConfig.MaxHealth = 100\nreturn Config\n\n-- In any Script or LocalScript:\nlocal Config = require(game.ReplicatedStorage.Config)\nprint(Config.WalkSpeed) -- 16\n```",
  "script naming": "**Script Naming Best Practices:**\n\nUse PascalCase — capitalize each word: GameManager, DataHandler, UIController.\nBe descriptive and specific — not 'Script1' but 'EnemySpawnHandler'.\n\n**Good Server Script names:** GameManager, RoundController, DataHandler, EnemyAI, ShopServer, AdminCommands, AntiExploit, LeaderboardUpdater.\n\n**Good LocalScript names:** GUIController, InputHandler, CameraController, CharacterAnimator, EffectsController, HUDManager, InventoryUI.\n\n**Good ModuleScript names:** Config, WeaponData, MapData, UILibrary, MathUtils, AnimationModule, GameConstants, ItemDatabase.\n\n**Bad names to avoid:** Script, LocalScript, Module, Script1, MyScript, Test, Untitled.",
  "script placement": "**Where to Place Scripts — Complete Guide:**\n\n**ServerScriptService** — Server Scripts only. Safe, cannot be accessed by clients. Best for: GameManager, DataHandler, EnemyAI, ShopServer, RoundController.\n\n**StarterGui** — LocalScripts for GUI. Best for: HealthBarUI, ShopGUI, InventoryUI, HUDController.\n\n**StarterPlayerScripts** — LocalScripts run once per player. Best for: InputHandler, CameraController, SoundController.\n\n**StarterCharacterScripts** — LocalScripts run every character spawn. Best for: CharacterAnimations, FootstepSounds.\n\n**ReplicatedStorage** — ModuleScripts accessible by everyone. Best for: Config, WeaponData, UILibrary, MathUtils.\n\n**ReplicatedFirst** — Scripts that load before everything else. Best for: LoadingScreen, CoreModules.\n\n**ServerStorage** — Assets only the server can access. Best for: ServerConfig, SecretData, NPC models.",
  "script communication": "**How Scripts Communicate:**\n\n**Server → Client:** RemoteEvent:FireClient(player, data) or :FireAllClients(data)\n\n**Client → Server:** RemoteEvent:FireServer(data) — server handles in OnServerEvent\n\n**Client asks Server:** RemoteFunction — client calls :InvokeServer(data), server returns result in OnServerInvoke\n\n**Setup example:**\n```lua\n-- 1. Create RemoteEvent in ReplicatedStorage named 'DamageEvent'\n\n-- Server Script:\ngame.ReplicatedStorage.DamageEvent.OnServerEvent:Connect(function(player, target, amount)\n    -- ALWAYS validate on server!\n    if amount > 0 and amount <= 100 then\n        target.Humanoid:TakeDamage(amount)\n    end\nend)\n\n-- LocalScript:\ngame.ReplicatedStorage.DamageEvent:FireServer(targetChar, 25)\n```\n\n**IMPORTANT:** Never trust client data on the server! Always validate what the client sends!",
  "remotevent": "RemoteEvent in ReplicatedStorage handles client-server communication.\n\n```lua\n-- Server Script:\nlocal Remote = game:GetService('ReplicatedStorage'):WaitForChild('MyEvent')\nRemote.OnServerEvent:Connect(function(player, data)\n    -- validate data here\n    print(player.Name, data)\nend)\n\n-- LocalScript:\nlocal Remote = game:GetService('ReplicatedStorage'):WaitForChild('MyEvent')\nRemote:FireServer('hello from client')\n```\n\nName remotes clearly: PurchaseEvent, DamageEvent, SpawnEvent.",
  "remotefunction": "RemoteFunction makes request-response calls between client and server.\n\n```lua\n-- Server Script:\nlocal RF = game:GetService('ReplicatedStorage'):WaitForChild('GetCoins')\nRF.OnServerInvoke = function(player)\n    return playerData[player.UserId].coins\nend\n\n-- LocalScript:\nlocal RF = game:GetService('ReplicatedStorage'):WaitForChild('GetCoins')\nlocal coins = RF:InvokeServer()\nprint('I have', coins, 'coins')\n```",
  "cframe": "CFrame combines position and rotation in one object.\n\n```lua\npart.CFrame = CFrame.new(0, 10, 0) -- move to position\npart.CFrame = CFrame.new(0,10,0) * CFrame.Angles(0, math.rad(45), 0) -- rotate 45°\n\n-- Move relative to current position:\npart.CFrame = part.CFrame * CFrame.new(0, 0, -5) -- move 5 studs forward\n\n-- Look at a point:\npart.CFrame = CFrame.lookAt(part.Position, targetPosition)\n```",
  "vector3": "Vector3.new(x,y,z) represents a 3D point, direction or size.\n\n```lua\nlocal v1 = Vector3.new(1, 0, 0)\nlocal v2 = Vector3.new(0, 1, 0)\nlocal sum = v1 + v2 -- (1, 1, 0)\nlocal mag = v1.Magnitude -- 1\nlocal dir = v1.Unit -- normalized direction\nlocal dot = v1:Dot(v2) -- 0 (perpendicular)\nlocal cross = v1:Cross(v2) -- (0, 0, 1)\n```",
  "tween": "TweenService smoothly animates any property!\n\n```lua\nlocal TweenService = game:GetService('TweenService')\nlocal info = TweenInfo.new(\n    0.5, -- time\n    Enum.EasingStyle.Quad,\n    Enum.EasingDirection.Out,\n    0, -- repeat count\n    false, -- reverses\n    0 -- delay\n)\nlocal tween = TweenService:Create(part, info, {Position = Vector3.new(0,10,0)})\ntween:Play()\ntween.Completed:Connect(function() print('done!') end)\n```",
  "tweeninfo": "TweenInfo.new(time, EasingStyle, EasingDirection, repeatCount, reverses, delayTime). EasingStyles: Linear, Sine, Quad, Cubic, Quart, Bounce, Elastic, Exponential, Circular, Back.",
  "raycast": "workspace:Raycast(origin, direction, RaycastParams) shoots an invisible ray.\n\n```lua\nlocal params = RaycastParams.new()\nparams.FilterDescendantsInstances = {character}\nparams.FilterType = Enum.RaycastFilterType.Exclude\n\nlocal result = workspace:Raycast(\n    gun.Position,\n    gun.CFrame.LookVector * 500,\n    params\n)\n\nif result then\n    print('Hit:', result.Instance.Name)\n    print('Position:', result.Position)\n    print('Normal:', result.Normal)\nend\n```",
  "pcall": "pcall() runs code safely and catches errors.\n\n```lua\nlocal ok, result = pcall(function()\n    return dataStore:GetAsync(key)\nend)\nif ok then\n    print('Data:', result)\nelse\n    warn('Error:', result)\nend\n```\n\nAlways use for DataStore, HTTP requests and anything that might fail!",
  "task": "task library is the modern way to manage timing.\n\n```lua\ntask.wait(2) -- wait 2 seconds (instead of wait())\ntask.spawn(function() -- run in new thread\n    print('parallel!')\nend)\ntask.delay(3, function() -- run after 3 seconds\n    print('delayed!')\nend)\ntask.defer(function() -- run next frame\n    print('deferred!')\nend)\n```\n\nAlways prefer task over old wait() and spawn()!",
  "waitforchild": "Always use :WaitForChild('name') in LocalScripts because the client may not have loaded everything yet.\n\n```lua\nlocal part = workspace:WaitForChild('MyPart')\nlocal remote = game.ReplicatedStorage:WaitForChild('MyEvent')\n-- With timeout:\nlocal tool = character:WaitForChild('Sword', 5) -- max 5 seconds\n```",
  "tweenservice": "TweenService:Create(obj, TweenInfo, goals):Play() animates properties smoothly. Chain with .Completed event. Works on parts, GUI, lights and more!",
  "runservice": "RunService.Heartbeat (every physics step), RenderStepped (every frame, LocalScript only), Stepped (before physics). Use for per-frame updates and game loops.",
  "collectionservice": "CollectionService manages tags on objects. :AddTag(instance, 'Enemy'), :GetTagged('Enemy'), :HasTag(instance, 'tag'). Great for categorizing objects without checking class or name!",
  "debris": "Debris:AddItem(instance, lifetime) auto-deletes instance after lifetime seconds. Perfect for temporary effects, projectiles and spawned objects!\n\n```lua\nlocal Debris = game:GetService('Debris')\nDebris:AddItem(bulletHole, 10) -- deletes after 10 seconds\n```",
  "userinputservice": "UserInputService detects keyboard, mouse and touch input.\n\n```lua\nlocal UIS = game:GetService('UserInputService')\nUIS.InputBegan:Connect(function(input, gameProcessed)\n    if gameProcessed then return end\n    if input.KeyCode == Enum.KeyCode.E then\n        print('E pressed!')\n    end\nend)\n```",
  "contextactionservice": "ContextActionService binds actions to keys and creates mobile buttons automatically.\n\n```lua\nlocal CAS = game:GetService('ContextActionService')\nCAS:BindAction('Interact', function(name, state, input)\n    if state == Enum.UserInputState.Begin then\n        print('Interacting!')\n    end\nend, true, Enum.KeyCode.E, Enum.KeyCode.ButtonX)\n```",
  "optimize": "**Performance Tips:**\n- Reduce part count with unions — under 5000 parts for mobile\n- Disable CastShadow on small decorative parts\n- Enable workspace.StreamingEnabled for large maps\n- Limit active ParticleEmitters\n- Use task.wait() not wait()\n- Pool objects instead of creating/destroying in loops\n- Use events instead of polling every frame\n- Profile with MicroProfiler (Ctrl+F6 in-game)",
  "streaming": "workspace.StreamingEnabled loads only nearby content to clients. StreamingMinRadius and StreamingTargetRadius control distances. Essential for large open-world games!",
  "multiplayer": "Roblox games run on servers with up to 100 players. Each server is isolated. Use MessagingService to communicate between servers. TeleportService to move players between servers.",
  "messagingservice": "MessagingService sends messages between all servers of your game.\n\n```lua\nlocal MS = game:GetService('MessagingService')\n-- Subscribe:\nMS:SubscribeAsync('GlobalAnnouncement', function(msg)\n    print('Message:', msg.Data)\nend)\n-- Publish:\nMS:PublishAsync('GlobalAnnouncement', 'Server shutting down!')\n```",
  "marketplace": "MarketplaceService handles game passes and products.\n\n```lua\nlocal MPS = game:GetService('MarketplaceService')\n-- Check gamepass:\nlocal ownsPass = MPS:UserOwnsGamePassAsync(player.UserId, PASS_ID)\n-- Prompt purchase:\nMPS:PromptGamePassPurchase(player, PASS_ID)\n-- Handle products:\nMPS.ProcessReceipt = function(receiptInfo)\n    -- give item, save receipt\n    return Enum.ProductPurchaseDecision.PurchaseGranted\nend\n```",
  "physicsservice": "PhysicsService manages collision groups. Lets you make players not collide with each other, NPCs ignore players, etc.\n\n```lua\nlocal PS = game:GetService('PhysicsService')\nPS:RegisterCollisionGroup('Players')\nPS:RegisterCollisionGroup('NPCs')\nPS:CollisionGroupSetCollidable('Players', 'Players', false)\n```",
  "oop": "Object-Oriented Programming in Lua:\n\n```lua\nlocal Enemy = {}\nEnemy.__index = Enemy\n\nfunction Enemy.new(name, health)\n    local self = setmetatable({}, Enemy)\n    self.name = name\n    self.health = health\n    return self\nend\n\nfunction Enemy:takeDamage(amount)\n    self.health = self.health - amount\n    if self.health <= 0 then\n        self:die()\n    end\nend\n\nfunction Enemy:die()\n    print(self.name .. ' died!')\nend\n\n-- Usage:\nlocal boss = Enemy.new('Dragon', 1000)\nboss:takeDamage(250)\n```",
  "terrain": "Terrain is Roblox voxel landscape. Each voxel is 4x4x4 studs. Use Terrain Editor tools to sculpt and paint. Supports smooth terrain blending between materials.",
  "fillblock": "workspace.Terrain:FillBlock(CFrame, Vector3 size, Enum.Material) fills a box region with terrain. Use in scripts for procedural generation!",
  "fillball": "workspace.Terrain:FillBall(Vector3 center, number radius, Enum.Material) fills a sphere. Chain multiple calls for caves and tunnels!",
  "sound": "Sound plays audio. Set SoundId to rbxassetid://ID, Volume (0-10), PlaybackSpeed (1=normal), Looped, RollOffMaxDistance (3D sound range). Sound:Play(), Sound:Stop(), Sound:Pause().",
  "healthbar": "Health bar GUI:\n\n```lua\n-- LocalScript in StarterGui:\nlocal player = game.Players.LocalPlayer\nlocal char = player.Character or player.CharacterAdded:Wait()\nlocal hum = char:WaitForChild('Humanoid')\nlocal bar = script.Parent.HealthBar -- Frame inside HealthBar\n\nhum.HealthChanged:Connect(function(health)\n    local pct = health / hum.MaxHealth\n    bar.Size = UDim2.new(pct, 0, 1, 0)\n    bar.BackgroundColor3 = Color3.fromHSV(pct * 0.33, 1, 1) -- green→red\nend)\n```",
  "leaderboard": "Leaderstats setup (Server Script in ServerScriptService):\n\n```lua\nlocal Players = game:GetService('Players')\nPlayers.PlayerAdded:Connect(function(player)\n    local stats = Instance.new('Folder')\n    stats.Name = 'leaderstats'\n    stats.Parent = player\n\n    local coins = Instance.new('IntValue')\n    coins.Name = 'Coins'\n    coins.Value = 0\n    coins.Parent = stats\n\n    local kills = Instance.new('IntValue')\n    kills.Name = 'Kills'\n    kills.Value = 0\n    kills.Parent = stats\nend)\n```",
  "script security": "**Security Rules — Never Trust the Client:**\n- Always validate RemoteEvent data on the server (type check, range check)\n- Never do damage or give items from a LocalScript — only request via RemoteEvent\n- Server is always the source of truth\n- Rate-limit remote event calls per player\n- Keep API keys, admin lists and sensitive logic in ServerScriptService\n- ReplicatedStorage is visible to all clients — never put secrets there!\n- Check player ownership before allowing actions on objects\n- Sanity check positions — reject if too far from expected location",
  "attributes": "Instance:SetAttribute('name', value) and :GetAttribute('name') store custom data on any object.\n\n```lua\npart:SetAttribute('Damage', 25)\npart:SetAttribute('IsEnemy', true)\nprint(part:GetAttribute('Damage')) -- 25\n-- Watch for changes:\npart:GetAttributeChangedSignal('Damage'):Connect(function()\n    print('Damage changed!')\nend)\n```",
  "parallel luau": "Parallel Luau uses Actors to run scripts in parallel threads.\n\n```lua\n-- In an Actor's Script (worker):\nscript:BindToMessage('Calculate', function(data)\n    task.desynchronize() -- run in parallel\n    local result = heavyComputation(data)\n    task.synchronize() -- back to main thread\n    script:GetActor():SendMessage('Result', result)\nend)\n\n-- In main Script:\nlocal actor = workspace.MyActor\nactor:SendMessage('Calculate', myData)\n```\n\nGreat for pathfinding grids, procedural generation and physics simulations.",
  "profileservice": "ProfileService is a community DataStore wrapper for production games.\n\n```lua\n-- In ServerScriptService > ProfileManager:\nlocal ProfileService = require(game.ServerScriptService.ProfileService)\nlocal ProfileStore = ProfileService.GetProfileStore('PlayerData', {\n    Coins = 0, Gems = 0, Level = 1, XP = 0\n})\ngame.Players.PlayerAdded:Connect(function(player)\n    local profile = ProfileStore:LoadProfileAsync('Player_' .. player.UserId)\n    if profile then\n        profile:AddUserId(player.UserId)\n        profile:Reconcile()\n        -- bind leaderstats, etc.\n    else\n        player:Kick('Data load failed. Try again.')\n    end\nend)\n```",
};

// ══════════════════════════════════════════════════════════
// KNOWLEDGE BASE BRAIN (ported from Flask ai_brain)
// ══════════════════════════════════════════════════════════
function kbAnswer(message, player) {
  const ml = message.toLowerCase().trim();

  if (['hello','hi','hey','sup','yo'].some(w => ml.startsWith(w))) {
    return `Hey ${player}! I'm Studio Bridge AI — I know 200+ Roblox topics built-in, and can generate full scripts too! Ask me about script types, GUI, DataStore, RemoteEvents, 3D building, pathfinding, animations, and much more!`;
  }
  if (['thank','thanks','ty','thx','appreciate'].some(w => ml.includes(w))) {
    return `You're welcome ${player}! Keep building amazing games in Roblox! 🚀`;
  }
  if (['bye','goodbye','cya','see you'].some(w => ml.includes(w))) {
    return `See you later ${player}! Happy scripting! 🎮`;
  }
  if (['what can you','what do you know','help','topics','list'].some(w => ml.includes(w)) && ml.length < 60) {
    return "I know about: **Parts & Meshes**, **Materials & Textures**, **GUI Building**, **Script Types** (Script, LocalScript, ModuleScript), **Script Naming & Placement**, **RemoteEvents & Functions**, **Security**, **Lighting & Effects**, **Animations**, **DataStore & ProfileService**, **Pathfinding**, **Physics & Constraints**, **Terrain**, **Particles**, **Multiplayer & MessagingService**, **Monetization**, **TweenService**, **Advanced Scripting (OOP, Parallel Luau)**, **Optimization** and much more! Just ask!";
  }

  // Find best match by keyword length
  let bestKey = null, bestScore = 0;
  for (const [keyword, _] of Object.entries(KNOWLEDGE)) {
    if (ml.includes(keyword) && keyword.length > bestScore) {
      bestScore = keyword.length;
      bestKey = keyword;
    }
  }
  if (bestKey) return KNOWLEDGE[bestKey];

  // Category fallbacks
  if (['script','code','localscript','modulescript'].some(w => ml.includes(w))) {
    return "Ask me about: **Script** (server), **LocalScript** (client), **ModuleScript** (shared library), **Script Naming**, **Script Placement**, **Script Communication**, **Script Security**, or **Script Starter** for templates!";
  }
  if (['gui','ui','interface','button','menu','frame','hud'].some(w => ml.includes(w))) {
    return "For GUI ask about: ScreenGui, Frame, TextLabel, TextButton, ImageLabel, ImageButton, ScrollingFrame, ViewportFrame, UIListLayout, UICorner, UIStroke, UIGradient, UIPadding, HealthBar, Leaderboard, or TweenGUI!";
  }
  if (['light','glow','shadow','dark','bright','atmosphere'].some(w => ml.includes(w))) {
    return "For lighting ask about: Lighting, PointLight, SpotLight, SurfaceLight, Bloom, Atmosphere, Sky, ColorCorrection, SunRays, DepthOfField or Clouds!";
  }
  if (['save','data','store','persist','load','profileservice'].some(w => ml.includes(w))) {
    return "For data saving ask about: **DataStore**, **DataStoreUpdateAsync** (safe updates), **OrderedDataStore** (leaderboards) or **ProfileService** (production-ready)!";
  }
  if (['slow','lag','fps','performance','optim'].some(w => ml.includes(w))) {
    return "For performance ask about: **Optimize** (general tips), **Streaming** (StreamingEnabled), **PartCount** reduction, **RenderFidelity**, **CastShadow**, or **InstancePooling**!";
  }
  if (['remote','event','function','network','replicate'].some(w => ml.includes(w))) {
    return "For networking ask about: **RemoteEvent**, **RemoteFunction**, **Script Communication** (full guide), or **Script Security** (validation)!";
  }
  if (['npc','enemy','pathfind','navigate','waypoint'].some(w => ml.includes(w))) {
    return "For NPC navigation ask about: **Pathfinding** (PathfindingService), **PathWaypoint** or **PathParams** (agent config)!";
  }
  if (['buy','purchase','money','robux','gamepass'].some(w => ml.includes(w))) {
    return "For monetization ask about: **Marketplace** (overview), **GamePass**, **DevProduct** (repeatable) or **PremiumBenefits** (Premium players)!";
  }
  if (['class','oop','object','metatable'].some(w => ml.includes(w))) {
    return "For advanced scripting ask about: **OOP** (object oriented), **Metatables**, **Attributes** (custom data), or **Tags** (CollectionService)!";
  }

  return null; // no KB match — let AI handle it
}

// ══════════════════════════════════════════════════════════
// SHOULD USE AI? (for complex code generation requests)
// ══════════════════════════════════════════════════════════
function needsAI(message) {
  const ml = message.toLowerCase();
  const aiTriggers = [
    'build','create','make me','write','generate','give me',
    'full system','complete','entire','script','code',
    '3d model','3d castle','baseparts','procedural',
    'coin system','boss','round system','pet system','shop',
    'anti-cheat','anti exploit','tycoon','simulator',
    'gun system','combat','vehicle','weather','crafting',
    'knit','profileservice','nevermore','framework',
    'achievement','wave system','building system',
    'datastore system','leaderboard system',
    'remotevent manager','module library'
  ];
  return aiTriggers.some(t => ml.includes(t)) && message.length > 30;
}

// ══════════════════════════════════════════════════════════
// TEMPLATES
// ══════════════════════════════════════════════════════════
const TEMPLATES = {
  starter:[
    {icon:"🪙",title:"Coin System",desc:"Pickup, leaderboard, DataStore",badge:"",prompt:"Build a complete coin pickup system: spinning coins on the ground with glow effect, leaderboard, DataStore save with pcall retry. Name all scripts."},
    {icon:"❤️",title:"Health System",desc:"Custom health, regen, shield",badge:"",prompt:"Build a custom health system: max health, regen over time, shield that absorbs damage, death/respawn with fade, GUI health bar. Name all scripts."},
    {icon:"🎮",title:"Round System",desc:"Lobby → round → winner → repeat",badge:"",prompt:"Create a complete round-based system: lobby countdown, player teleport to arena, round timer GUI, winner announcement, intermission, repeat. Name all scripts."},
    {icon:"💾",title:"DataStore Basic",desc:"Save/load with retry + BindToClose",badge:"",prompt:"Build a basic DataStore system: save and load player data with pcall retries, BindToClose, and default data. Name all scripts."},
    {icon:"🖥️",title:"GUI Panel",desc:"Animated dark-theme panel",badge:"",prompt:"Create an animated GUI panel: dark theme, slide-in animation with TweenService, UICorner, UIStroke, close button. Name the LocalScript properly."},
    {icon:"🤖",title:"NPC Basic",desc:"Patrol, aggro, attack, cleanup",badge:"",prompt:"Create a basic pathfinding NPC: patrol waypoints, aggro on player sight, melee attack with damage, health bar GUI, death cleanup. Name the script."},
    {icon:"🔊",title:"Sound Manager",desc:"BGM, SFX, volume, zones",badge:"new",prompt:"Build a SoundManager ModuleScript: background music queue, SFX with pitch variation, master volume control, zone ambient audio. Name it SoundManager."},
    {icon:"📊",title:"Leaderboard",desc:"Stats, DataStore, GUI",badge:"",prompt:"Create a full leaderboard: Coins, Kills, Wins stats with DataStore persistence, sorted GUI leaderboard panel. Name all scripts."},
  ],
  scripting:[
    {icon:"📡",title:"RemoteEvent System",desc:"Server/client bridge + rate limit",badge:"",prompt:"Build a complete RemoteEvent manager: centralized remote folder, server-side validation, rate limiting, client feedback. Name all scripts."},
    {icon:"🔄",title:"ModuleScript Library",desc:"Utility functions, OOP class",badge:"",prompt:"Create a utility ModuleScript library: math helpers (clamp, lerp, map), table utils (deepCopy, merge), string utils, OOP base class. Name it Utils."},
    {icon:"🎯",title:"Hitbox System",desc:"Accurate melee hitbox detection",badge:"",prompt:"Build a melee hitbox system: client swings, server validates via GetPartsInRadius, damage with IFrames, multiple hit targets. Name all scripts."},
    {icon:"⚡",title:"Promise Module",desc:"Async flow with .andThen .catch",badge:"",prompt:"Implement a basic Promise ModuleScript for Roblox: new(), andThen(), catch(), finally(), Promise.all(), reject() and resolve(). Name it Promise."},
    {icon:"🔁",title:"Object Pool",desc:"Pre-create and reuse instances",badge:"",prompt:"Build an object pool ModuleScript for projectiles/effects: pre-create N instances, :Get() pulls from pool, :Return() recycles. Name it ObjectPool."},
    {icon:"🔐",title:"Admin Commands",desc:"6 rank tiers, 20+ commands",badge:"adv",prompt:"Create a complete admin system: 6 rank tiers, 20+ commands (kick, ban, tp, warn, mute, freeze, give, setspeed, announce, fly, god), chat parser, GUI, log to DataStore."},
  ],
  gui:[
    {icon:"❤️",title:"Health Bar",desc:"Animated HP bar with regen",badge:"",prompt:"Build an animated health bar GUI: smooth tween on damage, color shift (green→yellow→red), shield overlay, regen pulse, numeric display. Name the LocalScript."},
    {icon:"🎒",title:"Inventory GUI",desc:"Grid, tooltips, equip, stack",badge:"",prompt:"Create a complete inventory GUI: scrolling grid layout, item icons with rarity colors, hover tooltips, equip/unequip, item stacking. Name the LocalScript."},
    {icon:"🛍️",title:"Shop GUI",desc:"Categories, cart, gamepass items",badge:"",prompt:"Build a full shop GUI: category tabs, item cards with preview, buy button with currency check, gamepass items, purchase animation. Name all scripts."},
    {icon:"📣",title:"Notification System",desc:"Stack, slide, auto-dismiss",badge:"",prompt:"Create a notification system: slide-in from top-right, stack multiple, auto-dismiss with timer bar, types (info/success/warning/error). Name the LocalScript."},
    {icon:"🗺️",title:"Minimap",desc:"Overhead camera, player dots",badge:"",prompt:"Build a minimap: ViewportFrame with top-down camera following player, colored dots for teammates/enemies, rotation matching player direction. Name the LocalScript."},
    {icon:"💬",title:"Chat Bubbles",desc:"NPC chat, fade, multi-line",badge:"",prompt:"Create a chat bubble system for NPCs: BillboardGui above head, UICorner rounded bubble, typewriter text effect, auto-size, fade out. Name the ModuleScript."},
  ],
  systems:[
    {icon:"⚔️",title:"Combat System",desc:"Combos, hitbox, knockback, anims",badge:"adv",prompt:"Build a full melee combat system: 3-hit combo with timing, server hitbox validation, knockback, hit particles, camera shake, stun, block/parry, animations."},
    {icon:"🔫",title:"Gun System",desc:"Raycast, damage, ammo, ADS",badge:"adv",prompt:"Build a complete raycast gun system: client raycast, server validation, headshot multiplier, ammo/magazine, reload animation, ADS zoom, muzzle flash, recoil."},
    {icon:"🐾",title:"Pet System",desc:"Eggs, rarities, stat boosts, save",badge:"adv",prompt:"Build a full pet system: 5 rarities, egg opening animation, pets follow player with smooth lerp, stat boosts, equip/unequip, DataStore saving."},
    {icon:"💰",title:"Economy System",desc:"Currency, shop, transfers, logs",badge:"adv",prompt:"Build a complete game economy: server-side currency (Coins + Gems), player-to-player transfers, shop purchase validation, daily reward, transaction log."},
    {icon:"🌊",title:"Wave System",desc:"Enemy waves, scaling, rewards",badge:"adv",prompt:"Build a wave defense system: spawn waves with increasing scaling, enemy type variety, wave complete rewards, wave counter GUI, boss wave every 5 rounds."},
    {icon:"🚗",title:"Vehicle System",desc:"Drive, seats, turbo, damage",badge:"adv",prompt:"Build a complete vehicle system: VehicleSeat setup, smooth acceleration/braking, drifting, boost/turbo with cooldown, vehicle health, flip recovery, horn."},
  ],
  building:[
    {icon:"🏰",title:"Castle Builder",desc:"Procedural castle from BaseParts",badge:"adv",prompt:"Build a detailed 3D castle in Lua using only BaseParts and WeldConstraints: 4 corner towers with battlements, connecting walls, main keep, portcullis gate, flag poles."},
    {icon:"⚔️",title:"3D Sword",desc:"Blade, guard, grip, pommel",badge:"",prompt:"Build a realistic 3D sword model in Lua using BaseParts and WeldConstraints: tapered blade, crossguard, leather-wrapped grip, pommel sphere. Name the script SwordBuilder."},
    {icon:"🏠",title:"House Builder",desc:"Walls, roof, doors, windows",badge:"adv",prompt:"Build a detailed house in Lua using BaseParts and WeldConstraints: exterior walls, peaked roof from WedgeParts, door frame, window frames, wooden floor, chimney."},
    {icon:"🚗",title:"Car Body",desc:"Chassis, body panels, wheels",badge:"adv",prompt:"Build a 3D car body in Lua using BaseParts and WeldConstraints: chassis frame, body panels, windshield, 4 wheels with hubcaps, headlights using Neon parts."},
    {icon:"🌉",title:"Bridge Builder",desc:"Deck, cables, towers, supports",badge:"",prompt:"Build a suspension bridge in Lua using BaseParts: main deck planks, two towers, suspension cables (angled thin cylinders), vertical hangers, approach ramps."},
    {icon:"🌿",title:"Tree Generator",desc:"Trunk, branches, leaf clusters",badge:"new",prompt:"Build a procedural tree generator in Lua: trunk (tapered cylinder), branching recursion with decreasing radius, leaf clusters (sphere parts). Configurable height and branch count."},
  ],
  advanced:[
    {icon:"🛡️",title:"Anti-Exploit Suite",desc:"Rate limits, sanity, ban log",badge:"pro",prompt:"Build a comprehensive anti-exploit suite: RemoteEvent rate limiter, position sanity check, value validator, WalkSpeed enforcer, auto-kick, ban log to DataStore."},
    {icon:"🎲",title:"Simulator Core",desc:"Click, auto, rebirth, prestige",badge:"pro",prompt:"Build a complete simulator core: click counter with multiplier, auto-clicker upgrade, rebirth system, prestige system, ProfileService data saving, all GUIs included."},
    {icon:"🎯",title:"AI Behavior Tree",desc:"Selector, sequence, leaf nodes",badge:"ultra",prompt:"Implement a Behavior Tree system for NPCs: BehaviorTree module with Selector, Sequence, Inverter and Leaf node types, blackboard for shared state, example NPC."},
    {icon:"🎬",title:"Cutscene System",desc:"Camera paths, letterbox, skip",badge:"adv",prompt:"Build a cutscene system: camera waypoints with CFrame, smooth TweenService movement, letterbox bars, subtitle typewriter effect, skip button, disable player controls."},
    {icon:"🏆",title:"Achievement System",desc:"50 achievements, rewards, badges",badge:"pro",prompt:"Build a complete achievement system: 50 achievement definitions (4 tiers), unlock conditions server-side, unlock animation with confetti, Roblox Badge award, DataStore persistence."},
    {icon:"⚡",title:"Parallel Luau",desc:"Actor workers for computation",badge:"ultra",prompt:"Show how to use Parallel Luau with Actors for pathfinding grid computation: Actor setup, worker with task.desynchronize(), main script distributes chunks, collects results."},
  ],
};

// ══════════════════════════════════════════════════════════
// CLAUDE AI SYSTEM PROMPT
// ══════════════════════════════════════════════════════════
const AI_SYSTEM = `You are STUDIO BRIDGE AI v5 ULTRA — the world's most capable Roblox Luau engineer and 3D building expert.

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
✅ PascalCase, domain-specific
✅ Good: CoinManager, RoundController, ShopServer, PetClient, DataManager, BossController, AntiExploit
✅ ModuleScripts: end in their role — Config, Module, Service, Utils, Data, Handler
❌ Never: Script, LocalScript, Module1, MyScript, Test

PLACEMENT RULES:
- Server Scripts → ServerScriptService
- LocalScripts → StarterPlayerScripts (general) or StarterGui (GUI-heavy)
- Character LocalScripts → StarterCharacterScripts
- ModuleScripts → ReplicatedStorage/Modules (shared) or ServerScriptService/Modules (server-only)
- RemoteEvents → ReplicatedStorage/Remotes/

ABSOLUTE CODE RULES:
❌ NEVER truncate or skip code — write every single line
❌ NEVER use wait() or spawn() — always task.wait() and task.spawn()
❌ NEVER use game.Players — always game:GetService("Players")
❌ NEVER trust client data without server validation
✅ ALWAYS pcall() around all DataStore calls
✅ ALWAYS validate RemoteEvent arguments on server
✅ ALWAYS disconnect connections on player leave
✅ ALWAYS cache GetService() at script top
✅ ALWAYS include a CONFIG table at the top
✅ ALWAYS use section dividers: -- ── SECTION NAME ──

RESPONSE FORMAT:
1. Brief intro (1-2 sentences)
2. File list if multiple scripts
3. Complete code — no skipping
4. Brief setup instructions

Style: Direct, senior engineer energy. Pride in craft.`;

// ══════════════════════════════════════════════════════════
// PLACEMENT DETECTION
// ══════════════════════════════════════════════════════════
function detectPlacement(code) {
  const c = code.toLowerCase();
  let loc=0, mod=0, srv=0;
  [['localplayer',3],['playergui',3],['playerscripts',2],['onclientevent',3],['userinputservice',2],['contextactionservice',2],['renderstepped',3],['fireserver',2],['camera',1],['screengui',2],['textbutton',2],['startergui',3],['starterplayerscripts',3]].forEach(([s,w])=>{if(c.includes(s))loc+=w;});
  [['onserverevent',4],['playeradded',3],['playerremoving',3],['datastoreservice',3],['bindtoclose',3],['fireclient',2],['fireallclients',2],['serverstorage',3],['serverscriptservice',3],['messagingservice',3],['badgeservice',2]].forEach(([s,w])=>{if(c.includes(s))srv+=w;});
  [['return ',2],['setmetatable',3],['__index',2],['local module = {}',4],['module.__index',4],['function module.',3]].forEach(([s,w])=>{if(c.includes(s))mod+=w;});
  if(/return\s+\w+\s*$/m.test(code.trim())) mod+=6;
  if(/local\s+\w+\s*=\s*\{\}/.test(c) && /return\s+\w+/.test(c)) mod+=4;
  let type = (mod>=8 && mod>=loc && mod>=srv) ? 'module' : (loc > srv) ? 'local' : 'server';
  const P = {
    server:{type:'Script',badge:'server',label:'🔴 Script (Server)',path:'ServerScriptService',note:'Runs on server only. Has DataStores, all players, game authority.',howTo:'Explorer → ServerScriptService → right-click → Insert Object → Script'},
    local:{type:'LocalScript',badge:'local',label:'🔵 LocalScript (Client)',path:'StarterPlayer → StarterPlayerScripts',note:'Runs on each player\'s device. Access to LocalPlayer, GUI, input, camera.',howTo:'Explorer → StarterPlayer → StarterPlayerScripts → right-click → LocalScript'},
    module:{type:'ModuleScript',badge:'module',label:'🟣 ModuleScript (Shared)',path:'ReplicatedStorage → Modules',note:'Required via require(). Accessible by both server and client.',howTo:'Explorer → ReplicatedStorage → right-click → Insert Object → ModuleScript'}
  };
  const p = {...P[type]};
  if(type==='local' && (c.includes('screengui')||c.includes('textlabel')||c.includes('frame'))){p.path='StarterGui';p.howTo='Explorer → StarterGui → right-click → LocalScript';}
  return p;
}

function heuristicName(code, ctx, idx, pl) {
  const hdr = code.match(/--\s*Script Name[:\s]+([A-Za-z][A-Za-z0-9_]+)/i);
  if (hdr) return hdr[1].trim();
  if (ctx) {
    const p = ctx.toLowerCase();
    const map = [
      [['coin','pickup'],['CoinManager','CoinClient','CoinConfig']],
      [['health','hp','damage'],['HealthManager','HealthClient','CombatConfig']],
      [['admin','command'],['AdminSystem','AdminClient','AdminConfig']],
      [['datastore','save','load'],['DataManager','DataClient','DataConfig']],
      [['round','game loop'],['RoundManager','RoundClient','RoundConfig']],
      [['npc','pathfinding'],['NPCController','NPCClient','NPCConfig']],
      [['boss','phase'],['BossController','BossClient','BossConfig']],
      [['gui','interface','hud'],['GuiController','GuiManager','GuiConfig']],
      [['shop','purchase'],['ShopServer','ShopClient','ShopConfig']],
      [['pet','egg'],['PetSystem','PetClient','PetConfig']],
      [['remote','event'],['RemoteHandler','RemoteClient','RemoteConfig']],
      [['castle','fort'],['CastleBuilder','CastleViewer','CastleConfig']],
      [['sword','weapon','blade'],['SwordBuilder','WeaponClient','WeaponConfig']],
      [['combat','melee','hit'],['CombatSystem','CombatClient','CombatConfig']],
      [['gun','raycast','shoot'],['GunSystem','GunClient','GunConfig']],
      [['economy','currency'],['EconomyManager','EconomyClient','EconomyConfig']],
      [['anti','exploit'],['AntiExploit','ExploitDetector','SecurityConfig']],
      [['sound','music','audio'],['SoundManager','SoundClient','SoundConfig']],
      [['vehicle','car','drive'],['VehicleSystem','VehicleClient','VehicleConfig']],
    ];
    for (const [kws, names] of map) {
      if (kws.some(kw => p.includes(kw))) return names[idx % names.length];
    }
  }
  const fallbacks = {Script:['GameServer','ServerMain'],LocalScript:['ClientMain','GuiClient'],ModuleScript:['SharedModule','GameConfig']};
  return (fallbacks[pl.type]||['BridgeScript'])[idx % 2];
}

// ══════════════════════════════════════════════════════════
// CODE STORE
// ══════════════════════════════════════════════════════════
const CODE_STORE = new Map(); let csIdx = 0;
function csSet(code){ const id=++csIdx; CODE_STORE.set(id,code); return id; }
function csGet(id){ return CODE_STORE.get(Number(id))||''; }

// ══════════════════════════════════════════════════════════
// STATE
// ══════════════════════════════════════════════════════════
let user=null, conversations=[], activeChatId=null, lastUserPrompt='';
let totalMsgs=0, totalCopied=0, sidebarOpen=true;
const $ = id => document.getElementById(id);
const tsShort = () => { const d=new Date(); return d.getHours()+':'+String(d.getMinutes()).padStart(2,'0'); };

function toast(msg, type='info', dur=3500) {
  const c=$('toasts'), t=document.createElement('div');
  t.className='toast '+type; t.textContent=msg; c.appendChild(t);
  setTimeout(()=>{t.style.opacity='0';t.style.transition='opacity .3s';setTimeout(()=>t.remove(),300);},dur);
}
function updateStats(){ $('stat-msgs').textContent=totalMsgs; $('stat-chats').textContent=conversations.length; $('stat-copied').textContent=totalCopied; }
function sv(){ try{ localStorage.setItem('sb5_u',JSON.stringify(user)); localStorage.setItem('sb5_c',JSON.stringify(conversations)); localStorage.setItem('sb5_s',JSON.stringify({totalMsgs,totalCopied})); }catch{} }
function lv(){ try{ user=JSON.parse(localStorage.getItem('sb5_u')); const c=localStorage.getItem('sb5_c'); conversations=c?JSON.parse(c):[]; const s=JSON.parse(localStorage.getItem('sb5_s')||'{}'); totalMsgs=s.totalMsgs||0; totalCopied=s.totalCopied||0; }catch{conversations=[];} }

// ══════════════════════════════════════════════════════════
// AUTH
// ══════════════════════════════════════════════════════════
function startApp() {
  const inp=$('rbx-username'), u=(inp.value||'').trim();
  if(!u){ $('auth-err').style.display='block'; inp.focus(); return; }
  $('auth-err').style.display='none';
  user={username:u, avatar:u[0].toUpperCase()};
  enterApp();
}
function enterApp() {
  sv(); $('auth').classList.add('gone'); $('app').classList.add('show');
  $('top-ava').textContent=user.avatar; $('top-name').textContent=user.username;
  buildTemplates(); renderHistory(); updateStats();
}
function logout() {
  user=null; conversations=[]; totalMsgs=0; totalCopied=0;
  localStorage.removeItem('sb5_u'); localStorage.removeItem('sb5_c'); localStorage.removeItem('sb5_s');
  $('app').classList.remove('show'); $('auth').classList.remove('gone');
  $('rbx-username').value='';
}
lv(); if(user) enterApp();

// ══════════════════════════════════════════════════════════
// SIDEBAR
// ══════════════════════════════════════════════════════════
function toggleSidebar() {
  sidebarOpen = !sidebarOpen;
  $('sidebar').classList.toggle('collapsed', !sidebarOpen);
  $('sidebar-toggle').textContent = sidebarOpen ? '◀' : '▶';
}
function buildTemplates() {
  const cats=['starter','scripting','gui','systems','building','advanced'];
  cats.forEach(cat => {
    const el=$(cat+'-tools'); if(!el) return;
    el.innerHTML=(TEMPLATES[cat]||[]).map(t=>`
      <div class="sidebar-tool" onclick="quickPrompt(${JSON.stringify(t.prompt)})">
        <span class="sidebar-tool-icon">${t.icon}</span>
        <div class="sidebar-tool-body">
          <div class="sidebar-tool-title">${escHtml(t.title)}</div>
          <div class="sidebar-tool-desc">${escHtml(t.desc)}</div>
        </div>
        ${t.badge?`<span class="tmpl-badge ${t.badge}">${t.badge.toUpperCase()}</span>`:''}
      </div>`).join('');
  });
}
function filterTemplates(query) {
  if(!query.trim()){buildTemplates();return;}
  const q=query.toLowerCase();
  const cats=['starter','scripting','gui','systems','building','advanced'];
  cats.forEach(cat=>{
    const el=$(cat+'-tools'); if(!el) return;
    const filtered=(TEMPLATES[cat]||[]).filter(t=>t.title.toLowerCase().includes(q)||t.desc.toLowerCase().includes(q)||t.prompt.toLowerCase().includes(q));
    el.innerHTML=filtered.map(t=>`
      <div class="sidebar-tool" onclick="quickPrompt(${JSON.stringify(t.prompt)})">
        <span class="sidebar-tool-icon">${t.icon}</span>
        <div class="sidebar-tool-body">
          <div class="sidebar-tool-title">${escHtml(t.title)}</div>
          <div class="sidebar-tool-desc">${escHtml(t.desc)}</div>
        </div>
        ${t.badge?`<span class="tmpl-badge ${t.badge}">${t.badge.toUpperCase()}</span>`:''}
      </div>`).join('')||'<div style="font-size:9px;color:var(--text3);padding:10px 8px">No results.</div>';
  });
}
function switchTab(name, el) {
  document.querySelectorAll('.tmpl-tab').forEach(t=>t.classList.remove('active'));
  document.querySelectorAll('.tmpl-panel').forEach(p=>p.classList.remove('active'));
  el.classList.add('active'); $('panel-'+name).classList.add('active');
}

// ══════════════════════════════════════════════════════════
// CHAT MANAGEMENT
// ══════════════════════════════════════════════════════════
function newChat() {
  activeChatId=null; $('messages-inner').innerHTML='';
  $('messages-wrap').classList.add('hidden'); $('welcome-screen').classList.remove('hidden');
  renderHistory();
}
function getActiveChat(){ return conversations.find(c=>c.id===activeChatId); }
function createChat(first) {
  const id='c'+Date.now(), title=first.slice(0,45)+(first.length>45?'…':'');
  const chat={id,title,messages:[],createdAt:tsShort()};
  conversations.unshift(chat); activeChatId=id; sv(); renderHistory(); return chat;
}
function deleteChat(id, e) {
  e.stopPropagation(); conversations=conversations.filter(c=>c.id!==id);
  if(activeChatId===id){activeChatId=null;$('messages-inner').innerHTML='';$('messages-wrap').classList.add('hidden');$('welcome-screen').classList.remove('hidden');}
  sv(); renderHistory(); updateStats();
}
function renderHistory() {
  const el=$('chat-history');
  if(!conversations.length){el.innerHTML='<div class="empty-history"><div class="empty-history-icon">💬</div><div class="empty-history-text">No conversations yet.<br>Ask anything to get started!</div></div>';return;}
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
function openChat(id) {
  activeChatId=id; const chat=getActiveChat(); if(!chat) return;
  $('welcome-screen').classList.add('hidden'); $('messages-wrap').classList.remove('hidden');
  $('messages-inner').innerHTML='';
  chat.messages.forEach(m=>renderMessage(m,false));
  scrollToBottom(); renderHistory();
}

// ══════════════════════════════════════════════════════════
// INPUT
// ══════════════════════════════════════════════════════════
function inputKey(e){ if(e.key==='Enter'&&!e.shiftKey){ e.preventDefault(); sendMessage(); } }
function autoResize(el){ el.style.height='auto'; el.style.height=Math.min(el.scrollHeight,180)+'px'; }
function quickPrompt(text){ $('main-input').value=text; autoResize($('main-input')); $('main-input').focus(); }
function scrollToBottom(){ const w=$('messages-wrap'); if(w) w.scrollTop=w.scrollHeight; }
function escHtml(s){ return(s||'').replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;'); }
function showShortcuts(){ $('shortcuts-panel').classList.add('show'); }
function closeShortcuts(e){ if(e.target.id==='shortcuts-panel') $('shortcuts-panel').classList.remove('show'); }

document.addEventListener('keydown',e=>{
  if(e.ctrlKey && e.key==='k'){ e.preventDefault(); newChat(); }
  if(e.ctrlKey && e.key==='b'){ e.preventDefault(); toggleSidebar(); }
  if(e.ctrlKey && e.key==='?'){ e.preventDefault(); showShortcuts(); }
  if(e.key==='Escape'){ $('shortcuts-panel').classList.remove('show'); }
});

// ══════════════════════════════════════════════════════════
// SEND MESSAGE — KB first, AI fallback
// ══════════════════════════════════════════════════════════
async function sendMessage() {
  const inp=$('main-input'), text=inp.value.trim();
  if(!text) return;
  lastUserPrompt=text;
  inp.value=''; inp.style.height='auto';
  $('send-btn').disabled=true;
  $('welcome-screen').classList.add('hidden');
  $('messages-wrap').classList.remove('hidden');

  let chat=getActiveChat(); if(!chat) chat=createChat(text);
  chat.messages.push({role:'user',content:text});
  totalMsgs++; updateStats();
  renderMessage({role:'user',content:text},true);
  scrollToBottom();

  // Try KB first
  const kbResult = kbAnswer(text, user?.username||'Developer');

  if (kbResult && !needsAI(text)) {
    // Use KB answer instantly
    updateModeBadge('kb');
    const aiRow = createStreamingRow('kb');
    $('messages-inner').appendChild(aiRow);
    scrollToBottom();

    // Fake brief typing delay for UX
    await new Promise(r => setTimeout(r, 300));
    const bubble = aiRow.querySelector('.msg-bubble');
    bubble.classList.remove('stream-cursor');
    bubble.innerHTML = formatMessage(kbResult, false);
    const actHtml = buildActions(kbResult, text);
    if(actHtml){ const d=document.createElement('div'); d.innerHTML=actHtml; aiRow.querySelector('.msg-content').appendChild(d); }
    chat.messages.push({role:'assistant',content:kbResult,mode:'kb',prompt:text});
    totalMsgs++; sv(); renderHistory(); updateStats();
    $('send-btn').disabled=false;
    scrollToBottom();
    return;
  }

  // Use Claude AI for complex requests
  updateModeBadge('ai');
  const historyMsgs = chat.messages.slice(-14).map(m=>({role:m.role,content:m.content}));
  const aiRow = createStreamingRow('ai');
  $('messages-inner').appendChild(aiRow);
  scrollToBottom();

  try {
    const fullText = await streamAI(historyMsgs, aiRow);
    const bubble = aiRow.querySelector('.msg-bubble');
    bubble.classList.remove('stream-cursor');
    bubble.innerHTML = formatMessage(fullText, false);
    const actHtml = buildActions(fullText, text);
    if(actHtml){ const d=document.createElement('div'); d.innerHTML=actHtml; aiRow.querySelector('.msg-content').appendChild(d); }
    chat.messages.push({role:'assistant',content:fullText,mode:'ai',prompt:text});
    totalMsgs++; sv(); renderHistory(); updateStats();
  } catch(err) {
    // If AI fails, fall back to KB or error
    const bubble = aiRow.querySelector('.msg-bubble');
    bubble.classList.remove('stream-cursor');
    const fbResult = kbAnswer(text, user?.username||'Developer');
    if (fbResult) {
      bubble.innerHTML = formatMessage(fbResult + '\n\n*(AI offline — showing knowledge base answer)*', false);
      chat.messages.push({role:'assistant',content:fbResult,mode:'kb',prompt:text});
    } else {
      bubble.innerHTML = `<span style="color:var(--c5)">⚠ ${escHtml(err.message)}</span><br><span style="color:var(--text3);font-size:10px">Try asking about a specific Roblox topic like "explain DataStore" or "what is RemoteEvent".</span>`;
    }
    totalMsgs++; sv(); renderHistory(); updateStats();
  }
  $('send-btn').disabled=false;
  scrollToBottom();
}

function updateModeBadge(mode) {
  const b=$('mode-badge');
  if(mode==='ai'){
    b.className='mode-badge ai';
    $('mode-badge-txt').textContent='Claude AI 🧠';
  } else {
    b.className='mode-badge kb';
    $('mode-badge-txt').textContent='Knowledge Base ⚡';
  }
}

function createStreamingRow(mode) {
  const row=document.createElement('div');
  row.className='msg-row';
  row.style.cssText='opacity:0;transform:translateY(8px);transition:all .3s ease';
  const modeLabel = mode==='ai' ? 'Claude AI 🧠' : 'Knowledge Base ⚡';
  row.innerHTML=`
    <div class="msg-avatar ai">✦</div>
    <div class="msg-content">
      <div class="msg-name">Studio Bridge AI <span class="msg-mode-tag ${mode}">${modeLabel}</span></div>
      <div class="msg-bubble stream-cursor"></div>
    </div>`;
  requestAnimationFrame(()=>{ row.style.opacity='1'; row.style.transform='translateY(0)'; });
  return row;
}

// ══════════════════════════════════════════════════════════
// STREAMING (Claude AI)
// ══════════════════════════════════════════════════════════
async function streamAI(messages, row) {
  const bubble=row.querySelector('.msg-bubble');
  let accText='', lastRender=0;

  const res=await fetch('https://api.anthropic.com/v1/messages',{
    method:'POST',
    headers:{
      'Content-Type':'application/json',
      'anthropic-version':'2023-06-01',
      'anthropic-dangerous-direct-browser-access':'true',
      'x-api-key':''
    },
    body:JSON.stringify({
      model:'claude-sonnet-4-20250514',
      max_tokens:8000,
      stream:true,
      system:AI_SYSTEM,
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
    const{done,value}=await reader.read(); if(done) break;
    buf+=decoder.decode(value,{stream:true});
    const lines=buf.split('\n'); buf=lines.pop();
    for(const line of lines){
      if(!line.startsWith('data:')) continue;
      const data=line.slice(5).trim(); if(data==='[DONE]') continue;
      try{
        const ev=JSON.parse(data);
        if(ev.type==='content_block_delta'&&ev.delta?.type==='text_delta'){
          accText+=ev.delta.text;
          const now=Date.now();
          if(now-lastRender>35){ lastRender=now; bubble.textContent=accText; scrollToBottom(); }
        }
      }catch{}
    }
  }
  return accText;
}

// ══════════════════════════════════════════════════════════
// RENDER MESSAGE
// ══════════════════════════════════════════════════════════
function renderMessage(msg, animate) {
  const inner=$('messages-inner'), isUser=msg.role==='user';
  const row=document.createElement('div');
  row.className='msg-row'+(isUser?' user':'');
  if(animate) row.style.cssText='opacity:0;transform:translateY(8px);transition:all .3s ease';
  const mode=msg.mode||'kb';
  const modeLabel=mode==='ai'?'Claude AI 🧠':'Knowledge Base ⚡';
  const avatarHtml=isUser?`<div class="msg-avatar user">${user?user.avatar:'U'}</div>`:`<div class="msg-avatar ai">✦</div>`;
  const nameHtml=isUser?`<div class="msg-name">${escHtml(user?user.username:'You')}</div>`:`<div class="msg-name">Studio Bridge AI <span class="msg-mode-tag ${mode}">${modeLabel}</span></div>`;
  const contentHtml=formatMessage(msg.content, isUser);
  row.innerHTML=`${avatarHtml}<div class="msg-content">${nameHtml}<div class="msg-bubble">${contentHtml}</div>${!isUser?buildActions(msg.content,msg.prompt||lastUserPrompt):''}</div>`;
  inner.appendChild(row);
  if(animate) requestAnimationFrame(()=>{ row.style.opacity='1'; row.style.transform='translateY(0)'; });
}

// ══════════════════════════════════════════════════════════
// FORMAT MESSAGE
// ══════════════════════════════════════════════════════════
function formatMessage(text, isUser) {
  if(!text) return '';
  if(isUser) return escHtml(text).replace(/\n/g,'<br>');
  let out='';
  text.split(/(```[\w]*\n?[\s\S]*?```)/g).forEach(part=>{
    const cm=part.match(/^```([\w]*)\n?([\s\S]*?)```$/);
    if(cm){
      const lang=cm[1]||'lua', code=cm[2];
      const storeId=csSet(code);
      out+=`<pre><div class="code-header"><span class="code-lang">${escHtml(lang||'Lua')}</span><button class="copy-code-btn" onclick="copyBlockText(this)">Copy</button></div><div class="code-body" data-code="${encodeURIComponent(code)}" data-store="${storeId}">${escHtml(code)}</div></pre>`;
    } else {
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
// BUILD ACTIONS
// ══════════════════════════════════════════════════════════
function buildActions(text, promptCtx) {
  if(!text) return '';
  const hasCode=/```(lua|luau)?/.test(text)||(/local [A-Za-z]/.test(text)&&/game:GetService/.test(text));
  if(!hasCode) return '';
  const blocks=[];
  const rx=/```(?:lua|luau)?\n?([\s\S]*?)```/g; let m;
  while((m=rx.exec(text))!==null){ const c=m[1].trim(); if(c.length>15) blocks.push(c); }
  if(!blocks.length) return '';
  const cids=blocks.map(c=>csSet(c));
  const pls=blocks.map(c=>detectPlacement(c));
  const names=blocks.map((c,i)=>heuristicName(c,promptCtx,i,pls[i]));
  let html='';
  if(blocks.length===1){
    const pl=pls[0];
    html+=`<div class="placement-card" style="margin-top:10px">
      <div class="placement-card-header">📍 Where to place this script</div>
      <div class="placement-card-body">
        <div class="placement-row"><span class="placement-label">Name</span><span class="placement-val" style="color:var(--text);font-weight:700;font-family:var(--fm)">${escHtml(names[0])}</span></div>
        <div class="placement-row"><span class="placement-label">Type</span><span class="placement-val"><span class="placement-badge ${pl.badge}">${pl.label}</span></span></div>
        <div class="placement-row"><span class="placement-label">Location</span><span class="placement-val" style="color:var(--c1);font-family:var(--fm)">${escHtml(pl.path)}</span></div>
        <div class="placement-row"><span class="placement-label">Why</span><span class="placement-val">${escHtml(pl.note)}</span></div>
        <div class="placement-row"><span class="placement-label">How to add</span><span class="placement-val">${escHtml(pl.howTo)}</span></div>
      </div>
    </div>`;
  }
  html+=`<div class="script-actions">
    <button class="sact-btn prim" onclick="copyByCid(${cids[0]})">📋 Copy Script</button>
    ${blocks.length>1?`<button class="sact-btn" onclick="copyAllByCids('${cids.join(',')}')">📦 Copy All (${blocks.length})</button>`:''}
  </div>`;
  return html;
}

// ══════════════════════════════════════════════════════════
// COPY HELPERS
// ══════════════════════════════════════════════════════════
function copyBlockText(btn) {
  const block=btn.closest('pre').querySelector('.code-body');
  const code=block?decodeURIComponent(block.dataset.code||''):'';
  doClipboard(code,'✓ Code copied! Paste in Studio.','ok');
  totalCopied++; sv(); updateStats();
}
function copyByCid(cid) {
  const code=csGet(cid);
  if(!code){toast('No code found.','bad');return;}
  doClipboard(code,'✓ Script copied! Paste into Studio.','ok',5000);
  totalCopied++; sv(); updateStats();
}
function copyAllByCids(cidsStr) {
  const cids=cidsStr.split(',');
  const parts=cids.map((cid,i)=>`-- ══════════════════════════════\n-- Script ${i+1}\n-- ══════════════════════════════\n${csGet(cid)}`);
  doClipboard(parts.join('\n\n\n'),`✓ ${cids.length} scripts copied!`,'ok');
  totalCopied+=cids.length; sv(); updateStats();
}
function doClipboard(text, successMsg, type, dur=3500) {
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
window.copyAllByCids=copyAllByCids;
window.inputKey=inputKey; window.autoResize=autoResize;
window.filterTemplates=filterTemplates; window.toggleSidebar=toggleSidebar;
window.showShortcuts=showShortcuts; window.closeShortcuts=closeShortcuts;
</script>
</body>
</html>