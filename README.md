# web-test-docker from ShinC

# Web test

http://shinc07.ddns.net/

# Webhooks

```bash
http://<ip>:<port>/github-webhook/
```

# Jenkins execute shell

```bash
find /var/lib/jenkins/workspace/<ten-job> -mindepth 1 -maxdepth 1 -exec scp -r {} root@<ip-docker-server>:~/project/ \;
ansible-playbook /var/lib/jenkins/playbook/deployment.yaml
```

# Deployment file

```bash
-   name: Build Python web
    hosts: <ten-host-trong-file-/etc/ansible/hosts>
    gather_facts: false
    remote_user: root
    tasks:

      -   name: Stop container
          docker_container:
            name: web-test-docker
            image: shinc07/web-test-docker:latest
            state: stopped

      -   name: Remove container
          docker_container:
            name: shinc07/web-test-docker:latest
            state: absent

      -   name: Remove Docker image
          docker_image:
            name: shinc07/web-test-docker:latest
            force_absent: true
            state: absent

      -   name: Build Docker image
          docker_image:
            name: shinc07/web-test-docker:latest
            source: build
            build:
              path: ~/project/
            state: present

      -   name: Create new container
          docker_container:
            name: web-test-docker
            image: shinc07/web-test-docker:latest
            ports:
              - "80:8080"
            state: started
```

