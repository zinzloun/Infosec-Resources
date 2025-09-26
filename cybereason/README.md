# ![Cyb](cyb.png) Cybereason OnPrem API

## Use Case: Retrieve Active MalOps in the Current Week

This script automates the retrieval of active MalOps for the current week and performs related actions. Specifically, it:

1. Reads configuration parameters from a `.ini` file.  
2. Authenticates to the Cybereason Webserver.  
3. Sends a request to the API endpoint to query active MalOps for the current week.  
4. Sends an email notification if any MalOps are found.  
5. Writes a log file (in `w` mode).  
6. Closes the session.

### Note

Although this information is not documented on the Nest, Cybereason support confirmed:

> "The API call `/rest/detection/inbox` is deprecated, but it still exists in On-Prem API calls."

As a result, this call **may no longer work in future releases** (version > 23.2.307).
