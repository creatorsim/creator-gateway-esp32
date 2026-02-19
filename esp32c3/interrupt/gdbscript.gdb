set remote hostio-read-buffer-limit 4096
set remote hostio-write-buffer-limit 4096
set remotetimeout 20
target extended-remote :3333
monitor reset halt  
maintenance flush register-cache  
thbreak main
continue
