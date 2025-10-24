# ![Cyb](cyb.png) Cybereason OnPrem

## Retrieve Active MalOps in the Current Week, using API
This [script](./getMalops.py) automates the retrieval of active MalOps for the current week and performs related actions. Specifically, it:

1. Reads configuration parameters from a `.ini` file.  
2. Authenticates to the Cybereason Webserver.  
3. Sends a request to the API endpoint to query active MalOps for the current week.  
4. Sends an email notification if any MalOps are found.  
5. Writes a log file (in `w` mode).  
6. Closes the session.

### Requirements

- Python 3  
- Cybereason root CA certificate (PEM format) — required if the Cybereason server uses an internal or private CA  
- The system making API calls **must trust** the above certificate

> For testing purposes only, you can skip certificate verification by using `verify=False` in the requests call (instead of `verify=CERT_PATH`). **This is strongly discouraged in production** because it disables TLS certificate validation.

**Note:** It is not enough to simply provide the certificate path in the script. The certificate must also be installed and trusted on the client system (the machine making the API calls).


## Setup

1. **Create a configuration file** `config.ini` in the same directory as the script:

```ini
[DEFAULT]
USER = your_username@example.com (this is also the email recipient)
PWD = your_password
SERVER = your_cybereason_server
PORT = 443
SMTP_SERVER = smtp.example.com
SMTP_PORT = 25
SENDER = sender@example.com
```

### Security consideration and best practice
- Run the script as standard user, you don't need SUDO or root at all
- On Cybereason create a user with the minimal privilege to read Malpos, use the related role already configured. Use this user to make the API calls
- Be sure to set appropriate permission to the configuration file

      chmod 640 config.ini

### Note

Although this information is not documented on the Nest, Cybereason support confirmed:

> "The API call `/rest/detection/inbox` is deprecated, but it still exists in On-Prem API calls."

As a result, this call **may no longer work in future releases** (version > 23.2.307) 

## Check installation requirements for Linux sensors (23.2.307)
You can use this [script](./cybereason-sensor-req-check.sh) to automate the process

![Cyb](cyb.png)
