#!/bin/bash

# EASUN Solar Monitor - Backup Script
# Datum: 18. července 2025

echo "=== EASUN Solar Monitor - Backup Script ==="
echo "Vytváří kompletní zálohu EASUN řešení"
echo ""

# Vytvoření backup složky s datem
BACKUP_DIR="/home/dell/EASUN_BACKUP_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

echo "📁 Backup složka: $BACKUP_DIR"
echo ""

# 1. Zkopírování add-on kódu
echo "1. Kopírování add-on kódu..."
cp -r /home/dell/easun-ha-addon "$BACKUP_DIR/"

# 2. Zkopírování standalone monitoru
echo "2. Kopírování standalone monitoru..."
if [ -f "/home/dell/easun_ha_monitor.py" ]; then
    cp /home/dell/easun_ha_monitor.py "$BACKUP_DIR/"
fi

# 3. Zkopírování dokumentace
echo "3. Kopírování dokumentace..."
cp -r /home/dell/EASUN_BACKUP_FINAL/* "$BACKUP_DIR/"

# 4. Vytvoření archívu
echo "4. Vytváření archívu..."
cd /home/dell
tar -czf "EASUN_BACKUP_$(date +%Y%m%d_%H%M%S).tar.gz" "$(basename $BACKUP_DIR)"

echo ""
echo "✅ Backup dokončen!"
echo "📦 Archív: EASUN_BACKUP_$(date +%Y%m%d_%H%M%S).tar.gz"
echo "📁 Složka: $BACKUP_DIR"
echo ""
echo "🔄 Pro obnovení:"
echo "tar -xzf EASUN_BACKUP_*.tar.gz"
echo ""
echo "📤 Pro nahrání na GitHub:"
echo "git clone https://github.com/9991119990/easun-ha-addon.git"
echo "cd easun-ha-addon"
echo "git pull"