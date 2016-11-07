FROM jupyterhub/jupyterhub

ARG HTTP_PROXY=
ARG HTTPS_PROXY=
ARG http_proxy=
ARG https_proxy=

ARG TUTOR_USERNAME=tutor
ARG TUTOR_PASSWORD=tutor

RUN apt-get update -y \
  && apt-get install -y curl ca-certificates \
  && curl -sL https://deb.nodesource.com/setup_6.x | bash - \
  && apt-get install -y nodejs libzmq3-dev mcrypt

RUN pip install jupyter

RUN npm install -g ijavascript \
  && ijs --ijs-install=global

RUN useradd -m $TUTOR_USERNAME \
  && echo "$TUTOR_USERNAME:$TUTOR_PASSWORD" | chpasswd

RUN mkdir -p /home/$TUTOR_USERNAME/lessons \
  && mkdir -p /home/$TUTOR_USERNAME/students \
  && chown -R $TUTOR_USERNAME: /home/$TUTOR_USERNAME

RUN echo "TUTOR_USERNAME=$TUTOR_USERNAME" > /srv/jupyterhub/tutor.conf

ADD create-hub-student.sh /usr/local/bin/create-hub-student
RUN chmod +x /usr/local/bin/create-hub-student

RUN mkdir -p /etc/jupyterhub \
  && cd /etc/jupyterhub \
  && jupyterhub --generate-config \
  && sed -i "s/^#c.Authenticator.admin_users = set()$/c.Authenticator.admin_users = set(['$TUTOR_USERNAME'])/" jupyterhub_config.py \
  && sed -i "s/^#c.LocalAuthenticator.create_system_users = False$/c.LocalAuthenticator.create_system_users = True/" jupyterhub_config.py \
  && sed -i "s/^#c.LocalAuthenticator.add_user_cmd = \[\]$/c.LocalAuthenticator.add_user_cmd = ['\/usr\/local\/bin\/create-hub-student']/" jupyterhub_config.py

CMD ["jupyterhub", "--config", "/etc/jupyterhub/jupyterhub_config.py"]
