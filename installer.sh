#!/bin/bash

START_TIME=$(date +%s)
LOGFILE="/var/log/skyport-install.log"
WORKDIR="/tmp/skyport-install"
VERSION="3.1"

BLUE='\033[0;94m'
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'
BOLD='\033[1m'

mkdir -p "$WORKDIR"
exec 3>&1
exec 4>&2
exec 1> >(tee -a "$LOGFILE") 2>&1

trap 'cleanup; exit 1' INT TERM

check_existing_installation() {
    local component=$1
    local directory=$2
    
    if [ -d "$directory" ]; then
        echo -e "${YELLOW}Warning: $component directory ($directory) already exists.${NC}"
        while true; do
            read -p "Do you want to continue with the installation? This may overwrite existing files [y/N]: " response
            case $response in
                [Yy]* )
                    log "User chose to continue installation despite existing $component directory"
                    return 0
                    ;;
                [Nn]* | "" )
                    log "User chose to abort installation due to existing $component directory"
                    echo -e "${RED}Installation aborted by user${NC}"
                    return 1
                    ;;
                * )
                    echo "Please answer y or n"
                    ;;
            esac
        done
    fi
    return 0
}

elapsed_time() {
    local end_time=$(date +%s)
    local elapsed=$((end_time - START_TIME))
    local hours=$((elapsed / 3600))
    local minutes=$(( (elapsed % 3600) / 60 ))
    local seconds=$((elapsed % 60))
    printf "${BLUE}Time Elapsed: %02d:%02d:%02d${NC}\n" $hours $minutes $seconds
}

show_banner() {
    clear
    cat << "EOF"
 ____  _                           _   
/ ___|| | ___   _ _ __   ___  _ __| |_ 
\___ \| |/ / | | | '_ \ / _ \| '__| __|
 ___) |   <| |_| | |_) | (_) | |  | |_ 
|____/|_|\_\\__, | .__/ \___/|_|   \__|
            |___/|_|                    
EOF
    echo -e "\n${BOLD}Skyport Installer v${VERSION}${NC}\n"
    echo -e "\n${BOLD}script by Greenflame1507 software from skyportlabs${NC}\n"
    echo -e "\n${BOLD}All rights reserved${NC}\n"
    elapsed_time
}

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOGFILE"
}

execute_step() {
    local cmd="$1"
    local msg="$2"
    
    echo -e "${BLUE}$msg${NC}"
    log "Executing: $msg"
    
    if eval "$cmd" &>> "$LOGFILE"; then
        echo -e "${GREEN}✓ Complete${NC}\n"
        return 0
    else
        echo -e "${RED}✗ Failed${NC}\n"
        return 1
    fi
}

cleanup() {
    echo -e "${BLUE}Cleaning up temporary files${NC}"
    rm -rf "$WORKDIR"
}

check_dependencies() {
    local deps=("curl" "git" "node" "npm" "docker")
    local missing=()
    
    for dep in "${deps[@]}"; do
        if ! command -v $dep &> /dev/null; then
            missing+=($dep)
        fi
    done
    
    if [ ${#missing[@]} -ne 0 ]; then
        echo -e "${BLUE}Missing dependencies: ${missing[*]}${NC}"
        return 1
    fi
    return 0
}

install_dependencies() {
    echo -e "\n${BOLD}Installing Dependencies${NC}"
    
    execute_step "mkdir -p /etc/apt/keyrings" "Setting up keyrings directory"
    execute_step "curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg" "Adding NodeSource repository"
    execute_step "echo 'deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main' | tee /etc/apt/sources.list.d/nodesource.list" "Configuring NodeSource"
    execute_step "apt-get update" "Updating package lists"
    execute_step "DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs git curl" "Installing Node.js and Git"
    execute_step "curl -sSL https://get.docker.com/ | CHANNEL=stable bash" "Installing Docker"
    
    if check_dependencies; then
        return 0
    else
        return 1
    fi
}

install_panel() {
    echo -e "\n${BOLD}Installing Skyport Panel${NC}"
    
    # Check if panel directory exists
    if ! check_existing_installation "Panel" "/etc/skyport"; then
        return 1
    fi
    
    execute_step "cd /etc && git clone --branch v0.2.2 https://github.com/skyportlabs/panel skyport" "Cloning Panel repository"
    execute_step "cd /etc/skyport && npm install" "Installing Panel dependencies"
    execute_step "cd /etc/skyport && npm run seed" "Initializing database"
    
    echo -e "${BLUE}Creating admin user:${NC}"
    cd /etc/skyport && npm run createUser
    
    if [ -d "/etc/skyport" ]; then
        return 0
    else
        return 1
    fi
}

install_daemon() {
    echo -e "\n${BOLD}Installing Skyport Daemon${NC}"
    
    # Check if daemon directory exists
    if ! check_existing_installation "Daemon" "/etc/skyportd"; then
        return 1
    fi
    
    execute_step "cd /etc && git clone --branch v0.2.2 https://github.com/skyportlabs/skyportd" "Cloning Daemon repository"
    execute_step "cd /etc/skyportd && npm install" "Installing Daemon dependencies"
    execute_step "npm install -g pm2" "Installing PM2"
    
    if [ -d "/etc/skyportd" ]; then
        return 0
    else
        return 1
    fi
}

configure_services() {
    echo -e "\n${BOLD}Configuring Services${NC}"
    
    execute_step "cd /etc/skyport && pm2 start . --name skyport-panel" "Starting Panel service"
    execute_step "cd /etc/skyportd && pm2 start index.js --name skyport-daemon" "Starting Daemon service"
    execute_step "pm2 startup && pm2 save" "Setting up autostart"
}

remove_component() {
    local component=$1
    echo -e "\n${BOLD}Removing $component${NC}"
    
    case $component in
        "panel")
            execute_step "pm2 delete skyport-panel" "Stopping Panel service"
            execute_step "rm -rf /etc/skyport" "Removing Panel files"
            ;;
        "daemon")
            execute_step "pm2 delete skyport-daemon" "Stopping Daemon service"
            execute_step "rm -rf /etc/skyportd" "Removing Daemon files"
            ;;
        "dependencies")
            execute_step "apt-get remove -y nodejs git docker.io" "Removing packages"
            execute_step "apt-get autoremove -y" "Cleaning up"
            execute_step "rm -rf /etc/apt/sources.list.d/nodesource.list" "Removing repositories"
            ;;
    esac
}

show_menu() {
    while true; do
        show_banner
        echo -e "${BOLD}Installation Options:${NC}"
        echo -e "${BLUE}1)${NC} Install Everything"
        echo -e "${BLUE}2)${NC} Install Panel Only"
        echo -e "${BLUE}3)${NC} Install Daemon Only"
        echo -e "${BLUE}4)${NC} Install Dependencies Only"
        echo -e "${BLUE}5)${NC} Remove Panel"
        echo -e "${BLUE}6)${NC} Remove Daemon"
        echo -e "${BLUE}7)${NC} Remove Dependencies"
        echo -e "${BLUE}8)${NC} Exit"
        
        read -p "Select option [1-8]: " choice
        
        case $choice in
            1)
                install_dependencies && install_panel && install_daemon && configure_services
                ;;
            2)
                install_dependencies && install_panel
                ;;
            3)
                install_dependencies && install_daemon
                ;;
            4)
                install_dependencies
                ;;
            5)
                remove_component "panel"
                ;;
            6)
                remove_component "daemon"
                ;;
            7)
                remove_component "dependencies"
                ;;
            8)
                echo -e "\n${GREEN}Installation complete!${NC}"
                elapsed_time
                exit 0
                ;;
            *)
                echo -e "\n${RED}Invalid option${NC}"
                ;;
        esac
        
        echo -e "\nPress Enter to continue..."
        read
    done
}

if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}Please run as root${NC}"
    exit 1
fi

show_menu