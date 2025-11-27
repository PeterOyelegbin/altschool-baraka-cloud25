# ✨ Month 2 (Assignment 1)
Create a bash script to run at every hour, saving system memory (RAM) usage to a specified file and at midnight it sends the content of the file to a specified email address, then starts over for the new day.


## 🖊 Instruction
- Submit the content of your script, cronjob and a sample of the email sent, all in the folder for this exercise.


## 🚀 Result
1. Created a bash script to automate the memory usage log and report [memory_used script](./memory_used.sh).

2. Setup cronjob to schedule the task [cronjob content](./crontab).

3. Installed and cofigure postfix as send only smtp server using the steps below;
   - Update the package database
   ```bash
   sudo apt-get update
   ```
   - Installing mailutils will install Postfix as well as a few other programs needed for Postfix to function.
   ```bash
   sudo apt install mailutils -y
   ```
   - Select "internet-site" in the configuratin window and click "Ok" as seen below
     ![mail_config](./mail_config.png)
   - Update the system mail name to "localhost.com" or leave the default value.
     ![mail_name_config](./mail_name_config.png)
   - Edit the file "main.cf" to configure postfix
   ```bash
   sudo nano /etc/postfix/main.cf
   ```
   - Find and update the following details as seen below
   ```
   inet_interfaces = loopback-only
   mydestination = localhost.$mydomain, localhost, $myhostname
   ```
   - Save and restart postfix `sudo systemctl restart postfix`
   - Run a test using your email, I recommend using a cpanel webmail, gmail might not work
   ```
   echo "Test PostFix mail" | mail -s "Mail Test" your_email_address
   ```

4. Set the server timezone to my local timezone using the command
    ```bash
    sudo timedatectl set-timezone Africa/Lagos
    ```

5. Below is the image of the mail received
   ![mail sample](./mail_sample.png)


## 📑 Resources Used
- [Crontab Guru](https://crontab.guru/)
- [DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-postfix-as-a-send-only-smtp-server-on-ubuntu-16-04)
