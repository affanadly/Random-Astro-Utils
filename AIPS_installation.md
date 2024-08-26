# AIPS Installation

This is a guide to installing AIPS Classic, DIFMAP, and ParselTongue on a Ubuntu 22.04 VM, assuming the host is a Windows machine running Oracle VM Virtualbox. The guide also includes instructions for setting up remote AIPS access and X11 forwarding, allowing for the use of AIPS by SSHing into a headless VM from the Windows host.

## AIPS Classic

1. Install pre-requisites for Ubuntu 22.04

    ```bash
    sudo apt-get install -y cvs gfortran libncurses-dev openssh-client openssh-server printer-driver-cups-pdf xterm
    ```

2. Download latest version of AIPS installer (31DEC24) into a directory that will be the AIPSROOT

    ```bash
    wget -nc http://www.aips.nrao.edu/31DEC24/install.pl
    ```

3. Execute the installer script with Perl

    ```bash
    chmod u+x install.pl
    perl install.pl -n
    ```

4. AIPS installation parameters
    * Screen 5: Site Name - aips
    * Screen 8: Printers - Press D to discover printers, then set printer type to COLOR, printer paper to A4
    * Accept defaults on everything else

5. Add the following login script to `~/.bashrc`

    ```bash
    . /home/aips/aipsroot/LOGIN.SH
    ```

6. Add AIPS servers to UNIX network by adding the following to `/etc/services`

    ```bash
    sssin           5000/tcp        SSSIN      # AIPS TV server
    ssslock         5002/tcp        SSSLOCK    # AIPS TV Lock
    msgserv         5008/tcp        MSGSERV    # AIPS Message Server
    tekserv         5009/tcp        TEKSERV    # AIPS TekServer
    aipsmt0         5010/tcp        AIPSMT0    # AIPS remote FITS disk access
    aipsmt1         5011/tcp        AIPSMT1    # AIPS remote tape 1
    aipsmt2         5012/tcp        AIPSMT2    # AIPS remote tape 2
    aipsmt3         5013/tcp        AIPSMT3    # AIPS remote tape 3
    aipsmt4         5014/tcp        AIPSMT4    # AIPS remote tape 4
    aipsmt5         5015/tcp        AIPSMT5    # AIPS remote tape 5
    aipsmt6         5016/tcp        AIPSMT6    # AIPS remote tape 6
    aipsmt7         5017/tcp        AIPSMT7    # AIPS remote tape 7
    ```

## DIFMAP

1. Install pre-requisites for Ubuntu 22.04

    ```bash
    sudo apt-get install -y build-essential fort77 gawk gfortran libncurses-dev libx11-dev make pgplot5
    ```

2. Download latest version of DIFMAP installer (2.5q) into a preferred directory (e.g. home directory)

    ```bash
    wget -nc ftp://ftp.astro.caltech.edu/pub/difmap/difmap2.5q.tar.gz
    ```

3. Extract the tarball

    ```bash
    tar -xvzf difmap2.5q.tar.gz
    ```

4. Enter the uvf_difmap directory, configure, and compile difmap

    ```bash
    cd uvf_difmap_2.5q
    ./configure linux-ia64-gcc
    ./makeall
    ```

5. Add the following login script to `~/.bashrc`

    ```bash
    export PATH=$PATH:/home/aips/uvf_difmap_2.5q/
    ```

## ParselTongue

Assuming Python 3 is already installed and fully set up, install ParselTongue using the following commands:

```bash
sudo add-apt-repository ppa:kettenis-w/parseltongue
sudo apt-get update
sudo apt-get install python3-parseltongue
```

## AIPS Remote

For remote AIPS, set port forwarding in the VM:

* Protocol: TCP
* Host IP: 127.0.0.XXX
* Host Port: 22
* Guest IP: 10.0.2.15
* Guest Port: 22

To access using a Windows machine, install VcXsrv and PuTTY. Launch VcXsrv in multi-window mode.

In PuTTY, set the hostname to 127.0.0.XXX with port 22. Set the following settings:

* Window - Appearance - Cursor appearance - Vertical line
* Window - Appearance - Cursor appearance - Cursor blink (true)
* Window - Appearance - Font settings - Font: Courier New, 11-point
* Window - Selection - Control use of mouse - Windows (Middle extends, Right brings up menu)
* Window - Selection - Assign copy/paste actions to clipboards - Ctrl + Shift + {C, V} for System clipboard, no action for others
* Connection - SSH - X11 - Enable X11 forwarding (true)

For first time runs, create the ~/.Xdefaults file with the following content:

```bash
AIPStv*geometry: 800x800+0+0
AIPStv*xPixels: 850
AIPStv*yPixels: 850
AIPStv*charMult: 1
AIPSmsg*background: black
AIPSmsg*foreground: white
AIPSmsg*faceName: Courier New
AIPSmsg*faceSize: 9
AIPStek*background: black
AIPStek*foreground: white
AIPStek*faceName: Courier New
AIPStek*faceSize: 9
```

Also, create an empty ~/.Xauthority file.
