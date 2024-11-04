#!/bin/bash

ADMIN_WHATSAPP_NUMBER="083161246809"

WHATSAPP_FILE="/var/whatsapp_number.txt"
LICENSE_FILE="/var/license.txt"
ERROR_FILE="/var/error_count.txt"

# Token akses pengguna langsung di dalam skrip
USER_TOKEN="buyerpremium"

# Inisialisasi file kesalahan jika tidak ada
if [[ ! -f "$ERROR_FILE" ]]; then
    echo "0" > "$ERROR_FILE"
fi

# Definisi warna untuk tampilan teks
ORANGE='\033[33m'
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RESET='\033[0m'
NC='\033[0m'

# Fungsi untuk validasi token pengguna
validate_user_token() {
    # Meminta input token dari pengguna
    echo -e "${RED}[+] ====================================== [+]${NC}"
    echo -e "${RED}[+]     WELCOME TO PREMIUM INSTALLER       [+]${NC}"
    echo -e "${RED}[+]               RII STORE                [+]${NC}"
    echo -e "${RED}[+] ====================================== [+]${NC}"
    echo -e ""
    echo -e "${RED}SILAHKAN MASUKAN TOKEN YANG DI BERI RIISTORE${NC}"
    echo -e "${RED}ANDA BELUM MENDAPATKAN TOKEN? BELI DI RIISTORE${NC}"
    echo -e "${RED}CUMAN 10K DAH FREE UPDATE${NC}"
    echo -e "${GREEN}WHATSAPP : 083161246809${NC}"
    echo -e "${BLUE}INSTAGRAM : @fakhriigt${NC}"
    echo -e "${YELLOW}MASUKAN TOKEN YANG ANDA BELI DI RIISTORE :${NC}"
    read -r USER_INPUT

    # Memeriksa apakah token yang dimasukkan sesuai
    if [ "$USER_INPUT" = "$USER_TOKEN" ]; then
        echo -e "${GREEN}AKSES BERHASIL${NC}"
    else
        echo -e "${RED}AKSES GAGAL${NC}"
        exit 1
    fi
    clear
}

# Memvalidasi token sebelum memulai
validate_user_token

# Fungsi untuk menyimpan konfigurasi
save_config() {
    echo "DISABLE_ANIMATIONS=${DISABLE_ANIMATIONS}" > /var/www/pterodactyl/config/installer_config
}

# Fungsi untuk memuat konfigurasi
load_config() {
    if [[ -f /var/www/pterodactyl/config/installer_config ]]; then
        source /var/www/pterodactyl/config/installer_config
    else
        DISABLE_ANIMATIONS=0
    fi
}

# Fungsi untuk menampilkan animasi teks
animate_text() {
    local text="$1"
    for ((i=0; i<${#text}; i++)); do
        printf "%s" "${text:$i:1}"
        sleep 0.03  # Memberikan jeda agar terlihat seperti animasi
    done
    echo ""
}

# Fungsi untuk menampilkan animasi loading
loading_animation() {
    local spinstr='|/-\'
    local i=0
    while [ "$i" -lt 20 ]; do  # Membatasi jumlah iterasi agar tidak infinite
        printf " [%c] Loading..." "${spinstr:i++%${#spinstr}:1}"
        sleep 0.1
        printf "\r"
    done
}

# Mulai script dengan membersihkan terminal
load_config
clear
echo -e "${RED}Starting Installer...${RESET}"

