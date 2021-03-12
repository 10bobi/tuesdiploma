#!/bin/bash
function check_cloud_health(){
    wget -q --spider http://google.com
    if [ $? -eq 0 ]; then
       return true
    else
        return false
    fi
}
function send_request_to_cloud(pic) {
    curl -X POST ADDRESS_CLOUD 
    DATE=$(date +"%Y-%m-%d_%H%M")
    raspistill -vf -hf -o /home/pi/camera/$DATE.jpg
    curl -T /home/pi/$DATE.jpg ftp://ftp-host-machine//yourwebsite/folder/filename.jpg --user yourftpusername:yourpas
}
function offline_check(pic) {
    plates = recognise_plate(pic)
    for plate in plates; do return check_cache(plate)
}
function recognise_plate(pic){
    docker run -it --rm -v $(pwd):/data:ro stiliancvetkov/tuesalpr -c eu + "pic"
}
function check_cache(plate) {
   if (select * from cache where plate_id = plate;); do return true
}
pic = '/home/pi/ra.jpg'
if check_cloud_health() -eq true; do send_request_to_cloud(pic)
else offline_check(pic)
