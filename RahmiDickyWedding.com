<!doctype html>

<html lang="id">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title>Undangan Pernikahan — Dicky & Rahmi</title>
  <style>
    :root{--bg:#f6f1ea;--panel:#fff;--accent:#b88d4a;--muted:#8b7a6f;--glass:rgba(255,255,255,0.6)}
    *{box-sizing:border-box}
    body{margin:0;font-family:Inter, "Segoe UI", Roboto, sans-serif;background:linear-gradient(180deg,var(--bg),#fff);color:#333}
    .container{max-width:720px;margin:32px auto;padding:28px}.card{background:var(--panel);border-radius:20px;padding:28px;box-shadow:0 8px 30px rgba(16,16,16,0.06);overflow:hidden}

.hero{display:grid;grid-template-columns:1fr;gap:14px;align-items:center;text-align:center}
.names{font-family:'Great Vibes', cursive;font-size:48px;color:var(--accent);line-height:1}
.sub{color:var(--muted);margin-top:6px}

.meta{display:flex;flex-wrap:wrap;gap:12px;justify-content:center;margin-top:12px}
.meta .pill{background:linear-gradient(90deg,rgba(184,141,74,0.08),rgba(184,141,74,0.03));border:1px solid rgba(184,141,74,0.12);padding:10px 14px;border-radius:999px;color:#4b4038;font-weight:600}

.section{margin-top:22px;padding-top:12px;border-top:1px dashed rgba(0,0,0,0.04)}
.lead{font-size:15px;color:#5a4f48}

.venue{display:flex;gap:12px;align-items:flex-start}
.venue .left{flex:1}

.btn{display:inline-flex;align-items:center;gap:10px;padding:10px 14px;border-radius:12px;background:var(--accent);color:white;text-decoration:none;font-weight:600;box-shadow:0 6px 18px rgba(184,141,74,0.18)}

.rsvp{margin-top:12px;display:flex;gap:10px;flex-wrap:wrap;justify-content:center}

footer{margin-top:20px;text-align:center;color:var(--muted);font-size:13px}

/* music control */
.music-control{position:fixed;right:18px;bottom:18px;background:var(--panel);border-radius:999px;padding:10px 12px;box-shadow:0 6px 20px rgba(0,0,0,0.08);display:flex;gap:8px;align-items:center}
.music-control button{border:0;background:transparent;font-weight:700;padding:6px 8px;border-radius:8px;cursor:pointer}
.music-control .icon{width:18px;height:18px}

/* responsive */
@media(min-width:900px){.container{max-width:820px}}

/* decorative flower */
.flower{position:absolute;right:-40px;top:-30px;opacity:0.9;transform:rotate(12deg)}

  </style>
  <link href="https://fonts.googleapis.com/css2?family=Great+Vibes&family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">
</head>
<body>
  <div class="container">
    <div class="card">
      <div class="hero">
        <div style="position:relative">
          <img class="flower" src="https://images.unsplash.com/photo-1519681393784-d120267933ba?q=80&w=600&auto=format&fit=crop&ixlib=rb-4.0.3&s=placeholder" alt="ornamen bunga" width="220">
          <h1 class="names">Dicky &amp; Rahmi</h1>
        </div>
        <div class="sub">Dengan memohon rahmat dan ridho Allah SWT, kami mengundang Bapak/Ibu/Saudara/i untuk menghadiri acara pernikahan kami.</div><div class="meta">
      <div class="pill">17 Desember 2025</div>
      <div class="pill">Pukul: 10.00 WIB</div>
      <div class="pill">Tempat: [Masukkan Lokasi]</div>
    </div>
  </div>

  <div class="section">
    <p class="lead">Kami berharap kehadiran dan doa restu dari Bapak/Ibu/Saudara/i. Silakan konfirmasi kehadiran melalui tombol RSVP di bawah.</p>

    <div class="rsvp">
      <a class="btn" href="#rsvp">Konfirmasi Kehadiran</a>
      <a class="btn" href="#" onclick="document.getElementById('maps').scrollIntoView({behavior:'smooth'})">Lihat Lokasi</a>
    </div>
  </div>

  <div id="rsvp" class="section">
    <h3>RSVP</h3>
    <p class="lead">Silakan masukkan nama dan jumlah tamu yang akan hadir.</p>
    <form onsubmit="event.preventDefault();alert('Terima kasih! Konfirmasi Anda telah diterima.');" style="display:flex;flex-direction:column;gap:8px;max-width:520px">
      <input required placeholder="Nama" style="padding:10px;border-radius:10px;border:1px solid rgba(0,0,0,0.06)">
      <input required type="number" min="0" placeholder="Jumlah tamu" style="padding:10px;border-radius:10px;border:1px solid rgba(0,0,0,0.06)">
      <button class="btn" type="submit">Kirim</button>
    </form>
  </div>

  <div id="maps" class="section">
    <h3>Lokasi</h3>
    <p class="lead">[Masukkan alamat lengkap atau gunakan Google Maps embed di bawah]</p>
    <!-- Placeholder map: replace src with Google Maps embed link -->
    <div style="margin-top:10px">
      <iframe id="gmap" src="https://www.google.com/maps/embed?pb=" width="100%" height="300" style="border:0;border-radius:12px" allowfullscreen="" loading="lazy"></iframe>
    </div>
  </div>

  <footer>Mohon doa restu. — Dicky &amp; Rahmi</footer>
</div>

  </div>  <!-- Music control UI -->  <div class="music-control" role="region" aria-label="Kontrol musik">
    <button id="toggleMusic" aria-pressed="false">▶️ Play</button>
    <div style="font-size:13px;color:var(--muted);">Lagu: Perfect — Ed Sheeran</div>
  </div>  <!-- YouTube IFrame API (dipakai agar kontrol play/pause lebih reliable) -->  <script src="https://www.youtube.com/iframe_api"></script>  <script>
    // Video ID for "Perfect" by Ed Sheeran (official music video)
    const VIDEO_ID = '2Vv-BfVoq4g';
    let player;
    let userInteracted = false;

    function onYouTubeIframeAPIReady(){
      player = new YT.Player('ytplayer', {
        height: '0', width: '0', videoId: VIDEO_ID,
        playerVars: {autoplay: 1, controls: 0, loop: 1, playlist: VIDEO_ID, modestbranding: 1, rel: 0},
        events: {onReady: onPlayerReady, onStateChange: onPlayerStateChange}
      });
    }

    // create a hidden div to host the player (kept out of layout)
    const div = document.createElement('div'); div.style.position='absolute'; div.style.left='-9999px'; div.id='ytplayer'; document.body.appendChild(div);

    function onPlayerReady(e){
      // try autoplay, but many browsers block audible autoplay — if blocked, we'll wait for user click
      tryAutoplay();
    }

    function tryAutoplay(){
      if(!player) return;
      player.setVolume(60);
      // Try to play; if it fails silently, we'll wait for user action
      const p = player.playVideo();
      if(p && p.catch){
        p.catch(()=>{
          // autoplay blocked — show paused state; user must press play
          updateButton(false);
        });
      }
    }

    function onPlayerStateChange(e){
      const playing = (e.data == YT.PlayerState.PLAYING);
      updateButton(playing);
    }

    const toggleBtn = document.getElementById('toggleMusic');
    toggleBtn.addEventListener('click', ()=>{
      userInteracted = true;
      if(!player) return;
      const state = player.getPlayerState();
      if(state !== YT.PlayerState.PLAYING){
        player.playVideo();
      } else {
        player.pauseVideo();
      }
    });

    function updateButton(isPlaying){
      toggleBtn.textContent = isPlaying ? '⏸ Pause' : '▶️ Play';
      toggleBtn.setAttribute('aria-pressed', String(isPlaying));
    }

    // Accessibility: allow space/enter on focused button
    toggleBtn.addEventListener('keydown', (e)=>{ if(e.key === ' ' || e.key === 'Enter'){ e.preventDefault(); toggleBtn.click(); } });

    // Small helper: if user scrolls into the page, and autoplay was not allowed, we can try again (some browsers allow autoplay after interaction)
    window.addEventListener('scroll', ()=>{ if(!userInteracted){ tryAutoplay(); } });

    // NOTES for customization:
    // - Ganti VIDEO_ID dengan ID YouTube lain kalau mau lagu berbeda.
    // - Untuk menggunakan file audio sendiri (mp3) host file di server dan buat <audio> element menggantikan player.
    // - Ganti teks [Masukkan Lokasi] dan link Google Maps di iframe dengan link embed dari Google Maps.
  </script>  <!-- small noscript fallback -->  <noscript>
    <div style="position:fixed;right:18px;bottom:18px;background:#fff;padding:10px;border-radius:10px;box-shadow:0 6px 20px rgba(0,0,0,0.08)">Aktifkan JavaScript untuk memutar musik latar.</div>
  </noscript>
</body>
</html>
