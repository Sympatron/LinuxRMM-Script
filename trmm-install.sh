function install_rmmagent() {
    echo "TacticalRMM-Agent Windows manual install command:"
    echo 'Example: tacticalagent-v2.4.6-windows-amd64.exe /VERYSILENT /SUPPRESSMSGBOXES && ping 127.0.0.1 -n 5 && "C:\Program Files\TacticalAgent\tacticalrmm.exe" -m install --api https://api.example.com --client-id 1 --site-id 6 --agent-type server --auth 1ab2ca24'
    read first_line
    echo "MshCentral Linux Binary Installer command:"
    echo 'Example: wget -O meshagent "https://mesh.example.com/meshagents?id=XXXXX&installflags=X&meshinstall=X'
    read second_line

    api=$(echo "$first_line" | grep -oP '(?<=--api )[^ ]+')
    client_id=$(echo "$first_line" | grep -oP '(?<=--client-id )[0-9]+')
    site_id=$(echo "$first_line" | grep -oP '(?<=--site-id )[0-9]+')
    agent_type=$(echo "$first_line" | grep -oP '(?<=--agent-type )[a-z]+')
    auth=$(echo "$first_line" | grep -oP '(?<=--auth )[0-9a-f]+')
    mesh_url=$(echo "$second_line" | grep -oP '(?<=wget -O meshagent ")[^"]+')

    wget 'https://github.com/Sympatron/LinuxRMM-Script/blob/main/rmmagent-linux.sh'
    chmod +x rmmagent-linux.sh
    ./rmmagent-linux.sh install 'amd64' "$mesh_url" "$api" "$client_id" "$site_id" "$auth" "$agent_type"
}