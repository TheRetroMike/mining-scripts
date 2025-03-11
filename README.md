# Mining Scripts
A collection of Misc Mining Scripts

### MMP-CLORE.sh
This is a script that you can download to your MMP OS mining rig, configure, and run as a cron job every minute that will start your miner when not rented on clore and when the system gets rented on clore, it will stop the miner
Config Settings:
- CLORE_SERVER_NAME - This is the name of your system in the clore dashboard. It must match exactly and if you change the server name in the dashboard, you need to also change it in this script
- CLORE_API_KEY - This is the API Key for Clore that you can get from the Clore Dashboard by going to your Profile -> SSH & API Keys -> API Key tab
- MMP_FARM_ID - This is the ID for your farm in MMP OS. You can access this by going to Farms, selecting your farm, and copying the ID from the URL. It will be a guid in the format of xxx-xxx-xxx-xxx-xxx
- MMP_RIG_ID - This is the ID for your rig in MMP OS. You can access this by going to Rigs, selecting your rig, and copying the ID from the URL. It will be a guid in the format of xxx-xxx-xxx-xxx-xxx
- MMP_API_KEY - This is the API Key that can be found under your profile in MMP OS. If you do not see an API Key, you need buy at least one credit to enable it.

You can download to your system by connecting via SSH and then running this command
```
sudo wget -O /opt/mmp-clore.sh https://raw.githubusercontent.com/TheRetroMike/mining-scripts/refs/heads/main/mmp-clore.sh && sudo chmod +x /opt/mmp-clore.sh
```

After you download it, you will want to run the following command to edit the config settings at the top of the file. Then do ctrl+x, then Y, then enter to save and exit
```
sudo nano /opt/mmp-clore.sh
```

I then recommend setting up a cron schedule. To do this run ```sudo crontab -e```, enter 1 if it's your first time and your prompted for a text editor and then hit enter and add a new line to the text file with the following and then save and exit.
```
* * * * * /opt/mmp-clore.sh
```
