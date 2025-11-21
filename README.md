How to use this: 
- The script is a basic shell script. Ensure it is made executable for your user/group via a chmod 755 command on your local machine.
- The sample app.ns.conf file is provided for reference. 
- The script expects a file name as the one option. The filename should be an /nsconfig/ns.conf file from the Netscaler to be migrated.
    - Example: ./ns_scope_script.sh app.ns.conf
- If there are administrative partitions on the Netscaler each one has to be evaluated independently.
    - Each administrative partition will have its own ns.conf: /nsconfig/partition1/ns.conf as an example. 
