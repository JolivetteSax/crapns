# crapns

## Run Server

Depends
```
sudo apt-get install pip3 python3 
pip3 install flask
```

Start Server

```
./server.sh
tail -f crapns.log
```

## Run Client

Dependencies

```
sudo apt-get install curl inotify-tools
```

Run the polling/disco script and sudo the copy loop that watches the 
hosts file written by the polling loop. It's good to see the initialize
script finish creating the hosts file before starting the copyloop script

```
./initialize.sh &> client.log &
sudo ./copyLoop.sh &> /dev/null &
```

You can end your terminal session safely, but don't forget you'll fire a SIGHUP
and kill these scripts in certain cases, and nohup would be better than `&`.

## What is crapns?

Remembering IP addresses on your local LAN is crappy. Now that I've got more than 
one server I don't want to do this any more. 

My home router is doing DHCP just fine. I don't want to turn that off, stand up
yet another server, run DHCP and set static addresses. I don't want to run my own 
home DNS server, nor do I want to configure the router to use a different DNS, 
I'd like to keep as much plug'n'play as possible.

Crapns allows a computer on this network (that knows the wifi password, so it's cool)
to register a name and local IP address. Connecting to the crapns service will allow
a host to download the current list and add those entries to /etc/hosts

When I install ubuntu on a new machine, I set a hostname - git clone and run the client
scripts, and voila, everyone on the network should get this entry when they poll for 
new hosts. 

### Why is it crappy?
 * Engineering is a function compromising costs
 * This is really insecure, I don't really recommend it, lol
 * this is only going to work with gnu/linux builds. Having phones/chromebooks doesn't 
   help me. 

### Why is it not crappy?
 * It's really simple
 * I don't care that it's not very secure
 * I don't want to have zenity tell me the IP of the minecraft server any more
