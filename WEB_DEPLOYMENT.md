# Castle Eidolon - Web Deployment Guide

This guide explains how to build and deploy Castle Eidolon as a web-based game using Godot's HTML5/WebAssembly export.

## 🌐 Quick Start

### 1. Build the Web Version

```bash
./build_web.sh
```

This script will:
- Detect your Godot installation
- Export the game to `builds/web/`
- Generate all necessary HTML5/WebAssembly files

### 2. Test Locally

```bash
./serve_web.sh
```

Then open your browser to:
- **Game:** http://localhost:8000
- **Landing Page:** http://localhost:8000/landing.html

---

## 📋 Prerequisites

### Required

1. **Godot 4.3+** - Download from [godotengine.org](https://godotengine.org/download)
2. **Web Export Templates** - Install via Godot Editor:
   - Open Godot Editor
   - Go to `Editor` → `Manage Export Templates`
   - Download templates for your Godot version

### For Local Testing

One of the following:
- **Python 3** (recommended) - Usually pre-installed on Linux/Mac
- **Python 2** (legacy)
- **PHP** with built-in server

---

## 🛠️ Building for Web

### Method 1: Using Build Script (Recommended)

```bash
chmod +x build_web.sh
./build_web.sh
```

### Method 2: Using Godot Editor

1. Open the project in Godot Editor
2. Go to `Project` → `Export`
3. Select or add the "Web" preset
4. Click "Export Project"
5. Choose `builds/web/index.html` as the destination

### Method 3: Using Godot CLI

```bash
godot --headless --export-release "Web" builds/web/index.html
```

---

## 🚀 Deployment Options

### Option 1: GitHub Pages (Free)

1. Build the web version:
   ```bash
   ./build_web.sh
   ```

2. Copy `builds/web/` contents to a `docs/` folder in your repo:
   ```bash
   mkdir -p docs
   cp -r builds/web/* docs/
   ```

3. Push to GitHub:
   ```bash
   git add docs/
   git commit -m "Deploy web version"
   git push
   ```

4. Enable GitHub Pages:
   - Go to repository Settings
   - Navigate to Pages
   - Source: `main` branch, `/docs` folder
   - Save

5. Your game will be available at:
   ```
   https://yourusername.github.io/castle-eidolon/
   ```

### Option 2: Netlify (Free)

1. Build the web version
2. Create `netlify.toml` in project root:
   ```toml
   [build]
     publish = "builds/web"
     command = "./build_web.sh"
   ```

3. Deploy:
   - Connect your GitHub repo to Netlify
   - Or drag-and-drop `builds/web/` folder to Netlify

### Option 3: itch.io (Game Platform)

1. Build the web version
2. Zip the `builds/web/` directory:
   ```bash
   cd builds/web
   zip -r ../castle-eidolon-web.zip .
   ```

3. Upload to itch.io:
   - Create a new project
   - Set "Kind of project" to "HTML"
   - Upload the zip file
   - Check "This file will be played in the browser"
   - Set `index.html` as the main file

### Option 4: Self-Hosted Server

#### Using Nginx

```nginx
server {
    listen 80;
    server_name castle-eidolon.example.com;

    root /var/www/castle-eidolon;
    index index.html;

    location / {
        try_files $uri $uri/ =404;
        add_header Cross-Origin-Embedder-Policy require-corp;
        add_header Cross-Origin-Opener-Policy same-origin;
    }

    # Enable gzip compression
    gzip on;
    gzip_types text/plain text/css application/javascript application/wasm;
}
```

#### Using Apache

```apache
<VirtualHost *:80>
    ServerName castle-eidolon.example.com
    DocumentRoot /var/www/castle-eidolon

    <Directory /var/www/castle-eidolon>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted

        # Required headers for SharedArrayBuffer
        Header set Cross-Origin-Embedder-Policy "require-corp"
        Header set Cross-Origin-Opener-Policy "same-origin"
    </Directory>

    # Enable gzip
    AddOutputFilterByType DEFLATE text/html text/plain text/css application/javascript application/wasm
</VirtualHost>
```

---

## 📁 File Structure

After building, your `builds/web/` directory will contain:

```
builds/web/
├── index.html              # Godot-generated game page
├── index.js                # Godot engine loader
├── index.wasm              # Compiled game (WebAssembly)
├── index.pck               # Game assets package
├── index.icon.png          # Game icon
├── landing.html            # Custom landing page (copied from web/)
└── styles.css              # Custom styles (copied from web/)
```

**Important Files:**
- `index.html` - Default Godot game page
- `landing.html` - Custom designed page with game info
- All files must be served together from the same directory

---

## 🔧 Customization

### Custom Landing Page

The custom landing page includes:
- Game description and lore
- Feature highlights
- Control instructions
- Dark gothic theme
- Loading screen
- Fullscreen button

**To modify:**
1. Edit `web/index.html` for content
2. Edit `web/styles.css` for styling
3. Rebuild: `./build_web.sh`
4. Serve: `./serve_web.sh`

### Export Settings

Edit `export_presets.cfg` to customize:
- Canvas resize policy
- Virtual keyboard (mobile)
- Progressive Web App settings
- Texture compression
- Custom HTML shell

---

## 🌍 Browser Compatibility

### Supported Browsers

✅ **Fully Supported:**
- Chrome 90+
- Firefox 88+
- Edge 90+
- Safari 15.4+ (macOS, iOS)
- Opera 76+

⚠️ **Limited Support:**
- Safari 14-15.3 (lacks some WebGL features)
- Older mobile browsers

❌ **Not Supported:**
- Internet Explorer (all versions)
- Browsers without WebGL 2.0
- Very old mobile browsers

### Performance Notes

- **Desktop:** Excellent performance on modern hardware
- **Mobile:** Playable but may have reduced performance
- **First Load:** 30-60 seconds (downloads ~10-20 MB assets)
- **Subsequent Loads:** Instant (browser cache)

---

## 🐛 Troubleshooting

### Build Fails - "Export templates not found"

**Solution:** Install export templates in Godot Editor:
```
Editor → Manage Export Templates → Download and Install
```

### Game Won't Load - Black Screen

**Causes:**
1. Browser doesn't support WebGL 2.0
2. Missing CORS headers (if self-hosting)
3. Files not uploaded correctly

**Solutions:**
1. Try a modern browser (Chrome, Firefox, Edge)
2. Add CORS headers to server config
3. Ensure all files from `builds/web/` are uploaded

### Performance Issues

**Solutions:**
1. Lower the game resolution in project settings
2. Disable some visual effects
3. Use Chrome or Edge (best WebGL performance)
4. Close other browser tabs

### Loading Takes Forever

**Causes:**
- Large game assets
- Slow internet connection

**Solutions:**
1. Enable gzip compression on server
2. Use a CDN for faster delivery
3. Optimize asset sizes (compress textures, audio)

### Controls Don't Work

**Solution:** Click on the game canvas to focus it

### SharedArrayBuffer Errors

Some browsers require specific headers for threading support.

**Add to server config:**
```
Cross-Origin-Embedder-Policy: require-corp
Cross-Origin-Opener-Policy: same-origin
```

---

## 📊 Asset Size Optimization

### Reduce Build Size

1. **Compress Textures:**
   - Use compressed formats (WebP, ETC2)
   - Reduce texture resolution
   - Enable texture compression in export settings

2. **Optimize Audio:**
   - Use OGG Vorbis (smaller than WAV)
   - Reduce bitrate for background music
   - Use mono for sound effects

3. **Remove Unused Assets:**
   - Clean up unused scenes/scripts
   - Remove debug/test files

### Enable Server Compression

```nginx
# Nginx
gzip on;
gzip_types text/html text/css application/javascript application/wasm;
gzip_comp_level 6;
```

```apache
# Apache
AddOutputFilterByType DEFLATE text/html text/css application/javascript application/wasm
```

---

## 🔐 Security Considerations

### Content Security Policy

Add to HTML `<head>`:

```html
<meta http-equiv="Content-Security-Policy"
      content="default-src 'self';
               script-src 'self' 'unsafe-eval';
               style-src 'self' 'unsafe-inline';
               img-src 'self' data:;">
```

### HTTPS

Always serve games over HTTPS in production:
- Required for some browser features
- Better performance (HTTP/2)
- User trust and security

---

## 📈 Analytics & Monitoring

### Add Google Analytics

In `web/index.html`, add before `</head>`:

```html
<!-- Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=GA_MEASUREMENT_ID"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'GA_MEASUREMENT_ID');
</script>
```

### Monitor Performance

Use browser DevTools:
- Network tab: Check load times
- Performance tab: Profile frame rate
- Console: Check for errors

---

## 🎮 Testing Checklist

Before deploying:

- [ ] Game loads without errors
- [ ] All controls work correctly
- [ ] Audio plays properly
- [ ] Game saves persist (localStorage)
- [ ] Fullscreen mode works
- [ ] Mobile devices can access (if supported)
- [ ] Load time is acceptable (< 60s)
- [ ] No console errors
- [ ] Works in multiple browsers
- [ ] Landing page displays correctly

---

## 📝 License & Credits

Castle Eidolon - Built with Godot Engine

For more information, see the main README.md

---

## 🆘 Support

For issues specific to web deployment:
1. Check browser console for errors
2. Verify all files uploaded correctly
3. Test in multiple browsers
4. Check server logs for errors

For game-specific issues:
- See main README.md
- Check GitHub issues
- Review game documentation

---

## 🔄 Updating the Web Version

To update after making changes:

```bash
# 1. Make your changes in Godot
# 2. Rebuild web version
./build_web.sh

# 3. Test locally
./serve_web.sh

# 4. Deploy
# (Upload builds/web/ to your hosting service)
```

---

**Happy deploying! May your Castle Eidolon reach players across the web! 🏰✨**
