# EASUN Solar Monitor - Instalační návod

## 🎯 Rychlá instalace

### 1. Přidání do Home Assistant
```
1. Supervisor → Add-on Store → ⋮ (tři tečky) → Repositories
2. Přidat URL: https://github.com/9991119990/easun-ha-addon
3. Refresh stránky (F5)
4. Najít "EASUN Solar Monitor"
5. Kliknout Install
```

### 2. Konfigurace
```yaml
device: /dev/ttyUSB0
mqtt_host: core-mosquitto
mqtt_port: 1883
mqtt_user: mppclient
mqtt_password: supersecret
update_interval: 5
```

### 3. Spuštění
```
1. Uložit konfiguraci
2. Kliknout Start
3. Zkontrolovat Log - měl by zobrazit:
   "Data publikována: PV=1357W, Baterie=54.4V/72%, Výstup=60W"
```

### 4. Senzory v HA
```
Nastavení → Zařízení a služby → MQTT → "EASUN SHM II 7K"
```

## 🔧 Řešení problémů

### Chyba: "Device not found"
```bash
ssh pi@192.168.68.250
ls -la /dev/ttyUSB*
# Aktualizovat device v konfiguraci
```

### Chyba: "MQTT connection failed"
```
Zkontrolovat MQTT credentials v konfiguraci
```

### Chyba: "Repository not valid"
```
Ujistit se, že URL je: https://github.com/9991119990/easun-ha-addon
```

## 📊 Očekávaná data

- **PV výkon:** 0-2700W (podle slunečního svitu)
- **Baterie:** 48-58V, 0-100%
- **AC výstup:** 0-7000W
- **Teplota:** 20-80°C
- **Režim:** grid/battery

## 🎛️ Nastavení intervalů

- **5 sekund:** Real-time monitoring
- **10 sekund:** Standardní použití
- **30 sekund:** Úspora zdrojů
- **60 sekund:** Minimální zátěž