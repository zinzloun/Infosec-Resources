import smtplib
from email.message import EmailMessage
import requests
import json
from datetime import datetime, timedelta
import sys
import configparser

# -----------------------------
# Configuration
# -----------------------------
config = configparser.ConfigParser()
# Example config file path
config.read("./config.ini")  # Make sure your real config.ini is in .gitignore

username = config["DEFAULT"].get("USER", "username_email-recipient")
password = config["DEFAULT"].get("PWD", "your_password")
server = config["DEFAULT"].get("SERVER", "cybereason_server")
port = config["DEFAULT"].get("PORT", "443")

SMTP_SERVER = config["DEFAULT"].get("SMTP_SERVER", "smtp.example.com")
SMTP_PORT = config["DEFAULT"].get("SMTP_PORT", "25")
sender = config["DEFAULT"].get("SENDER", "sender@example.com")

LOG_FILE = "./malops_report.log"  # log file path
log_file_handle = open(LOG_FILE, "w")

# -----------------------------
# Functions
# -----------------------------
def log(message):
    """Writes the message to the log file."""
    log_file_handle.write(f"{datetime.now().strftime('%Y-%m-%d %H:%M:%S')} - {message}\n")
    log_file_handle.flush()

def send_email(sender, recipient, subject, body, smtp_server=SMTP_SERVER, smtp_port=SMTP_PORT):
    """Sends an email via SMTP without authentication, adding date/time to the subject"""
    now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    subject_with_datetime = f"{subject} - {now}"
    body_str = str(body)

    msg = EmailMessage()
    msg["From"] = sender
    msg["To"] = recipient
    msg["Subject"] = subject_with_datetime
    msg.set_content(body_str)

    try:
        with smtplib.SMTP(smtp_server, smtp_port) as smtp:
            smtp.send_message(msg)
        log(f"Email sent successfully to {recipient} with subject: {subject_with_datetime}")
    except Exception as e:
        log(f"Error sending email: {e}")


data = {
    "username": username,
    "password": password
}

# Use a placeholder for the certificate path
CERT_PATH = "/path/to/cybereason/webserver.crt"

headers = {"Content-Type": "application/json"}

base_url = f"https://{server}:{port}"
login_url = f"{base_url}/login.html"

session = requests.session()
login_response = session.post(login_url, data=data, verify=CERT_PATH)

log(login_response.status_code)
log(list(session.cookies.items()))

# API Request URL
endpoint_url = "/rest/detection/inbox"
api_url = f"{base_url}{endpoint_url}"

# -------------------------------
# Calculate start and end of the current week
# -------------------------------
today = datetime.today()
start_dt = today - timedelta(days=today.weekday())  # Monday
start_dt = start_dt.replace(hour=0, minute=0, second=0, microsecond=0)
end_dt = start_dt + timedelta(days=6, hours=23, minutes=59, seconds=59)  # Sunday end of day

start_time = int(start_dt.timestamp() * 1000)
end_time = int(end_dt.timestamp() * 1000)
log(f"Requested period: {start_dt} → {end_dt}")
# log(f"|_start_time = {start_time}, end_time = {end_time}")

try:
    query = json.dumps({"startTime": start_time, "endTime": end_time})
    api_response = session.request("POST", api_url, data=query, headers=headers)
    your_response = json.loads(api_response.content)
except Exception as e:
    log(f"API response error: {e}. Check authentication parameters and server accessibility")
    sys.exit(1)

active_malops = [m for m in your_response.get("malops", []) if m.get("malopStatus") == "Active"]
if active_malops:
    log("==>There are active MalOps!!!<==")
    body_eml = json.dumps(active_malops, indent=4, sort_keys=True)
    send_email(sender=sender, recipient=username, subject="Cybereason alert: active MalOps", body=body_eml)
else:
    log("No active MalOps found, you can sleep soundly :)")

# -------------------------------
# Destroy session
# -------------------------------
logout_url = f"{base_url}/logout"

try:
    session.post(logout_url, verify=CERT_PATH)
    log("Session closed successfully.")
except Exception as e:
    log(f"Error during logout: {e}")
finally:
    session.close()

log_file_handle.close()
