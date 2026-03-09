set remotetimeout 20
target extended-remote :3333
monitor reset halt  
maintenance flush register-cache  
thbreak main
continue
