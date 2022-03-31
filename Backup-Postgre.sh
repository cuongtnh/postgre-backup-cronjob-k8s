#!/bin/bash

export PGHOST= #Postgre URL
export PGUSER= #Login account
export PGPASSWORD= #Password
export PGPORT=5432

# Location to place backups.
mkdir pg_backup
backup_dir="/pg_backup"

#String to append to the name of the backup files
backup_date=`date +%Y-%m-%d-%H%M`

#Numbers of days to keep copie of databases
number_of_days=30

#List all databases
databases=`psql -l -t | cut -d'|' -f1 | sed -e 's/ //g' -e '/^$/d'`

#Backup each database
for i in $databases; do 
    if [ "$i" != "postgres" ] && [ "$i" != "template0" ] && [ "$i" != "template1" ] && [ "$i" != "template_postgis" ]; then     
        echo Dumping $i to $backup_dir/$i\_$backup_date.sql    
        pg_dump $i > $backup_dir/$i\_$backup_date.sql
        #bzip2 $backup_dir$i\_$backup_date.sql
        #ln -fs $backup_dir$i\_$backup_date.sql.bz2 $nightly_dir$i-nightly.sql.bz2
    fi
done


#Remove old backups

find $backup_dir -type f -prune -mtime +$number_of_days -exec rm -f {} \;
echo "Backup completed, remove backup older than 30 days"
