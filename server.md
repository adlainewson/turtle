## VSE Server Manual
<img src='turtle.jpg' />

This brief tutorial will familiarize you with how to connect to and use the VSE linux server. You first need to have an account set up. Email Masaru Kiyota at masaru.kiyota@ubc.ca to get an account set up, and specify that you would like an account on the graduate computation server in the economics department.

### Contents
[Server overview](#overview)

[Server use policy](#policy)

[How to connect](#howto)
 1. [Connecting to the UBC VPN](#vpn)
 2. [Connecting to the server](#vncssh)

[Transferring files](#transfer)

[Using Stata and MATLAB](#stata)

[Keep Jobs Running after Logout](#detach)

[Running Long Jobs at Lower Priority](#nice)

[Downloading software](#software)

[The linux command line](#linux)

[Other resources](#res)

<a id="overview"></a>
### Server Overview 
The server is running CentOS linux, which is a RedHat derivative designed specifically for servers. Check out the gritty details on the CentOS wiki: [https://wiki.centos.org/](https://wiki.centos.org/) - but if you're new to linux this is not the place to look for information as it's aimed at server administrators; other resources will be introduced below.

The server has 12 dual-cores, 188G of memory, and over 1TB of storage. 

Installed computational software includes: Python (2.7/3), MATLAB 2014, Stata 14, Julia, R, Dynare, and Octave. 

Currently the server is running GNOME for its default desktop environment, but XFCE and fluxbox are also installed.

<a id="policy"></a>
### Server use policy
The server is for computation purposes only, not for routine tasks you could do equally well on your laptop (for example, document processing or web browsing).

Currently, the hard disk storage limit is set to 5GB for each PhD student, 2GB for each MA student. Also for each student, the memory limit is set to be 16GB.

If you need more memory or storage space for a designated period of time, contact Masaru Kiyotaki.

Because the processing power will be shared by all users on the server, it is important you are aware of the shared resources you are using. You can check how intensive your processes are by running `top -U adlai` in a terminal, replacing `adlai` with your username. See `man top` for further details on how to use top.

If you don't have code running on the server, please shut down any VNC sessions you have running (ie, log out of the X windows desktop environment), because these drain resources.

Please also read the section on [Running Long Jobs at Lower Priority](#nice).

<a id="howto"></a>
### How to Connect 
There are two steps to connecting to the server. 
 1. Connect to the UBC virtual private network (VPN)
 2. Once on the VPN, connect to the server

Think of our server as a house in a gated community. Connecting to the UBC VPN (1) is like getting let into the gated community, and connecting to the server (2) is like getting let into the house. 

<a id="vpn"></a>
#### 1. Connecting to the VPN
There are several ways of connecting to the VPN, and UBC has a page to help you:

[https://it.ubc.ca/services/email-voice-internet/myvpn/setup-documents](https://it.ubc.ca/services/email-voice-internet/myvpn/setup-documents)

The guide recommends you use the Cisco AnyConnect client, but you can use your client of choice - the connection information is provided for a manual setup.

If you run into trouble following their guide, the IT department or our in-house IT guy Masaru can help you out.

<a id="vncssh"></a>
#### 2. Connecting to the server

Once you're on the VPN, you can use the server in two ways: through Virtual Network Computing (VNC), or directly through Secure SHell (SSH). VNC is a popular protocol used for remote desktop access. If you have used any remote desktop software before, it's possible you have already used VNC. SSH is a way of connecting to the server using a terminal, and your interaction with the server will (not without exception) occur through the command line.

**Note:** VNC and SSH use different authentication systems, so you will have different passwords for both. Once logged into the server, you can use `passwd` to change your user account password (which is used by SSH) and `vncpasswd` to change your VNC password.

When you connect to the server using VNC, you will have a window open with a miniature window manager running inside; here's a screenshot of me using VNC to access the server; you can see my desktop, and Stata running on the server

<a href="http://i.imgur.com/fxXIyb7.png"><img src="http://i.imgur.com/fxXIyb7.png" style="width: 300px;"/></a>

Alternatively, you can use SSH alone. Unless you are running linux on your personal computer, this will mean that you can only interface with the computer through the terminal. Here's a screenshot of me running matlab on the server after connecting through SSH, side by side with MATLAB running locally.

<a href="http://i.imgur.com/5jRmTgP.png"><img src="http://i.imgur.com/5jRmTgP.png" style="width: 300px" /></a>

If you want to use VNC you still have to connect via SSH, so first we'll cover that.

##### Connecting via SSH
If you are on Linux or Mac this is very simple, just open a terminal and type:

```
ssh adlai@turtle.econ.ubc.ca
```

Replacing `adlai` with your username. Your computer will ask if you want to trust the server's credentials; say yes, and you're connected. 

If you are on Windows you can download a graphical SSH client. One such client that I can vouch for is available here: [http://www.putty.org/](http://www.putty.org/)

##### Connecting via VNC
There are two steps:
1. Log into the server with SSH and start a vncserver.
2. Connect to the VNC server using a VNC client.

First download a VNC client. Here are some options:

###### Cross Platform

[https://www.realvnc.com/download/viewer/](https://www.realvnc.com/download/viewer/)

[http://www.tightvnc.com/download.php](http://www.tightvnc.com/download.php)

###### Mac
See the guide at [http://osxdaily.com/2013/04/05/vnc-client-mac-os-x-screen-sharing/](http://osxdaily.com/2013/04/05/vnc-client-mac-os-x-screen-sharing/).

###### Linux/UNIX

[http://tigervnc.org/](http://tigervnc.org/)  (Recommended!)

Once you have the client, log into the server using SSH and change your password using `vncpasswd`. Once done, type `vncserver -autokill` to start a VNC session. You will get some output that tells you what port the VNC server is using, which will be a number in the range 5900-5999. Here is a screenshot of me logging in with SSH and starting the VNC server:

<a href="http://i.imgur.com/TkC0LNS.png"><img src="http://i.imgur.com/TkC0LNS.png" style="width: 300px" /></a>

My VNC server has started at address `turtle.econ.ubc.ca:3`, the 3 refers to the port 5903. Now I can log in using my VNC client using the following information:

```
hostname: turtle.econ.ubc.ca
port: 590X
```

Where you have to replace the `X` with the port assigned to you when the server started. The VNC client will ask you for the information above, along with your VNC password. 

For example, were I to connect to the server I started above on linux using tigervnc, I would enter the command

```
vncviewer turtle.econ.ubc.ca:5903
```

Since my port is 5903. I am then prompted for a password. Once you are finished with the VNC server, log out (don't just close the window) and the VNC server will shut down. If you want to run something for a long time it is recommended you do not use VNC if possible but rather run your code in the shell, which is less of a resource drain.

If you forget the port where VNC is running, log back in using SSH and type `ls ~/.vnc/*.pid`. If you see a file ending with .pid, it means the VNC server is still running, and the port number will be shown. Here's a picture:

<a href="http://i.imgur.com/aOIvwNj.png"><img src="http://i.imgur.com/aOIvwNj.png" style="width: 300px" /></a>

I have a file there called `turtle.econ.ubc.ca:3.pid`, which means I have a VNC server running on display 3 (port 5903). To shut down the server, type `vncserver -kill :3`, changing the 3 as appropriate. 

<a id="transfer"></a>
### Transferring Files to and from the Server
Files on the server are persistent, and stored in your home directory. The location of this directory will be in the `home` folder, a subdirectory of the root `/` directory. For example, `/home/adlai`. 

Everything inside your home directory is 'yours', you can create or delete directories as you see fit. Besides the ways of transferring files you are probably familiar with (Dropbox, emailing them to yourself) you can transfer files directly using SSH. This will be very fast when you are on campus, good for large files.

There are several ways to do this. On Linux (and possibly also Mac) you can use the `scp` command, for "Secure CoPy". Here's how it works:

Suppose you want to copy some matlab files from a local directory `myproject` to a directory in your home folder on the server called `myfiles`. From your laptop, open a terminal, navigate to `myproject`, then type 

```
[adlai@laptop ~]$ scp * adlai@turtle.ubc.ca:/home/adlai/myfiles/
```

This command says 'copy all the files (\*) in `myproject`, on my machine, to the directory `myfiles`, on the server'. You will be prompted for your SSH password, then the transfer will start.

To transfer files from the server to your local machine, you can use the same command. The trailing `.` refers to the current working directory, so this command says copy all files from the directory `myfiles` on the server into the current working directory on my local machine.

```
[adlai@laptop ~]$ scp adlai@turtle.ubc.ca:/home/adlai/myfiles/* . 
```

If you are on Windows, you can accomplish something similar with a graphical SSH client like PuTTy, linked above. See the link here: [http://www.it.cornell.edu/services/managed_servers/howto/file_transfer/fileputty.cfm](http://www.it.cornell.edu/services/managed_servers/howto/file_transfer/fileputty.cfm).

<a id="stata"></a>
### Using Stata and Matlab
If you are connecting through VNC, you can open Stata and MATLAB directly from GNOME. They are found in the 'Other' catagory, when you click the Applications button in the top left.

<a href="http://i.imgur.com/UcNNs6y.png">
  <img src="http://imgur.com/UcNNs6yl.png" style="width: 300px" />
</a>

Loading a dataset will be the same as on your local machine, except that the directory structure is different. Depending on where you downloaded your dataset, it will be somewhere in your home directory (which is named after your user account). In the screenshot below, I'm looking at all the folders in my home directory, called 'adlai'.

<a href="http://i.imgur.com/6pXMDZr.png">
  <img src="http://imgur.com/6pXMDZrl.png" style="width: 300px" />
</a>

For MATLAB it works similarly; here's an example. 

<a href="http://i.imgur.com/W5ItbIv.png">
  <img src="http://imgur.com/W5ItbIvl.png" style="width: 300px" />
</a>

If you're connecting using SSH, you can use MATLAB and Stata through the command line by typing 

```
[adlai@turtle ~]$ /usr/local/stata14/xstata-mp
```

This can be a bit of a pain, so in order to create an executable link to stata in your home directory, type 
```
[adlai@turtle ~]$ ln -s /usr/local/stata14/xstata-mp stata14
```

Now you can just type `stata14` in the terminal when you're in your home directory to start Stata.

MATLAB is already a part of the path, so to start it you can just type `matlab`.

```
[adlai@turtle ~]$ matlab
```

<a id="detach"></a>
### Keeping Jobs Running on the Server after Logout
When you start a VNC server it will stay running until you log out (if you close your VNC viewer your VNC session stays running). If you log in with SSH, logging out will close any running jobs. To prevent this, you can use a terminal multiplexer.

Byobu, which is a wrapper for tmux, is my multiplexer of choice, and it's installed on the server. Without getting into the details, just type `byobu`, then the command you want to run (eg: `matlab -nodesktop -r divide_by_zero.m`), then hit F6 to detach byobu. Now you can log off the SSH session and MATLAB will keep running. When you log back into the server type `byobu` again to attach back to the session.

If you forget to use byobu, or realize you have to leave suddenly, you can still detach a running job. See here: [http://www.cyberciti.biz/faq/unix-linux-disown-command-examples-usage-syntax/](http://www.cyberciti.biz/faq/unix-linux-disown-command-examples-usage-syntax/).

See here for more information on using byobu: 

[http://www.howtogeek.com/58487/how-to-easily-multitask-in-a-linux-terminal-with-byobu/](http://www.howtogeek.com/58487/how-to-easily-multitask-in-a-linux-terminal-with-byobu/)

[https://help.ubuntu.com/community/Byobu](https://help.ubuntu.com/community/Byobu) 

<a id="nice"></a>
### Running Long jobs at Lower Priority
It's a good policy to lower priority for jobs that you will have running all night (or longer). A lower priority still means your job will run at top speed when the server is not under heavy load. 

Launch a command at a lower priority using the `nice` command (because using it makes you a nice person). The syntax is `nice [command]`, for example,

```
nice matlab -r max_unlikelihood.m
```

Jobs run without using nice have priority 0. The default value nice assigns is 10 (higher nice value means lower priority), but you can adjust this using the `-n` flag to any integer [0,19]. If you forgot to use nice when starting your job, you can use `renice` which changes the priority of a running process. See `man nice` and `man renice` for details.


<a id="software"></a>
### Downloading your own software
In order to keep security risks to a minimum, if you need any additional software you will need to download and install it in your home directory. This is not analogous to installing software on your personal laptop, which requires administrative privledges. 

Installing software in your home directory may entail downloading and compiling the source code for the program you want. Here are some best practices:

 1. Create a `bin/` directory in `$HOME`, and keep all your executable files there.
 2. Create a `tmp/` directory in `$HOME`, and do all your compiling and downloading there.

Check the guide here [https://luv.asn.au/overheads/compile.html](https://luv.asn.au/overheads/compile.html) on compiling source code on Linux/UNIX.

Here's a brief and somewhat contrived example of how to download the dropbox binary and link it to the `~/bin` directory.

```
[adlai@turtle ~]$ mkdir tmp bin
[adlai@turtle ~]$ cd tmp
[adlai@turtle tmp]$ wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
[adlai@turtle tmp]$ mv .dropbox-dist/ ../; cd
[adlai@turtle ~]$ ln -s /home/adlai/.dropbox-dist/dropboxd ~/bin/dropbox
[adlai@turtle ~]$ ./bin/dropbox 
```

<a id="linux"></a>
### The linux command line
Whether you have connected via SSH or VNC, you will eventually run into the linux command line. If you aren't already familiar with the command line it can be a bit daunting. While many stalwart linux users (myself included) tend to insist you learn the hard way - by reading huge manuals deep into the night - there are many resources available to familiarize yourself with how the command line works. The best strategy may be to google for one yourself until you find one that moves at a speed you're comfortable with. Below I present a brief introduction to the basics, largely adapted from web sources.


When you open a terminal you will be prompted with something like the following:

```
[adlai@turtle ~]$ 
```

The username and servername are self explanatory. The `~` refers to your current location (`~` means home directory). The $ is the prompt for entering a command.

The linux directory structure is defined relative to a root directory, which is denoted by `/`. Here's what the terminal looks like when you're in the root directory.

```
[adlai@turtle /]$ 
```

File and directory paths in UNIX use the forward slash `/` to separate directory names in a path. For example, 

```
/              "root" directory
/usr           directory usr (sub-directory of / "root" directory)
/usr/STRIM100  STRIM100 is a subdirectory of /usr
```

One of the first things you should do is change your password from the default. You can accomplish this with the passwd command.

Commands are entered into the terminal by typing the command name, followed by any arguments or flags you want to pass to the command. For example, the command `cd` is for change directory. If I want to change from the current directory to another (the root directory `/` for example), I would pass `/` as an argument by typing `cd /`. Here are some examples for navigating directories:


```
pwd               Show the "present working directory", or current directory.
cd                Change current directory to your HOME directory.
cd /home/adlai    Change current directory to your (my) HOME directory. 
cd init           Change current directory to init which is a sub-directory of the current 
                        directory.
cd ..             Change current directory to the parent directory of the current directory.
cd ~              Change the current directory to your home directory (same as cd /home/adlai)
```

Changing directories is all well and good but eventually you'll want to know the contents of the directories you're in. This is done with the `ls` command, for 'list'. Some examples:

```
ls           List current directory's contents
ls /         List the root directory's contents
ls -a        List the current directory including hidden files. Hidden files start 
             with "." 
ls -lh       List all the file and directory names in the current directory using 
             long format, with human-readable measures of file size (ie, Mb instead of bytes). 
```

Above I passed both arguments (the second example) and flags (the -a and -lh). Think of flags as function parameters, and arguments as function inputs. The single most important command you need in linux is the `man` command, for 'manual'. The manual page lists all the possible flags and arguments, with descriptions and often examples and even email addresses of the developers. The man command takes the application you want to learn about as its argument. So, to read more about `cp`, I would do:

```
[adlai@turtle ~]$ man cp
```

You navigate the man page by pressing `j` and `k` to move up and down, and when you're done hit `q` to exit back to the terminal.Here are some examples of other common tasks:

Moving, renaming, and copying files:

```
cp file1 file2          copy file1 to a new file called file2
mv file1 newname        move/rename file1 to newname 
mv file1 ~/AAA/         move file1 into sub-directory AAA in your home directory.
rm file1 [file2 ...]    remove or delete a file. In UNIX [ ] refers to optional arguments.
rm -r dir1 [dir2...]    delete the directory dir1 (dir2, dir3, ...) and everything inside it
mkdir dir1 [dir2...]    create directories
mkdir -p dirpath        create the directory dirpath, including all implied directories in the path.
rmdir dir1 [dir2...]    remove an empty directory
```

Viewing and editing files:

```
cat filename      Dump a file to the screen in ascii. 
more filename     Progressively dump a file to the screen: ENTER = one line down 
                  SPACEBAR = page down  q=quit
less filename     Like more, but you can use Page-Up too. Not on all systems. 
vi filename       Edit a file using the vi editor. All UNIX systems will have vi in some form. 
emacs filename    Edit a file using the emacs editor. Not all systems will have emacs. 
head filename     Show the first few lines of a file.
head -n  filename Show the first n lines of a file.
tail filename     Show the last few lines of a file.
tail -n filename  Show the last n lines of a file.
```

Searching for files: The find command

```
find location -name filename 

find . -name aaa.txt    Finds all the files named aaa.txt in the current directory or 
                        any subdirectory tree. 
find / -name stata      Find all the files named 'stata' anywhere on the system. 
find / -name stata 2>/dev/null
		        Find all the files named 'stata' anywhere on the system, ignoring
			any errors.
find /usr/ -name "*stata*"       
                        Find all files whose names contain the string 'stata' which 
                        exist within the '/usr/' directory tree. 
```

These are just the basics; the command line is a very powerful tool once you get the hang of it. If you'd like a gentler introduction there are slower, interactive tutorials, for example, here:
[http://linuxsurvival.com/wp/?page_id=5&id=0](http://linuxsurvival.com/wp/?page_id=5&id=0)

You can also type `man intro` into a terminal to see the official linux primer.

The rise of Ubuntu, a user-friendly linux distribution, has created wealth of answers to basic questions and newbie-friendly information. The Ubuntu forums are great places to look, and most of the information will also be applicable to CentOS.

<a id="res"></a>
### Other resources 

For in-house help you can contact the server administrator Masaru at masaru.kiyota@ubc.ca or me at adlai.newson@gmail.com.

There are a lot of resources out there for Linux, look for one that you like. Additionally, here are some particular resources:

* GNOME is the graphical desktop environment you see when you log into the VNC server. Here's the wiki [https://en.wikipedia.org/wiki/GNOME]().
* vim is the best text editor ever written, bar none. There are a ton of tutorials on the web, here's one: [https://danielmiessler.com/study/vim/]() 
* Arch linux (a different linux distribution, and my personal choice) has a very good wiki. Much of it will also be applicable to the server: [https://wiki.archlinux.org/]()
* Because CentOS is a RedHat-based distribution, you can also look at RedHat resources
