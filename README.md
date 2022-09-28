# moodle_opencast_ubuntu_vm
This repository contains information about setting up an Ubuntu-VM for Moodle development with Opencast
as well as helper script, to make this process straightforward. In the following guide VirtualBox is used
as virtualization software.

## Create the Ubuntu-VM with VirtualBox
To create an Ubuntu-VM with VirtualBox, do the following steps:
1. Download (from *https://www.virtualbox.org*) and install VirtualBox.
2. Download an Ubuntu image (*iso* file from *https://ubuntu.com/download/desktop*).
3. Start VirtualBox and create a new virtual machine:
   1. Name and operating system:
      1. Choose a name. 
      2. Choose a machine folder: This is where your virtual machines will be stored, so you can
         resume working on them whenever you like.
      3. Type: Linux
      4. Version: Ubuntu (64-bit)
   2. Memory size:
      1. Select the amount of RAM from your main PC, that the virtual machine will access. Be sure
         to remain inside the green bar, to ensure you can continue to work outside of the VM
         whilst it’s running.
   3. Hard disk:
      1. Select *Create a virtual hard disk now*.
   4. Hard disk file type:
      1. Select *VDI (VirtualBox Disk Image)*.
   5. Storage on physical hard disk:
      1. Select *Dynamically allocated*.
   6. File location and size:
      1. Choose a path for the virtual hard disk file (default is okay). 
      2. Choose a size for the virtual hard disk.
4. Install the Ubuntu image:
   1. Launch the newly created virtual machine.
   2. Select the downloaded Ubuntu image (*iso* file).
   3. Click *Start*.
   4. Select *Try or Install Ubuntu* from the boot menu.
   5. Install Ubuntu Desktop normally:
      1. Choose a language.
      2. Select *Install Ubuntu*.
      3. Choose a keyboard layout.
      4. Choose *Normal installation* and check *Download updates while installing Ubuntu*.
      5. Choose *Erase disk and install Ubuntu* and click *Install Now*.
      6. Click *Continue*.
      7. Select a location.
      8. Create your account (e.g., username is *Your name* and password is *admin* as well as
         select *Log in automatically*).
      9. Click *Restart Now* after installation.
      10. Press *Enter*, when you see the text *Please remove installation medium, then press
          ENTER*.
      11. Select your desired settings in the windows, that are shown after the first login.
      12. If there are a software updates, install them and restart the VM, if required.
   6. Change the screen resolution to a fitting one:
      1. In the Ubuntu-VM, go to *Settings -> Displays* and change the resolution to a fitting one (the
         VirtualBox window for this Ubuntu-VM will have this size).

In addition, it is very helpful for a better performance of the complete VM, to increase the amount
of processor cores under *Settings -> System -> Processor*.

Furthermore, it is useful to apply the following power settings (under *Settings -> Power*),
if the VM is used as a server, for a better performance:<br><br>
<img src="README_images/vm_power_settings.png" alt="VM power settings" />

