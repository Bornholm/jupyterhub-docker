#!/bin/bash

set -e

USERNAME=$1

source /srv/jupyterhub/tutor.conf

if [ -z "$USERNAME" ]; then
  echo "You must provide a valid username as first argument !" 1>&2
  exit 1
fi

PASSWORD=$(< /dev/urandom tr -dc A-Za-z0-9 | head -c10; echo)

echo -e "$PASSWORD\n$PASSWORD\n" | adduser -q --gecos "" $USERNAME

# Expose student work to tutor
mkdir -p /home/$TUTOR_USERNAME/students
ln -s /home/$USERNAME /home/$TUTOR_USERNAME/students/$USERNAME
chown $TUTOR_USERNAME: /home/$TUTOR_USERNAME/students/$USERNAME

#Expose tutor's lessons to student
mkdir -p /home/$TUTOR_USERNAME/lessons
chown $TUTOR_USERNAME: /home/$TUTOR_USERNAME/lessons
ln -s /home/$TUTOR_USERNAME/lessons /home/$USERNAME/lessons

chown $USERNAME: /home/$USERNAME

echo "Student '$USERNAME' created. Its password is '$PASSWORD'."
