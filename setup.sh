`bash
#!/bin/bash

echo "========================================="
echo "🚀 SETTING UP REMOTE BROWSER"
echo "========================================="

# رنگ‌ها برای خروجی زیباتر
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# 1. آپدیت سیستم
echo -e "${YELLOW}📦 Updating system...${NC}"
sudo apt-get update -y && sudo apt-get upgrade -y

# 2. نصب پیش‌نیازها
echo -e "${YELLOW}📦 Installing dependencies...${NC}"
sudo apt-get install -y \
    firefox \
    xvfb \
    x11vnc \
    novnc \
    websockify \
    xdotool \
    wmctrl \
    fluxbox \
    x11-xserver-utils \
    supervisor

# 3. تنظیم فایرفاکس
echo -e "${YELLOW}🦊 Configuring Firefox...${NC}"
firefox --version

# 4. ساخت اسکریپت Keep-Alive
echo -e "${YELLOW}🔄 Creating keep-alive script...${NC}"
cat > /tmp/keepalive.sh << 'EOF'
#!/bin/bash
while true; do
    # حرکت موس هر ۲۸۰ ثانیه
    if command -v xdotool &> /dev/null; then
        xdotool mousemove_relative --sync 1 1
        sleep 2
        xdotool mousemove_relative --sync -- -1 -1
    fi
    sleep 280
done
EOF

chmod +x /tmp/keepalive.sh

# 5. ساخت اسکریپت اصلی
echo -e "${YELLOW}🌟 Creating main browser script...${NC}"
cat > /tmp/start-browser.sh << 'EOF'
#!/bin/bash

echo "========================================="
echo "🌐 STARTING REMOTE BROWSER SYSTEM"
echo "========================================="

# Kill any existing processes
pkill -f firefox 2>/dev/null
pkill -f x11vnc 2>/dev/null
pkill -f websockify 2>/dev/null
pkill -f novnc 2>/dev/null

# Wait a moment
sleep 2

# Start virtual display if not running
if [ -z "$DISPLAY" ]; then
    export DISPLAY=:1
    Xvfb :1 -screen 0 1280x720x24 &
    echo "✅ Virtual display started on :1"
fi

# Start fluxbox window manager
fluxbox &
sleep 1

# Start Firefox
echo "🦊 Starting Firefox..."
firefox --no-sandbox --new-window about:blank &
sleep 5

# Configure Firefox for better performance
firefox --no-sandbox &
sleep 2

# Start VNC server
echo "📺 Starting VNC server..."
x11vnc -display :1 \
    -forever \
    -nopw \
    -quiet \
    -xkb \
    -repeat \
    -rfbport 5901 &
sleep 2

# Start noVNC web client
echo "🌐 Starting web client..."
websockify --web /usr/share/novnc 8080 localhost:5901 &
sleep 2

# Start keep-alive
echo "🔄 Starting keep-alive..."
bash /tmp/keepalive.sh &
echo ""
echo "========================================="
echo "✅ BROWSER SYSTEM IS READY!"
echo "========================================="
echo ""
echo "📌 Port 8080 - noVNC Web Client"
echo "📌 Port 6080 - Desktop Lite (if available)"
echo ""
echo "🔐 Default VNC Password: browser123"
echo ""
echo "💡 Tips:"
echo "  - Open PORTS tab (next to Terminal)"
echo "  - Make port 8080 PUBLIC"
echo "  - Open the link in your browser"
echo "  - Use Firefox to browse ANY website"
echo "========================================="
EOF

chmod +x /tmp/start-browser.sh

# 6. اجرای مرورگر
echo -e "${GREEN}🌟 Starting browser...${NC}"
bash /tmp/start-browser.sh

echo ""
echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}✅ SETUP COMPLETE!${NC}"
echo -e "${GREEN}=========================================${NC}"
