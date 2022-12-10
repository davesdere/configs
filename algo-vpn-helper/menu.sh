#!/bin/bash
# Manage your Algo VPN on a EC2

configure_tool() {
    echo "# Configuring tool"
    prompt="Choose an option: "
    options=("EC2 Tag 'Name' value" "AWS CLI profile name" "View configs")
    PS3="$prompt "
    select opt in "${options[@]}" "Main menu"; do 
        case "$REPLY" in
        1) read -p "Enter name: " EC2_NAME_TAG;;
        2) read -p "Enter AWS CLI profile name: " AWS_CLI_PROFILE;;
        3) echo "# EC2 Tagged : ${EC2_NAME_TAG}  AWS CLI Profile Name: ${AWS_CLI_PROFILE}";;
        4) main;;
        $((${#options[@]}+1))) echo "Goodbye!"; break;;
        *) echo "Invalid option. Try another one.";continue;;
        esac
        REPLY=
    done
    
}
update_sg_rules (){
    bash ./update-sg.sh ${EC2_NAME_TAG} ${AWS_CLI_PROFILE}
}

start_ec2(){
    bash ./start-ec2.sh ${EC2_NAME_TAG} ${AWS_CLI_PROFILE}
}

stop_ec2(){
    bash ./stop-ec2.sh ${EC2_NAME_TAG} ${AWS_CLI_PROFILE}
}

check_ec2(){
    bash ./check-ec2.sh ${EC2_NAME_TAG} ${AWS_CLI_PROFILE}
}
destroy_infrastructure(){
    bash ./destroy-infrastructure.sh ${EC2_NAME_TAG} ${AWS_CLI_PROFILE}
}

main(){
    title="Algo VPN helper for AWS EC2"
    prompt="Pick an option:"
    options=("Configure tool" "Start the EC2" "Stop the Ec2" "Check status of EC2" "Update ingress on EC2", "Destroy infrastructure")

    echo "$title"
    PS3="$prompt "
    select opt in "${options[@]}" "Quit"; do 
        case "$REPLY" in
        1) configure_tool;;
        2) start_ec2;;
        3) stop_ec2;;
        4) check_ec2;;
        5) update_sg_rules;;
        6) destroy_infrastructure;;
        $((${#options[@]}+1))) echo "Goodbye!"; exit;;
        *) echo "Invalid option. Try another one.";continue;;
        esac
        REPLY=
    done
}


main
