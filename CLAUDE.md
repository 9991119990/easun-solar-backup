# Claude Code Memory - Solární měniče projekty

## 🎯 Dokončený projekt: MPP Solar Home Assistant Add-on

**Datum:** 27. června 2025  
**Status:** ✅ ÚSPĚŠNĚ DOKONČEN A FUNKČNÍ

### 📋 Souhrn úspěšného projektu

Vytvořili jsme kompletní **Home Assistant add-on** pro monitoring **MPP Solar PIP5048MG** měniče:

- **GitHub:** https://github.com/9991119990/mpp-solar-ha-addon
- **Typ:** Produkčně připravený HA add-on
- **Funkce:** Real-time monitoring přes USB HID → MQTT → Home Assistant

### 🔧 Technické řešení

**Komunikace s měničem:**
- USB HID komunikace přes `/dev/hidraw0`
- PI30 protokol, QPIGS příkaz
- Non-blocking I/O s timeouty (vyřešeno crashování)
- Fragmentované čtení dat po 8-byte blocích

**MQTT integrace:**
- Mosquitto broker s autentizací (mppclient/supersecret)
- Auto-discovery pro Home Assistant
- 9+ senzorů (PV, baterie, AC, teplota, statusy)

**Add-on architektura:**
- Docker container s Python aplikací
- Bashio konfigurace z HA
- Multi-arch support (ARM, x86)
- Privilegovaný přístup k USB zařízením

### 🎯 Finální funkční stav

**Testovaná data (20.7.2025) - FINÁLNÍ VERZE 2.0.0:**
```
PV výkon čten PŘÍMO z pozice 19 (stejně jako EASUN)
Displej: 444W → Pozice 19: 436W (98.2% přesnost)
Published: PV=436W, Battery=51.9V/47%, Load=23W, Temp=42°C
```

**Home Assistant entity:**
- `sensor.mpp_solar_pv_input_power` = přímá hodnota z pozice 19
- `sensor.mpp_solar_battery_voltage` = napětí baterie
- `sensor.mpp_solar_battery_capacity` = kapacita baterie %
- `sensor.mpp_solar_ac_output_power` = AC výstupní výkon
- `sensor.mpp_solar_inverter_temperature` = teplota měniče

### 🚀 Instalace do HA

```
1. HA → Add-ons → Add-on Store → ⋮ → Repositories
2. Přidat: https://github.com/9991119990/mpp-solar-ha-addon  
3. Install "MPP Solar Monitor"
4. Configure: device="/dev/hidraw0", mqtt credentials
5. Start → automatické entity v MQTT integraci
```

### 🛠️ Klíčové vyřešené problémy

1. **HID komunikace** - non-blocking I/O místo blokujícího
2. **Fragmentovaná data** - multi-read s postupným skládáním
3. **MQTT auth** - správná konfigurace Mosquitto přihlášení
4. **Neúplné odpovědi** - flexibilní parser pro 17+ hodnot
5. **PV výkon** - FINÁLNÍ ŘEŠENÍ: přímé čtení z pozice 19 (98.2% přesnost)

### 📁 Umístění projektu

- **GitHub:** https://github.com/9991119990/mpp-solar-ha-addon
- **Lokálně:** `/home/dell/Měniče/mpp-solar-addon/`
- **Backup:** `/home/dell/MPP_SOLAR_BACKUP_FINAL/`
- **Dokumentace:** `PROJEKT_MPP_SOLAR_FINAL_KOMPLETNI.md`

---

## 🎯 Dokončený projekt: EASUN SHM II 7K Home Assistant Add-on

**Datum:** 18. července 2025  
**Status:** ✅ ÚSPĚŠNĚ DOKONČEN A PLNĚ FUNKČNÍ

### 📋 Souhrn úspěšného projektu

Vytvořili jsme kompletní **Home Assistant Add-on** pro **EASUN SHM II 7K** měnič:

- **GitHub:** https://github.com/9991119990/easun-ha-addon
- **Backup:** https://github.com/9991119990/easun-solar-backup
- **Typ:** Produkčně připravený HA add-on
- **Funkce:** Real-time monitoring přes USB/RS232 → MQTT → Home Assistant
- **Interval:** 5 sekund (nastavitelný)
- **Přesnost:** 100% shoda s displejem měniče

### 🔧 Technické řešení

**Hardware:**
- **Měnič:** EASUN SHM II 7K (7000W)
- **Komunikace:** RJ45 COMM port → USB adaptér
- **Adaptér:** Silicon Labs CP2102 (067b:23a3)
- **Port:** `/dev/ttyUSB0` na Raspberry Pi
- **Protokol:** PI30 (QPIGS příkaz)
- **Baudrate:** 2400, 8N1

**Software:**
- **Platforma:** Home Assistant Add-on
- **Jazyk:** Python 3 + pyserial + paho-mqtt
- **MQTT:** Auto-discovery pro HA
- **Multi-arch:** ARM (RPi) + x86 support

### 📊 Dostupná data (z QPIGS příkazu)

- **PV Solar:** Napětí, proud, **reálný výkon** (přímo z pozice 19 v raw datech)
- **Baterie:** Napětí, SOC%, nabíjení/vybíjení, výkon
- **AC Output:** Napětí, frekvence, výkon, zatížení%
- **Systém:** Teplota, režim (grid/battery), grid napětí
- **Celkem:** 13+ senzorů v HA

### 🎯 Finální funkční stav

**Testované real-time data (18.7.2025):**
```
PV=1357W, Baterie=54.4V/72%, Výstup=60W, Režim=grid
PV=1363W, Baterie=54.4V/72%, Výstup=55W, Režim=grid
PV=1392W, Baterie=54.4V/72%, Výstup=67W, Režim=grid
PV=1378W, Baterie=54.4V/72%, Výstup=58W, Režim=grid
```

**Shoda s displejem:** Displej 1.37kW ↔ HA 1378W ✅

### 🛠️ Klíčové vyřešené problémy

1. **Docker build chyby** - oprava Dockerfile (pyserial místo py3-serial)
2. **MQTT autentizace** - správné přihlašovací údaje
3. **Repository format** - změna z .yaml na .json
4. **PV výkon interpretace** - nalezení správné pozice (19) v raw datech
5. **Real-time monitoring** - optimalizace na 5s interval

### 📁 Umístění projektu

- **GitHub Add-on:** https://github.com/9991119990/easun-ha-addon
- **GitHub Backup:** https://github.com/9991119990/easun-solar-backup
- **Lokálně:** `/home/dell/easun-ha-addon/`
- **Backup:** `/home/dell/EASUN_BACKUP_FINAL/`

### 🚀 Instalace do HA

```
1. Supervisor → Add-on Store → ⋮ → Repositories
2. Přidat: https://github.com/9991119990/easun-ha-addon
3. Install "EASUN Solar Monitor"
4. Configure: device="/dev/ttyUSB0", mqtt credentials, interval=5
5. Start → automatické senzory v MQTT integraci
```

### 📈 Dostupné senzory v HA

- `sensor.easun_pv_input_power` - PV výkon (W)
- `sensor.easun_pv_input_voltage` - PV napětí (V)
- `sensor.easun_battery_voltage` - Napětí baterie (V)
- `sensor.easun_battery_capacity` - Kapacita baterie (%)
- `sensor.easun_battery_power` - Výkon baterie (W)
- `sensor.easun_battery_status` - Status (charging/discharging/idle)
- `sensor.easun_ac_output_power` - AC výstup (W)
- `sensor.easun_ac_output_voltage` - AC napětí (V)
- `sensor.easun_load_percent` - Zatížení (%)
- `sensor.easun_inverter_temperature` - Teplota (°C)
- `sensor.easun_grid_voltage` - Grid napětí (V)
- `sensor.easun_inverter_mode` - Režim (grid/battery)
- `sensor.easun_status` - Celkový status

---

## 🎯 Finální souhrn obou projektů

**Datum dokončení:** 18. července 2025  
**Status:** ✅ OBA PROJEKTY KOMPLETNĚ DOKONČENY - READY FOR PRODUCTION

### 📊 Dosažené výsledky

| Měnič | Přesnost | Metoda | GitHub | Verze |
|-------|----------|--------|--------|-------|
| **EASUN SHM II 7K** | 100% | Přímá hodnota z pozice 19 | https://github.com/9991119990/easun-ha-addon | 1.0.0 |
| **MPP Solar PIP5048MG** | 98.2% | Přímá hodnota z pozice 19 | https://github.com/9991119990/mpp-solar-ha-addon | 2.0.0 |

### 🏆 Klíčové úspěchy

1. **Jednotné řešení** - OBA měniče čtou PV výkon z pozice 19
2. **Vysoká přesnost** - EASUN 100%, MPP Solar 98.2%
3. **Real-time monitoring** - 5 sekund interval
4. **Profesionální dokumentace** - Kompletní návody a backup
5. **Production ready** - Stabilní, spolehlivé, testované
6. **MQTT auto-discovery** - Automatické senzory v HA
7. **Multi-arch support** - ARM i x86 platformy

### 📁 Kompletní zálohy

- **GitHub Backup:** https://github.com/9991119990/easun-solar-backup
- **Lokální backup:** `/home/dell/EASUN_BACKUP_FINAL/`
- **Lokální backup:** `/home/dell/MPP_SOLAR_BACKUP_FINAL/`

**✅ REFERENCE PRO BUDOUCÍ PRÁCI S SOLÁRNÍMI MĚNIČI**

Toto je kompletní reference pro budoucí práci s MPP Solar, EASUN či podobnými měniči s PI30 protokolem.