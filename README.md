# Moodle on Cyber Panel

These few scripts help build a moodle virtual server on Cyber Panel. To do everything wihout any interaction add the following to the virtual server creation wizard after saving these scripts to the virtual server creator's home directory (remember to make them executable <code>sudo chmod +x</code>:

<code>non-interactive.sh --quite</code>

Each script can be run independently if desired if the virtual server has already been created or an existing virtual server needs to be reconfigured. The best ourcome is however to add non-interactive.sh to the post-configuration instruction at virtual server creation using <code>sh non-interactive.sh --quiet</code>. You can edit the virtual seerver default template to include this instruction so it installs a moodle instance to every new virtual server you make going forward. 

## Scripts

1. skel.sh creates a skeleton directory with the latest moodle code and an empty moodledata folder.
2. init.sh installs moodle with default configurations and some demo content and also adds a new cronjob for this virtual server user to run cron.php every minute.
3. perms.sh fixes any files and folders that could possibly have incorrect permissions.

## Usage

These should be run using the GUI of a correctly configured Cyber Panel. There are two possible ways to use these scripts:

### 1. Virtual Server Creation

Add <code>sh non-interactive.sh --quite</code> to the default virtual server creation wizard or use it on an individual, non-default creation <i>as a Cyber Panel administrator</i>. Use <code> tail -f ~/etc/log/deploy.log</code> via SSH to the Cyber Panel server to follow the deployment. It might take a couple of seconds before the log file is created so keep trying if it doesn't exist at first. Of course there are more logs about the virtual server setup in the usual places both on Cyber Panel and in /etc/log/...

### 2. Post-creation Install

If a virtual server already exists and needs a moodle installation then each script should be run <i>as the virtaul server user</i> for the existing virtual server</i>. Running these scripts as the incorrect user may result in 503 Permission Denied errors. Fix your mistake by using the Cyberpanel tool to fix permissions. 

## Configuration

After running these scripts you should be sure to check these before taking your site live. If you used non-interactive.sh you'll need to manually take the moodle site off maintainance mode after doing these checks.

1. Visit /admin/index.php?cache=1 to ensure the moodle cron is running correctly. You may need to wait a couple of minutes before you see the error disappear but not longer than that. If it persists then check the cron settings on Cyber Panel (or using crontab via SSH).
2. Test that the site's email sending is functioning properly. Some organizations will reject mail from a moodle installation. Email is a tricky business. If you're not able to use the organisation's own SMTP service then try using a relay service like Mailjet. Moodle's default sending method on a Cyber Panel install is PHP's default method and is not recommended.
3. Ensure the site's SSL certificate is valid and does not complain about mixed-content. If it does, then run <code>sudu -u [VIRTUALSERVERUSER] certbot --nginx</code> via SSH in the offending virtual server's home directory as the virtual server user.
4. Run the backup tool on Cyber Panel to check whether backups complete in a reasonable time and make absolutely certain that the backup it creates can be restored again. Check this monthly if you can. It's important. 
5. You can edit config.php via SSH only (for now) so any changes made using the Cyber Panel front end for the virtual server won't iterate to the live site until the webserver is reloaded. I mean, you can edit it but the changes will only reflect if the webserver is reloaded at all, but on default Cyber Panel installs this happens roughly four hours.

To take the site out of maintainance mode login to moodle as an adminitrator at /admin and turn it off at Admin > System > Maintainance mode or use SSH to run </code>sudo -u [VIRTUALSERVERUSER] php ~/public_html/admin/cli/maintainancemode.php --disable</code>

# To-do

1. <code>--quiet</code> parameter is not implemented yet so using it will throw syntax errors at the moment. Sorry about that. The output from scripts will print witout it. Not a problem but not as elegant as it should be for setting up a new virtual server. I'll be back. 
2. <code>The output of these scripts isn't all that helpful for debugging using the log it creates, so this needs work. Still the usual logs can be used just as easily or you can pipe to stdout or stderr or tee them both when running these.
3. ... add default site content. An empty moodle is a sad moodle. Some default content, perhaps a course and a couple or demo users, would be a benefit for new moodle users and as a nice to have for post-intall notifications. I'll likely do this using git on the Cyber Panel server instead of pulling Moodle from source.

That's all. Bye!
